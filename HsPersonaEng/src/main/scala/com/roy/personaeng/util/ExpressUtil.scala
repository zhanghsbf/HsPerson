package com.roy.personaeng.util

import com.roy.personaeng.common.Constant

import scala.collection.mutable.ArrayBuffer

/**
 *
 * @author roy
 * @date 2021/12/15
 * @desc
 */
object ExpressUtil {
  /**
   * 根据规范后的规则数组执行规则计算，返回true或false的结果
   * @param array : 规范后的规则数组
   * @return 返回true或false的结果
   */
  def excuteRule(array: ArrayBuffer[String]): Boolean = {
    var i: Int = 0
    //先将所有操作符进行计算，根据SQL的特点，操作符一轮就可以计算完毕
    while (i < array.length) {
      if (Constant.expressArray.contains(array(i))) {
        array(i) = this.calculate(array(i), array(i - 1), array(i + 1)).toString
        array.remove(i + 1)
        array.remove(i - 1)
        i = i - 1
      }
      i = i + 1
    }
    //1、对逻辑符and/or进行计算，如果逻辑符两端是true/false，则计算合并
    //2、去括号，如果true/false两端是括号，则直接丢掉括号
    //3、最多计算100次，避免规则错误，陷入死循环
    i = 0
    while (array.length != 1 && i < 100) {
      var j: Int = 0
      while (j < array.length) {
        if ("and".equals(array(j))) {
          if(("false".equals(array(j-1)) || "true".equals(array(j-1))) && ("false".equals(array(j+1)) || "true".equals(array(j+1)))){
            array(j) = (array(j - 1).toBoolean && array(j + 1).toBoolean).toString
            array.remove(j + 1)
            array.remove(j - 1)
            j = j - 1
          }
        } else if ("or".equals(array(j))) {
          if(("false".equals(array(j-1)) || "true".equals(array(j-1))) && ("false".equals(array(j+1)) || "true".equals(array(j+1)))) {
            array(j) = (array(j - 1).toBoolean || array(j + 1).toBoolean).toString
            array.remove(j + 1)
            array.remove(j - 1)
          }
        } else if ("true".equals(array(j)) || "false".equals(array(j))) {
          if ("(".equals(array(j - 1)) && ")".equals(array(j + 1))) {
            array.remove(j + 1)
            array.remove(j - 1)
            j = j - 1
          }
        }
        j = j + 1
      }
      i = i + 1
    }
    array(0).toBoolean
  }

  /**
   * 计算数据a和数据b，在操作符operate操作下的结果
   * @param operate : 操作符
   * @param a : 数据a
   * @param b : 数据b
   * @return 计算结果，true或false
   */
  def calculate(operate: String, a: String, b: String): Boolean = {
    if (operate.equals("=")) {
      //计算=，分字符串和数字两种类型
      if (b.startsWith("'")) {
        a.equals(b.replaceAll("'", ""))
      } else {
        a.toDouble == b.toDouble
      }
    } else if (operate.equals("!=")) {
      //计算!=，分字符串和数字两种类型
      if (b.startsWith("'")) {
        !a.equals(b.replaceAll("'", ""))
      } else {
        a.toDouble != b.toDouble
      }
    } else if (operate.equals(">")) {
      //计算>，分字符串和数字两种类型
      if (b.startsWith("'")) {
        a.compare(b.replaceAll("'", "")) > 0
      } else {
        a.toDouble > b.toDouble
      }
    } else if (operate.equals("<")) {
      //计算<，分字符串和数字两种类型
      if (b.startsWith("'")) {
        a.compare(b.replaceAll("'", "")) < 0
      } else {
        a.toDouble < b.toDouble
      }
    } else if (operate.equals(">=")) {
      //计算>，分字符串和数字两种类型
      if (b.startsWith("'")) {
        a.compare(b.replaceAll("'", "")) >= 0
      } else {
        a.toDouble >= b.toDouble
      }
    } else if (operate.equals("<=")) {
      //计算<，分字符串和数字两种类型
      if (b.startsWith("'")) {
        a.compare(b.replaceAll("'", "")) <= 0
      } else {
        a.toDouble <= b.toDouble
      }
    } else if (operate.equals("like")) {
      //计算like
      this.regexMatch(a, b.replaceAll("'", ""))
    } else {
      false
    }
  }

  /**
   * 判断数据data是否符合regex的规则，相当于SQL中的like，匹配码包括%和_
   * @param data : 被检查数据
   * @param regex : 规则依据
   * @return 匹配结果：true匹配，false不匹配
   */
  def regexMatch(data: String, regex: String): Boolean = {
    val pattern = regex.replace("%",".{0,}").replace("_",".").r
    pattern.pattern.matcher(data).matches()
  }
}
