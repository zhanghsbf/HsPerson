package com.roy.personaeng.service

import com.roy.personaeng.base.BaseService
import com.roy.personaeng.model.TagCalculateSelect

import scala.collection.mutable.ArrayBuffer

/**
 *
 * @author roy
 * @date 2021/12/15
 * @desc
 */
class TagCalculateSelectService extends BaseService{
  val tableName = "tag_calculate_select"

  /**
   * 根据计算配置ID获取该配置所选择的标签
   * @param calculateId : 计算配置ID
   * @return : 属于该结算配置的计算标签
   */
  def getTagCalculateSelectByCalculateId(calculateId: String): Array[TagCalculateSelect] = {
    val condition = ArrayBuffer("calculateId='" + calculateId + "'")
    val data = this.find(this.tableName, condition)
    val result = ArrayBuffer[TagCalculateSelect]()
    for (i <- data.indices) {
      result += (new TagCalculateSelect).fromRow(data(i))
    }
    result.toArray
  }
}
