package com.roy.personaeng.common

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
object Constant {
  var ES_ADDRESS = ""
  var ES_DB_NAME = ""
  var HDFS_PATH = ""
  var SPARK_SYSTEM_TYPE = "centos"
  var RUN_MODEL = ""
  var HDFS_DATAROOTPATH = ""

  var DB_URL = ""
  var DB_USERNAME = ""
  var DB_PASSWORD = ""
  var DB_DRIVER = ""
  var LOG_LEVEL = "INFO"
  val SPLIT_CHAR_EXPRESS = "\t"
  val SPLIT_CHAR_FORMULA = "\u0003"
  val SPLIT_CHAR_INNER_EXPRESS = "\u0004"
  val SPLIT_CHAR_INNER_FORMULA = "\u0005"
  //与HsPersona的Constant.DATA_SPLIT对应
  val SPLIT_CHAR = "\02"

  val DATA_ROOT_PATH = "dataRootPath"

  val operateArray = Array("+", "-", "*", "/")
  val bracketArray = Array("(", ")")
  val expressArray = Array(">", "<", ">=", "<=", "!=", "=", "like")

  val runDateStr = "${runDate}"
}
