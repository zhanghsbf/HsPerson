package com.roy.personaeng.model

import com.roy.personaeng.base.BaseData

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
class SysParam extends BaseData{
  var id: String = null
  var code: String = null
  var memo: String = null
  var value: String = null
  var enable: Integer = 0

  override val fields = Array("id", "code", "memo", "value", "enable")
}
