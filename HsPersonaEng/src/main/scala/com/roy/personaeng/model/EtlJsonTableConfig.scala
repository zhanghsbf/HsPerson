package com.roy.personaeng.model

import com.roy.personaeng.base.BaseData

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
class EtlJsonTableConfig extends BaseData{
  var id: String = null
  var configId: String = null
  var keyName: String = null
  var fileName: String = null
  var typeName: String = null
  var properties: String = null
  var foreignKeyIndex: Integer = 0
  var mappingType: Integer = 0
  var memo: String = null

  override val fields = Array("id", "configId", "keyName", "fileName", "typeName", "properties", "foreignKeyIndex", "mappingType", "memo")
}
