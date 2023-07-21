package com.roy.personaeng.service

import com.roy.personaeng.base.BaseService
import com.roy.personaeng.model.EtlJsonTableConfig
import com.roy.personaeng.base.BaseService

import scala.collection.mutable.ArrayBuffer

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
class EtlJsonTableConfigService extends BaseService{

  val tableName = "etl_json_table_config"

  /**
   * 根据ETL配置ID获取相关的配置表
   * @return :ETL配置表列表数据
   */
  def getEtlJsonTableConfigsByConfigId(configId: String): Array[EtlJsonTableConfig] = {
    val condition = ArrayBuffer("configId = ('" + configId + "') ")
    val data = this.find(this.tableName, condition)
    val result = ArrayBuffer[EtlJsonTableConfig]()
    for (i <- data.indices) {
      result += (new EtlJsonTableConfig).fromRow(data(i))
    }
    result.toArray
  }
}
