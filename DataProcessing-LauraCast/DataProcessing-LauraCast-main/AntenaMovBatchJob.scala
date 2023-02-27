package ProyectoLaura.batch
import org.apache.spark.sql.{DataFrame, SaveMode, SparkSession}

import java.time.OffsetDateTime
import org.apache.spark.sql.functions._

object AntenaMovBatchJob extends BatchJob {

  override val spark: SparkSession = SparkSession
    .builder()
    .master("local[20]")
    .appName("Final Project Laura_Castaño")
    .getOrCreate()

  import spark.implicits._


  override def readFromStorage(storagePath: String, filterDate: OffsetDateTime): DataFrame = {

    spark
      .read
      .format("parquet")
      .load(s"$storagePath/data")
      .filter( $"year" === filterDate.getYear &&
        $"month" === filterDate.getMonthValue &&
        $"day" === filterDate.getDayOfMonth &&
        $"hour" === filterDate.getHour
      )

  }

  override def readAntennaMetadata(jdbcURI: String, jdbcTable: String, user: String, password: String): Unit = {
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
      .groupBy($"antenna_id", window($"timestamp", "1 hour").as("window"))
      .agg(sum($"bytes")).as("totalBytesByAntenna")


  }

  override def bytesByUser(dataFrame: DataFrame): DataFrame = {
    dataFrame
      .filter(sum($"bytes"))
      .select($"timestamp", $"bytes", $"id")
      .groupBy($"id", window($"timestamp", "1 hour").as("window"))
      .agg(sum($"bytes")).as("totalBytesByUser")

  }

  override def bytesByApp(dataFrame: DataFrame): DataFrame = {
    dataFrame
      .filter(sum($"bytes"))
      .select($"timestamp", $"bytes", $"app")
      .groupBy($"app", window($"timestamp", "1 hour").as("window"))
      .agg(sum("bytes")).as("totalBytesByApp")

  }

    .select($"antenna_id", $"window.start".as("StartDate"), $"bytes", $"bytes_id_count", $"bytes_app_count")

  def bytesByQuota(dataFrame: DataFrame): DataFrame ={

  dataFrame
      .filter($"quota")
      .select($"timestamp", $"bytes", $"quota", $"email")
      .groupBy($"email", window($"timestamp", "1 hour").as("window"))
      .agg(
        max(("bytes")).as("maxBytesHour")
  }

  override def writeToJdbc(dataFrame: DataFrame, jdbcURI: String, jdbcTable: String, user: String, password: String): Unit = {
    dataFrame
      .write
      .mode(SaveMode.Append)
      .format(source = "jdbc")
      .option("url", jdbcURI)
      .option("dbtable", jdbcTable)
      .option("user", user)
      .option("password", password)
      .save()
  }

  override def writeToStorage(dataFrame: DataFrame, storageRootPath: String): Unit = {
    dataFrame
      .write
      .format(source = "parquet")
      .partitionBy("year", "month", "day", "hour")
      .mode(SaveMode.Overwrite)
      .save(s"$storageRootPath/historical")
  }

  override def main(args: Array[String]): Unit = {

    val offsetDateTime = OffsetDateTime.parse("2022-11-01T13:10:00Z")
    val parquetDF = readFromStorage("/tmp/devices_parquet", offsetDateTime)

    val metadataDF = readAntennaMetadata("jdbc:postgresql://$34.133.200.140:5432/postgres",
      "user_metadata",
      "postgres",
      "keepcoding")
    val antennaMetadataDF = enrichAntennaWithMetadata(parquetDF, metadataDF).cache()
    val aggByAntennaDF = bytesByAntenna(antennaMetadataDF)
    val aggByUserDF = bytesByUser(antennaMetadataDF)
    val aggByAppDF = bytesByApp(antennaMetadataDF)
    val val aggUserQuotaDF = bytesByQuota(antennaMetadataDF)

    writeToJdbc(aggByAntennaDF, "jdbc:postgresql://$34.133.200.140:5432/postgres",
      "antennamov_agg",
      "postgres",
      "keepcoding")
    writeToJdbc(aggByUserDF, "jdbc:postgresql://$34.133.200.140:5432/postgres",
      "antenna_mail_agg",
      "postgres",
      "keepcoding")
    writeToJdbc(aggByAppDF, "jdbc:postgresql://$34.133.200.140:5432/postgres",
      "antenna_app_agg",
      "postgres",
      "keepcoding")
    writeToJdbc(aggUserQuotaDF, "jdbc:postgresql://$34.133.200.140:5432/postgres",
      "antenna_1h_quota_agg",
      "postgres",
      "keepcoding")

    writeToStorage(parquetDF, "/tmp/devices_parquet"))


  }

}

