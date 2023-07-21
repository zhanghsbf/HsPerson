package com.roy.personaeng.util

import com.roy.personaeng.common.Constant
import org.apache.spark.SparkConf

import java.text.SimpleDateFormat
import java.util.{Date, Properties}

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
object ComUtil {
  def getSparkConfig(appName: String):SparkConf = {
    val conf = new SparkConf()
    conf.setAppName(appName)
//    if(!Constant.RUN_MODEL.equals("")){
//      conf.setMaster("")
//    }
    conf
  }


  def initParams():Unit ={
    try{
      val prop = new Properties()
      prop.load(ComUtil.getClass.getResourceAsStream("/params.properties"))
      Constant.ES_ADDRESS = prop.getProperty("es.address")
      Constant.ES_DB_NAME = prop.getProperty("es.dbname")
      Constant.HDFS_PATH = prop.getProperty("hdfs.path")
      Constant.HDFS_DATAROOTPATH = prop.getProperty("hdfs.dataRootPath")
      Constant.DB_URL = prop.getProperty("db.url")
      Constant.DB_USERNAME = prop.getProperty("db.username")
      Constant.DB_PASSWORD = prop.getProperty("db.password")
      Constant.DB_DRIVER = prop.getProperty("db.driver")
      Constant.LOG_LEVEL = prop.getProperty("log.level")
      Constant.SPARK_SYSTEM_TYPE = prop.getProperty("spark.systemtype")
    }catch{
      case e: Exception =>
          e.printStackTrace()
    }
  }

  /**
   * 将时间转为字符串形式的日期
   * @param date : 被转换的时间
   * @return 字符串日期
   */
  def getDateStrFromDate(date: Date): String = {
    val sdf = new SimpleDateFormat("yyyy-MM-dd")
    sdf.format(date)
  }

  /**
   * 将字符串日期转为Long型的天数值
   * @param dateStr : 日期字符串
   * @return 天数值
   */
  def getDateLongFromStr(dateStr: String): Long = {
    var time: Long = 0
    var i: Int = 0
    val fmt = Array("yyyy-MM-dd", "yyyyMMdd", "yyyy/MM/dd")
    while (time == 0 && i < fmt.length) {
      val sdf = new SimpleDateFormat(fmt(i))
      try {
        time = sdf.parse(dateStr).getTime
      } catch {
        case e: Exception =>
      }
      i = i + 1
    }
    time / (1000 * 3600 * 24)
  }

  /**
   * 将字符串日期转为Long型的秒值
   * @param dateStr : 日期字符串
   * @return 秒值
   */
  def getTimeLongFromStr(dateStr: String): Long = {
    var time: Long = 0
    var i: Int = 0
    val fmt = Array("yyyy-MM-dd HH:mm:ss", "yyyyMMddHHmmss", "yyyy/MM/dd HH:mm:ss", "yyyy-MM-dd", "yyyyMMdd", "yyyy/MM/dd")
    while (time == 0 && i < fmt.length) {
      val sdf = new SimpleDateFormat(fmt(i))
      try {
        time = sdf.parse(dateStr).getTime
      } catch {
        case e: Exception =>
      }
      i = i + 1
    }
    time / 1000
  }
}
