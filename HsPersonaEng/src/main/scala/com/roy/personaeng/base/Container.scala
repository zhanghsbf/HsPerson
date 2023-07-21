package com.roy.personaeng.base

import org.apache.spark.SparkContext
import org.apache.spark.sql.SparkSession

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
object Container {
  var sparkContext: SparkContext = null
  var dataRootPath: String = null
  var sparkSession: SparkSession = null
}
