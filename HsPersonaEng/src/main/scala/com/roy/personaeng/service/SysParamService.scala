package com.roy.personaeng.service

import com.roy.personaeng.base.BaseService
import com.roy.personaeng.model.SysParam

import scala.collection.mutable.ArrayBuffer

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
class SysParamService extends BaseService{

  val tableName = "sys_param"

  def getSysParamByCode(code: String): SysParam ={
    val condition = ArrayBuffer("code='"+code+"'")
    val data = this.find(this.tableName, condition)
    if(data.length == 0){
      null
    }else{
      (new SysParam).fromRow(data(0))
    }
  }
}
