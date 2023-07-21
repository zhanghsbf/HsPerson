package com.roy.personaeng.service

import com.roy.personaeng.base.BaseService
import com.roy.personaeng.model.EtlJsonConfig

import scala.collection.mutable.ArrayBuffer

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
class EtlJsonConfigService extends BaseService{

  val tableName = "etl_json_config"

  /**
   * 根据用主键ID获取ETL配置
   * @return : ETL配置数据
   */
  def getEtlJsonConfigById(id: String): EtlJsonConfig = {
    val condition = ArrayBuffer("id='" + id + "'")
    val data = this.find(this.tableName, condition)
    if (data.length == 0) {
      null
    } else {
      (new EtlJsonConfig).fromRow(data(0))
    }
  }

  /**
   * 更新ETL日志
   * @param id : ETL配置ID
   * @param logs : 日志信息
   */
  def updateEtlJsonConfigLog(id: String, logs: String): Unit = {
    val set = s"logs = '$logs'"
    val condition = s"id = '$id'"
    this.update(tableName, set, condition)
  }
}
