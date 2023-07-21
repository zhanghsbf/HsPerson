package com.roy.personaeng.util

import com.roy.personaeng.base.Container
import com.roy.personaeng.common.Constant
import com.roy.personaeng.model.EtlJsonTableConfig
import org.apache.spark.rdd.RDD

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
object EtlUtil {
  def getGroupDataFromFile(tableJsonConfig: EtlJsonTableConfig, userName: String): RDD[(String, Iterable[Map[String, String]])] = {
    val filePath = this.getFilePath(userName, tableJsonConfig.fileName)
    val properties = tableJsonConfig.properties.split(Constant.SPLIT_CHAR).map(line => {
      val data = line.split(",")
      (data(0).toInt, data(1))
    })
    val foreignKeyIndex = tableJsonConfig.foreignKeyIndex
    this.getDataRowFromFile(filePath).map(data => {
      val array = new Array[(String, String)](properties.length + 1)
      array(0) = ("@type", tableJsonConfig.typeName)
      for (i <- properties.indices) {
        array(i + 1) = (properties(i)._2, data(properties(i)._1))
      }
      val foreignKey = data(foreignKeyIndex)
      (foreignKey, array.toMap)
    }).groupByKey()
  }

  def getDataRowFromFile(filePath: String): RDD[Array[String]] = {
    Container.sparkContext.textFile(filePath).map(line => {
      line.split(Constant.SPLIT_CHAR,-1)
    }).filter(d=>d.length>1)
  }

  def getFilePath(userName: String, fileName: String): String = {
    Container.dataRootPath + "/" + userName + "/" +fileName
  }
}
