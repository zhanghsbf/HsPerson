package com.roy.personaeng.util

import com.roy.personaeng.common.Constant

import scala.collection.mutable.ArrayBuffer
import scala.util.parsing.json.JSON

/**
 *
 * @author roy
 * @date 2021/12/15
 * @desc
 */
object CalculateUtil {
  case class RuleEntity(splitArray: Array[String], result: String)

  /**
   * 范围规则型计算标签，以一条记录为单位计算
   * @param dataMap : 被打标的数据
   * @param ruleList : 打标规则
   * @return 打标结果
   */
  def calculateRangeRule(dataMap: Map[String, Any], ruleList: Array[RuleEntity]): String = {
    var result: String = ""
    var jjccResultMap = Map[String, String]() //加减乘除四则运算结果Map，计算过的公式不必要再计算一次，所以存起来
    Log.debug(" dataMap is " + dataMap)

    /** 譬如：按年龄分老年/中年/青年/少年，下面循环判断符合哪个年，匹配上就跳出 */
    var i = 0
    while (i < ruleList.length) {
      //一次循环为一条规则下的一种情况
      val array = ruleList(i).splitArray
      for (j <- array.indices) {
        array(j) = array(j).trim
      }
      val replaceArray = new ArrayBuffer[String]
      Log.debug("the array of sql to be split is : " + array.mkString(" | "))
      var j = 0
      var haveNullValue = false
      while (j < array.length) {
        /*
         * 将规则中的字段名替换为实际的数据，用于计算
         * 只有属性才被替换，譬如age>30，只有age被替换,30不被替换，即只有操作符左边的被替换
         */

        //如果指针到了最后一个，就不需要再处理,因为最后一个肯定不是要替换的字段
        //这里的判断目的是为了在下一个if分支用+1时不报错
        if (j == array.length - 1) {
          replaceArray += array(j)
        } else if (Constant.expressArray.contains(array(j + 1))) {
          //如果是运算符，则左侧必须要被替换，右侧不需要替换
          //计算过的公式结果会存在Map中，该条记录中再碰到该公式就直接取
          if (jjccResultMap.get(array(j)).isEmpty) {
            jjccResultMap = FormulaUtil.getReplaceMap(array(j), jjccResultMap, dataMap) //将需要替换的东西对应的值做出来，放在map中
            val replaceValue = FormulaUtil.getReplaceValue(array(j), jjccResultMap)
            replaceArray += replaceValue
            jjccResultMap += (array(j) -> replaceValue)
            //如果有空值则做个标记，后面不再为此条数据打该标签，该循环也直接跳出，否则继续
            if (replaceValue == null) {
              haveNullValue = true
              j = array.length
            }
          } else {
            //如果存在map中，则直接获取替换
            replaceArray += jjccResultMap.get(array(j)).get
          }
        } else {
          //否则直接引用，不替换
          replaceArray += array(j)
        }
        j = j + 1
      }
      Log.debug("the array of data to be calculated is : " + replaceArray.mkString(" | "))
      //如果有空值，则直接返回-1，表示不计算该标签
      if (haveNullValue) {
        result = "-1"
        i = ruleList.length
      } else if (ExpressUtil.excuteRule(replaceArray)) {
        result = ruleList(i).result
        i = ruleList.length
      }
      i = i + 1
    }
    result
  }

  /**
   * 根据公式字符串formula计算dataMap提供的数据，返回计算结果
   * @param formula : 公式字符，关键分割点用\u0003分开
   * @param dataMap : 数据Map
   * @return 计算结果
   */
  def calculateFormula(formula: String, dataMap: Map[String, Any]): String = {
    //将formula放到JSON中再取出来，虽然没做任何转换，但可以将\u0003转为真正的特殊字符，否则会认为是\u0003
    val formulaJson = JSON.parseFull("{\"formula\":\"" + formula + "\"}")
    val formulaMap = formulaJson.get.asInstanceOf[Map[String, String]]
    val formulaStr = formulaMap.get("formula").get
    val jjccResultMap = FormulaUtil.getReplaceMap(formulaStr, Map[String, String](), dataMap)
    FormulaUtil.getReplaceValue(formulaStr, jjccResultMap)
  }
}
