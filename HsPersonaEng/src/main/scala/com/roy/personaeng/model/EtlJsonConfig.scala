package com.roy.personaeng.model

import com.roy.personaeng.base.BaseData

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
class EtlJsonConfig extends BaseData{
  var id: String = null
  var userId: String = null
  var userName: String = null
  var etlName: String = null
  var typeName: String = null
  var primaryTableFileName: String = null
  var primaryTableKeyIndex: Integer = 0
  var primaryTableProperties: String = null
  var logs: String = null
  var industryType: Integer = 0
  var enable : String = null

  override val fields = Array("id", "userId", "userName", "etlName", "typeName", "primaryTableFileName", "primaryTableKeyIndex", "primaryTableProperties", "logs", "industryType","enable")
}
