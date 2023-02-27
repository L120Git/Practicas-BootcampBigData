package ProyectoLaura.batch

import java.sql.Timestamp
import java.time.OffsetDateTime
import scala.concurrent.ExecutionContext.Implicits.global
import scala.concurrent.duration.Duration
import scala.concurrent.{Await, Future}

import org.apache.spark.sql.{DataFrame, SparkSession}

case class AntennaMessage(year: Int, month: Int, day: Int, hour: Int, timestamp: Timestamp, id: String, metric: String, value: Long)

trait BatchJob {

  val spark: SparkSession

  def readFromStorage(storagePath: String, filterDate: OffsetDateTime): DataFrame

  def readAntennaMetadata(jdbcURI: String, jdbcTable: String, user: String, password: String): DataFrame

  def enrichAntennaWithMetadata(antennaDF: DataFrame, metadataDF: DataFrame): DataFrame

  def bytesByAntenna(frame: sql.DataFrame)(dataFrame: DataFrame): DataFrame

  def bytesByUser(frame: sql.DataFrame)(dataFrame: DataFrame): DataFrame

  def bytesByApp(dataFrame: DataFrame): DataFrame

  def bytesByQuota(dataFrame: DataFrame): DataFrame

  def writeToJdbc(dataFrame: DataFrame, jdbcURI: String, jdbcTable: String, user: String, password: String): Unit

  def writeToStorage(dataFrame: DataFrame, storageRootPath: String): Unit

  def run(args: Array[String]): Unit = {
    val Array(filterDate, storagePath, jdbcUri, jdbcMetadataTable, aggJdbcTable, aggJdbcErrorTable, aggJdbcPercentTable, jdbcUser, jdbcPassword) = args
    println(s"Running with: ${args.toSeq}")

    val antennaDF = readFromStorage(storagePath, OffsetDateTime.parse(filterDate))
    val metadataDF = readAntennaMetadata(jdbcUri, jdbcMetadataTable, jdbcUser, jdbcPassword)
    val antennaMetadataDF = enrichAntennaWithMetadata(antennaDF, metadataDF).cache()
    val aggByAntennaDF = bytesByAntenna(antennaMetadataDF)
    val aggByUserDF = bytesByUser(antennaMetadataDF)
    val aggByAppDF = bytesByApp(antennaMetadataDF)
    val aggUserQuotaDF = bytesByQuota(antennaMetadataDF)


    writeToJdbc(aggByAntennaDF, jdbcUri, aggJdbcTable, jdbcUser, jdbcPassword)
    writeToJdbc(aggByUserDF, jdbcUri, aggJdbcPercentTable, jdbcUser, jdbcPassword)
    writeToJdbc(aggByAppDF, jdbcUri, aggJdbcErrorTable, jdbcUser, jdbcPassword)
    writeToJdbc(aggUserQuotaDF, jdbcUri, aggJdbcErrorTable, jdbcUser, jdbcPassword)

    writeToStorage(antennaDF, storagePath)

    spark.close()
  }

  def bytesByUser(dataFrame: DataFrame): DataFrame

  def bytesByAntenna(dataFrame: DataFrame): DataFrame
}
