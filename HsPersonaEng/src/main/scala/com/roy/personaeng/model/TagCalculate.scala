package com.roy.personaeng.model

import com.roy.personaeng.base.BaseData

import java.sql.Timestamp

/**
 *
 * @author roy
 * @date 2021/12/15
 * @desc
 */
class TagCalculate extends BaseData {
  var id: String = null
  var userId: String = null
  var userName: String = null
  var name: String = null
  var dataPath: String = null
  var createDate: Timestamp = null
  var startDate: Timestamp = null
  var endDate: Timestamp = null
  var logs: String = null
  var enable: String = null

  override val fields = Array("id", "userId", "userName", "name", "dataPath", "createDate", "startDate", "endDate", "logs", "enable")

}
