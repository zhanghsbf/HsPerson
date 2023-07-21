package com.roy.personaeng.model

import com.roy.personaeng.base.BaseData

/**
 *
 * @author roy
 * @date 2021/12/15
 * @desc
 */
class TagCalculateSelect extends BaseData{
  var id: String = null
  var calculateId: String = null
  var tagId: String = null
  var rule: String = null
  var tagContent: String = null

  override val fields = Array("id", "calculateId", "tagId", "rule", "tagContent")
}
