package ProyectoLaura.streaming

import java.sql.Timestamp
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration.Duration
import scala.concurrent.{Await, Future}

import org.apache.spark.sql.{DataFrame, SparkSession}

case class AntennaMessage(timestamp: Timestamp, id: String, value: String)

trait StreamingJob {

  val spark: SparkSession

  def readFromKafka(kafkaServer: String, topic: String): DataFrame

  def parserJsonData(dataFrame: DataFrame): DataFrame

  def readAntennaMetadata(jdbcURI: String, jdbcTable: String, user: String, password: String): DataFrame

  def enrichAntennaWithMetadata(antennaDF: DataFrame, metadataDF: DataFrame): DataFrame

  def bytesByAntenna (dataFrame: DataFrame): DataFrame

  def bytesByUser(dataFrame: DataFrame): DataFrame

  def bytesByApp(dataFrame: DataFrame): DataFrame

  def writeToJdbc(dataFrame: DataFrame, jdbcURI: String, jdbcTable: String, user: String, password: String): Future[Unit]

  def writeToStorage(dataFrame: DataFrame, storageRootPath: String): Future[Unit]

  def run(args: Array[String]): Unit = {
    val Array(kafkaServer, topic, jdbcUri, jdbcMetadataTable, aggJdbcTable, jdbcUser, jdbcPassword, storagePath) = args
    println(s"Running with: ${args.toSeq}")

    val kafkaDF = readFromKafka(kafkaServer, topic)
    val antennaDF = parserJsonData(kafkaDF)
    val metadataDF = readAntennaMetadata(jdbcUri, jdbcMetadataTable, jdbcUser, jdbcPassword)
    val antennaMetadataDF = enrichAntennaWithMetadata(antennaDF, metadataDF)
    val storageFuture = writeToStorage(antennaDF, storagePath)
    val aggByAntennaDF = bytesByAntenna(antennaMetadataDF)
    val aggByUserDF = bytesByUser(antennaMetadataDF)
    val aggByAppDF = bytesByApp(antennaMetadataDF)
    val aggFutureAntenna = writeToJdbc(aggByAntennaDF, jdbcUri, aggJdbcTable, jdbcUser, jdbcPassword)
    val aggFutureUser = writeToJdbc(aggByUserDF, jdbcUri, aggJdbcTable, jdbcUser, jdbcPassword)
    val aggFutureApp = writeToJdbc(aggByAppDF, jdbcUri, aggJdbcTable, jdbcUser, jdbcPassword)

    Await.result(Future.sequence(Seq(aggFutureAntenna, storageFuture)), Duration.Inf)
    Await.result(Future.sequence(Seq(aggFutureUser, storageFuture)), Duration.Inf)
    Await.result(Future.sequence(Seq(aggFutureApp, storageFuture)), Duration.Inf)

    spark.close()
  }

}
