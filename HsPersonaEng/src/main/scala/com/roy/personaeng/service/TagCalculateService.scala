package com.roy.personaeng.service

import com.roy.personaeng.base.BaseService
import com.roy.personaeng.model.TagCalculate

import java.text.SimpleDateFormat
import java.util.Date
import scala.collection.mutable.ArrayBuffer

/**
 *
 * @author roy
 * @date 2021/12/15
 * @desc
 */
class TagCalculateService extends BaseService{

  val tableName = "tag_calculate"

  /**
   * 根据计算配置ID获取计算配置信息
   * @param id : 计算配置ID
   * @return : 计算配置内容
   */
  def getTagCalculateById(id: String): TagCalculate = {
    val condition = ArrayBuffer("id='" + id + "'")
    val data = this.find(this.tableName, condition)
    if (data.length == 0) {
      null
    } else {
      (new TagCalculate).fromRow(data(0))
    }
  }

  /**
   * 修改某个计算配置对应记录的状态
   * @param id : 计算配置ID
   * @param logs : 计算日志
   */
  def updateTagCalculateLogs(id: String, logs: String) = {
    val sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
    val endDate = sdf.format(new Date())
    val set = s"logs = '$logs' ,endDate = '$endDate'"
    val condition = s"id = '$id'"
    this.update(tableName, set, condition)
  }
}
