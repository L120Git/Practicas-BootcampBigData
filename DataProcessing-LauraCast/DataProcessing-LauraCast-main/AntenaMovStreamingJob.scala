package ProyectoLaura.streaming

import scala.concurrent.ExecutionContext.Implicits.global
import org.apache.spark.sql.types.{LongType, StringType, StructField, StructType, TimestampType}
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession, types}
import org.apache.spark.sql.functions._

import scala.concurrent.{Await, Future}
import scala.concurrent.duration.Duration
import scala.reflect.internal.util.NoPosition.source

  object AntenaMovStreamingJob extends StreamingJob {
    override val spark: SparkSession = SparkSession
      .builder()
      .master("local[20]")
      .appName("Final Project Laura_Castaño")
      .getOrCreate()

    import spark.implicits._

    override def readFromKafka(kafkaServer: String, topic: String): DataFrame = {
      spark
        .readStream
        .format(source = "kafka")
        .option("kafka.bootstrap.servers", kafkaServer)
        .option("subscribe", topic)
        .load()

    }

    override def parserJsonData(dataFrame: DataFrame): DataFrame = {
      val jsonSchema = StructType(Seq(
        StructField("timestamp", TimestampType, nullable = false),
        StructField("id", StringType, nullable = false),
        StructField("antenna_id", LongType, nullable = false),
        StructField("bytes", LongType, nullable = false),
        StructField("app", StringType, nullable = false)
      )
      )

      dataFrame
        .select(from_json ($"antenna_id".cast(StringType),jsonSchema).as("json"))
        .select($"json.*")
    }

    override def readAntennaMetadata(jdbcURI: String, jdbcTable: String, user: String, password: String): DataFrame = {
      spark
        .read
        .format("jdbc")
        .option("url", jdbcURI)
        .option("dbtable", jdbcTable)
        .option("user", user)
        .option("pasword", password)
        .load()

    }

    override def enrichAntennaWithMetadata(antennaDF: DataFrame, metadataDF: DataFrame): DataFrame = {
      antennaDF.as("a")
        .join(metadataDF.as("b"),
          $"a.id" === $"b.id"
        )
        .drop("b.id")

    }

    override def bytesByAntenna(dataFrame: DataFrame): DataFrame = {
      dataFrame
        .filter($"bytes")
        .select($"timestamp", $"bytes", $"antenna_id")
        .withWatermark("timestamp", "1 minutes")
        .groupBy($"antenna_id", window($"timestamp", "5 minutes").as("window"))
        .agg(sum($"bytes")).as("totalBytesByAntenna")


    }
    def bytesByUser(dataFrame: DataFrame): DataFrame = {
      dataFrame
        .filter(sum($"bytes"))
        .select($"timestamp", $"bytes", $"id")
        .withWatermark("timestamp", "1 minutes")
        .groupBy($"id", window($"timestamp", "5 minutes").as("window"))
        .agg(sum($"bytes")).as("totalBytesByUser")

    }

    def bytesByApp(dataFrame: DataFrame): DataFrame = {
        dataFrame
          .filter(sum($"bytes"))
          .select($"timestamp", $"bytes", $"app")
          .withWatermark("timestamp", "1 minutes")
          .groupBy($"app", window($"timestamp", "5 minutes").as("window"))
          .agg(sum("bytes")).as("totalBytesByApp")

      }

          .select($"antenna_id",$"window.start".as("StartDate"), $"bytes", $"bytes_id_count", $"bytes_app_count" )


      override def writeToJdbc(dataFrame: DataFrame, jdbcURI: String, jdbcTable: String, user: String, password: String): Future[Unit] = Future {
        dataFrame
          .writeStream
          .foreachBatch {
            (batch: DataFrame, _: Long) => {
              batch
                .write
                .mode(SaveMode.Append)
                .format(source = "jdbc")
                .option("url", jdbcURI)
                .option("dbtable", jdbcTable)
                .option("user", user)
                .option("password", password)
                .save()
            }
          }
          .start()
          .awaitTermination()
      }

      override def writeToStorage(dataFrame: DataFrame, storageRootPath: String): Future[Unit] = Future {
        dataFrame
          .select(
            $"timestamp", $"id", $"antenna_id", $"bytes", $"app",
            year($"timestamp").as("year"),
            month($"timestamp").as("month"),
            dayofmonth($"timestamp").as("day"),
            hour($"timestamp").as("hour"),
          )
          .writeStream
          .format(source = "parquet")
          .option("path", s"$storageRootPath/data")
          .option("checkpointLocation", s"$storageRootPath/checkpoint" )
          .partitionBy("year", "month","day", "hour")
          .start()
          .awaitTermination()

      }

      def main(args: Array[String]): Unit = {
        //run(args)
        val kafkaDF = readFromKafka("34.125.55.44:9092", topic = "devices")
        val parsedDF = parserJsonData(kafkaDF)

        val storageFuture = writeToStorage(parsedDF, storageRootPath = "/tmp/devices_parquet")

        val metadataDF = readAntennaMetadata(
          "jdbc:postgresql://$34.133.200.140:5432/postgres",
          "user_metadata",
          "postgres",
          "keepcoding"

        )
        val enrichDF = enrichAntennaWithMetadata(parsedDF, metadataDF)

        val totalBytesByAntenna = bytesByAntenna(enrichDF)

        val totalBytesByUser = bytesByUser(enrichDF)

        val totalBytesByApp = bytesByApp(enrichDF)

        val jdbcFuture = writeToJdbc(totalBytesByAntenna, "jdbc:postgresql://$34.133.200.140:5432/postgres", "antennamov_agg", "postgres", "keepcoding")
        val jdbcFutureUser = writeToJdbc(totalBytesByUser, "jdbc:postgresql://$34.133.200.140:5432/postgres", "antenna_mail_agg", "postgres", "keepcoding")
        val jdbcFutureApp = writeToJdbc(totalBytesByApp, "jdbc:postgresql://$34.133.200.140:5432/postgres", "antenna_app_agg", "postgres", "keepcoding")

        Await.result(
          Future.sequence(Seq(storageFuture, storageFuture, jdbcFuture, jdbcFutureUser, jdbcFutureApp)), Duration.Inf
        )
        spark.close()

      }

    }



