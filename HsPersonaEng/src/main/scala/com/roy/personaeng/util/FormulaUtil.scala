package com.roy.personaeng.util

import com.roy.personaeng.common.Constant
import com.roy.personaeng.util.CalculateUtil.RuleEntity

import java.util.Date

/**
 *
 * @author roy
 * @date 2021/12/15
 * @desc
 */
object FormulaUtil {
  /**
   * 将公式中的各个需要计算的项计算好，放入到Map中
   * @param formula : 公式字符串，该字符串用\u0003隔开
   * @param jjccResultMap : 各个计算项对应的值，如果该Map中存在，则不需要再次计算
   * @param dataMap : 被计算的数据
   * @return 加入了新的计算项对应值的Map
   */
  def getReplaceMap(formula: String, jjccResultMap: Map[String, String], dataMap: Map[String, Any]): Map[String, String] = {
    val array = formula.split(Constant.SPLIT_CHAR_FORMULA)
    for (i <- 0 until array.length) {
      array(i) = array(i).trim
    }
    var returnMap = jjccResultMap
    var i = 0
    while (i < array.length) {
      if (!Constant.operateArray.contains(array(i)) && !Constant.bracketArray.contains(array(i))) {
        if (returnMap.get(array(i)).isEmpty) {
          var value = ""
          if (array(i).toLowerCase.startsWith("sum(")) {
            value = getSumValue(array(i), dataMap)
          } else if (array(i).toLowerCase.startsWith("sumif(")) {
            value = getSumIfValue(array(i), dataMap)
          } else if (array(i).toLowerCase.startsWith("count(")) {
            value = getCountValue(array(i), dataMap)
          } else if (array(i).toLowerCase.startsWith("countif(")) {
            value = getCountIfValue(array(i), dataMap)
          } else if (array(i).toLowerCase.startsWith("avg(")) {
            value = getAvgValue(array(i), dataMap)
          } else if (array(i).equalsIgnoreCase("{nowdate}")) {
            //不能用当前时间除1000*3600*24，必须用今天0时开始算，因为有时区影响导致8点以前的时间会少算一天
            value = ComUtil.getDateLongFromStr(ComUtil.getDateStrFromDate(new Date())).toString
            returnMap = genPartnerDateMap(array, dataMap, returnMap, i)
          } else if (array(i).equalsIgnoreCase("{nowtime}")) {
            value = (System.currentTimeMillis() / 1000).toString
            returnMap = genPartnerTimeMap(array, dataMap, returnMap, i)
          } else {
            value = getNormalValue(array(i), dataMap)
          }
          returnMap += (array(i) -> value)
        }
      }
      i = i + 1
    }
    returnMap
  }

  /**
   * 将公式中各个计算项用值替换，然后计算出结果
   * @param formula : 公式字符串，该字符串用\u0003隔开
   * @param jjccResultMap : 各个计算项对应的值
   * @return 计算结果
   */
  def getReplaceValue(formula: String, jjccResultMap: Map[String, String]): String = {
    val formulaArray = formula.split(Constant.SPLIT_CHAR_FORMULA).toBuffer
    var haveNullValue = false
    var i: Int = 0
    while (i < formulaArray.length) {
      formulaArray(i) = formulaArray(i).trim
      if (jjccResultMap.get(formulaArray(i)).isDefined) {
        formulaArray(i) = jjccResultMap.get(formulaArray(i)).get
        if (formulaArray(i) == null) {
          haveNullValue = true
          i = formulaArray.length
        }
      }
      i = i + 1
    }
    //如果有空值，则直接返回null
    if (haveNullValue) {
      null
    } else {
      //1、对四则运算符+-*/进行计算，如果逻辑符两端是数字，则计算合并
      //2、去括号，如果数字两端是括号，则直接丢掉括号
      //3、最多计算100次，避免规则错误，陷入死循环
      var i = 0
      while (formulaArray.length != 1 && i < 100) {
        var j: Int = 0
        while (j < formulaArray.length) {
          if ("+".equals(formulaArray(j))) {
            //如果是+且两端不是括号
            if (!Constant.bracketArray.contains(formulaArray(j - 1)) && !Constant.bracketArray.contains(formulaArray(j + 1))) {
              formulaArray(j) = (formulaArray(j - 1).toDouble + formulaArray(j + 1).toDouble).toString
              formulaArray.remove(j + 1)
              formulaArray.remove(j - 1)
              j = j - 1
            }
          } else if ("-".equals(formulaArray(j))) {
            //如果是-且两端不是括号
            if (!Constant.bracketArray.contains(formulaArray(j - 1)) && !Constant.bracketArray.contains(formulaArray(j + 1))) {
              formulaArray(j) = (formulaArray(j - 1).toDouble - formulaArray(j + 1).toDouble).toString
              formulaArray.remove(j + 1)
              formulaArray.remove(j - 1)
              j = j - 1
            }
          } else if ("*".equals(formulaArray(j))) {
            //如果是*且两端不是括号
            if (!Constant.bracketArray.contains(formulaArray(j - 1)) && !Constant.bracketArray.contains(formulaArray(j + 1))) {
              formulaArray(j) = (formulaArray(j - 1).toDouble * formulaArray(j + 1).toDouble).toString
              formulaArray.remove(j + 1)
              formulaArray.remove(j - 1)
              j = j - 1
            }
          } else if ("/".equals(formulaArray(j))) {
            if (!Constant.bracketArray.contains(formulaArray(j - 1)) && !Constant.bracketArray.contains(formulaArray(j + 1))) {
              if (formulaArray(j + 1).toDouble == 0) {
                formulaArray(j) = "0"
              } else {
                formulaArray(j) = (formulaArray(j - 1).toDouble / formulaArray(j + 1).toDouble).toString
              }
              formulaArray.remove(j + 1)
              formulaArray.remove(j - 1)
              j = j - 1
            }
          } else if (!Constant.bracketArray.contains(formulaArray(j))) {
            if ("(".equals(formulaArray(j - 1)) && ")".equals(formulaArray(j + 1))) {
              formulaArray.remove(j + 1)
              formulaArray.remove(j - 1)
              j = j - 1
            }
          }
          j = j + 1
        }
        i = i + 1
      }
      formulaArray.head
    }
  }
  //这里的获取值不包括计算，就是直接一级一级的往下取，没有则返回空字符串，有则返回
  def getNormalValue(key: String, dataMap: Map[String, Any]): String = {
    val keyArray = key.split("\\.")
    val lastProperty = keyArray(keyArray.length - 1)
    val result = this.getLatestData(keyArray, dataMap)
    if (result != None && result.isInstanceOf[Map[_, _]]) {
      val resultObject = result.asInstanceOf[Map[String, Any]].get(lastProperty)
      if (resultObject.isDefined && resultObject.get.isInstanceOf[String]) {
        resultObject.get.asInstanceOf[String]
      } else if (resultObject.isDefined && resultObject.get.isInstanceOf[Double]) {
        resultObject.get.asInstanceOf[Double].toString
      } else {
        null
      }
    } else {
      null
    }
  }

  /**
   * 计算组函数avg()
   * @param key : 包含组函数avg的公式字符串，如avg(students.eng_score)
   * @param dataMap : 被计算数据
   * @return 求平均后的值
   */
  def getAvgValue(key: String, dataMap: Map[String, Any]): String = {
    val keyArray = key.substring(4, key.length - 1).split("\\.")
    var lastProperty = keyArray(keyArray.length - 1)
    var result = this.getLatestData(keyArray, dataMap)
    //当数据为{"name":"xwk","score":[11,21,31]}，公式为avg(score)>10
    //这个获取的latestData是整个对象，是个map，所以要再检测一下存不存在score且score是否为List[Double]型
    //如果是就必须再取一次
    if (result != None && result.isInstanceOf[Map[_, _]]) {
      val mapResult = result.asInstanceOf[Map[String, _]]
      val mapValue = mapResult.get(lastProperty)
      //按道理应该要匹配List[Double]，但是scala不支持这么写，只好写成匹配List[_]
      if (mapValue.isDefined && mapValue.get.isInstanceOf[List[_]]) {
        lastProperty = null //万一下面是个List[Map]型，将lastProperty设置为null，可以阻止从map中获取数据计算
        result = mapValue.get.asInstanceOf[List[_]]
      }
    }
    if (result != None && result.isInstanceOf[List[_]]) {
      val list = result.asInstanceOf[List[Any]]
      val numArray = new Array[Double](list.size)
      //下面开始求和，list有两种，一种是[11,21,31]型，第二种是[Map(age->11),Map(age->21),Map(age->31)]，要分开处理
      for (i <- list.indices) {
        list(i) match {
          case d: Double =>
            //第一种
            numArray(i) = list(i).asInstanceOf[Double]
          case m: Map[_, _] =>
            //第二种
            val map = list(i).asInstanceOf[Map[String, Any]]
            if (map.get(lastProperty).isEmpty) {
              numArray(i) = 0
            } else {
              val amount = map.get(lastProperty).get
              amount match {
                case d: Double =>
                  numArray(i) = amount.asInstanceOf[Double]
                case s: String =>
                  val str = amount.asInstanceOf[String]
                  try {
                    numArray(i) = str.toDouble
                  } catch {
                    case ex: Exception =>
                      numArray(i) = 0
                  }
                case _ =>
                  numArray(i) = 0
              }
            }
          case _ =>
            numArray(i) = 0
        }
      }
      if (list.isEmpty) {
        "0"
      } else {
        (numArray.sum / list.size).toString
      }
    } else {
      null
    }
  }

  /**
   * 计算组函数count()
   * @param key : 包含组函数count的公式字符串，如count(students.name)
   * @param dataMap : 被计算数据
   * @return 求计数后的值
   */
  def getCountValue(key: String, dataMap: Map[String, Any]): String = {
    val keyArray = key.substring(6, key.length - 1).split("\\.")
    val result = this.getLatestData(keyArray, dataMap)
    if (result != None && result.isInstanceOf[List[_]]) {
      val list = result.asInstanceOf[List[Any]]
      list.size.toString
    } else {
      null
    }
  }

  /**
   * 计算组函数countif()
   * @param key : 包含组函数countif的公式字符串，如countif((\u0005students.eng_score\u0005+\u0005students.chn_score\u0005)\u0004>\u000410)，内部表达式分别用\u0004,\u0005隔开
   * @param dataMap : 被计算数据
   * @return 求条件计数后的值
   */
  def getCountIfValue(key: String, dataMap: Map[String, Any]): String = {
    val innerArray = key.substring(8, key.length - 1).split(Constant.SPLIT_CHAR_INNER_EXPRESS) //先去掉函数名和括号，并分割
    var attr: String = ""
    var i: Int = 0
    //为调用CalculateUtil.calculateRangeRule，自己构造了参数
    while (i < innerArray.length) {
      val ininArray = innerArray(i).split(Constant.SPLIT_CHAR_INNER_FORMULA)
      var j: Int = 0
      while (j < ininArray.length) {
        if (ininArray(j).indexOf(".") >= 0) {
          //如果判断条件中存在children.children.age，那这要弄成age，因为等下取数据的时候会取到最后一级
          attr = ininArray(j)
          ininArray(j) = ininArray(j).substring(ininArray(j).lastIndexOf(".") + 1)
        }
        j = j + 1
      }
      innerArray(i) = ininArray.mkString(Constant.SPLIT_CHAR_FORMULA)
      i = i + 1
    }
    val ruleEndList = new Array[RuleEntity](1)
    ruleEndList(0) = new RuleEntity(innerArray, "1")

    //默认自定义实体的result为1，这样如果只要返回1表示计算正确
    val result = this.getLatestData(attr.split("\\."), dataMap)
    var rtnValue = 0
    if (result != None && result.isInstanceOf[List[_]]) {
      val list = result.asInstanceOf[List[Any]]
      i = 0
      while (i < list.size) {
        val res = CalculateUtil.calculateRangeRule(list(i).asInstanceOf[Map[String, Any]], ruleEndList)
        if (res.equals("1")) {
          rtnValue = rtnValue + 1
        }
        i = i + 1
      }
      rtnValue.toString
    } else {
      null
    }
  }

  /**
   * 计算组函数sum()
   * @param key : 包含组函数sum的公式字符串，如sum(students.score)
   * @param dataMap : 被计算数据
   * @return 求条件求和后的值
   */
  def getSumValue(key: String, dataMap: Map[String, Any]): String = {
    val formulaArray = key.substring(4, key.length - 1).split(Constant.SPLIT_CHAR_INNER_FORMULA)
    //将求和式涉及的属性，改成只取最后一节，譬如条件中用到了chidren.age，那将该属性改成age
    var attr: String = "" //attr在后面将会用于获取最后一级的数据
    var i: Int = 0
    while (i < formulaArray.length) {
      if (formulaArray(i).indexOf(".") >= 0) {
        attr = formulaArray(i)
        formulaArray(i) = formulaArray(i).substring(formulaArray(i).lastIndexOf(".") + 1)
      }
      i = i + 1
    }
    val keyArray = attr.split("\\.")
    var lastProperty = keyArray(keyArray.length - 1)
    //如果lastProperty为空，表示formulaArray中没有一个是使用二级属性的，那一定使用的是一级属性，譬如sum(score)
    //能够对一级属性求和的，只有数据为{"name":"xwk","score":[11,21,31]}，公式为sum(score)>10的形式
    //不会存在sum(score+money)>10的形式，所以直接取formulaArray中第一个为lastProperty
    if (lastProperty.isEmpty) {
      lastProperty = formulaArray(0)
    }
    var result = this.getLatestData(keyArray, dataMap)
    //当数据为{"name":"xwk","score":[11,21,31]}，公式为sum(score)>10
    //这个获取的latestData是整个对象，是个map，所以要再检测一下存不存在score且score是否为List[Double]型
    //如果是就必须再取一次
    if (result != None && result.isInstanceOf[Map[_, _]]) {
      val mapResult = result.asInstanceOf[Map[String, _]]
      val mapValue = mapResult.get(lastProperty)
      //按道理应该要匹配List[Double]，但是scala不支持这么写，只好写成匹配List[_]
      if (mapValue.isDefined && mapValue.get.isInstanceOf[List[_]]) {
        lastProperty = null //万一下面是个List[Map]型，将lastProperty设置为null，可以阻止从map中获取数据计算
        result = mapValue.get.asInstanceOf[List[_]]
      }
    }
    var rtnValue: Double = 0
    if (result != None && result.isInstanceOf[List[_]]) {
      val list = result.asInstanceOf[List[Any]]
      i = 0
      //开始循环计算判断每一条数据的sumif条件式是true开始false，并累加，如果返回1表示是true，否则为false
      while (i < list.size) {
        list(i) match {
          case m: Map[_, _] =>
            if (lastProperty != null) {
              val thisDataMap = list(i).asInstanceOf[Map[String, Any]]
              val value = CalculateUtil.calculateFormula(formulaArray.mkString(Constant.SPLIT_CHAR_FORMULA), thisDataMap)
              if (value != null) {
                rtnValue = rtnValue + value.toDouble
              }
            }
          case d: Double =>
            rtnValue = rtnValue + list(i).asInstanceOf[Double]
          case _ =>

        }
        i = i + 1
      }
      rtnValue.toString
    } else {
      null
    }
  }

  /**
   * 计算组函数sumif()
   * @param key : 包含组函数sumif的公式字符串，如sumif((\u0005students.eng_score\u0005+\u0005students.chn_score\u0005)\u0004>\u000410,students.score)，内部表达式分别用\u0004,\u0005隔开
   * @param dataMap : 被计算数据
   * @return 求条件求和后的值
   */
  def getSumIfValue(key: String, dataMap: Map[String, Any]): String = {
    //将sumif内部按逗号分隔为两部分，条件判断部分，求和式部分
    val c_f = key.substring(6, key.length - 1).split(",")
    //将条件判断部分分割为数组
    val conditionArray = c_f(0).split(Constant.SPLIT_CHAR_INNER_EXPRESS)
    //将求和式部分分割为数组
    val formulaArray = c_f(1).split(Constant.SPLIT_CHAR_INNER_FORMULA)
    //将条件部分涉及的属性，改成只取最后一节，譬如条件中用到了chidren.age，那将该属性改成age
    var attr: String = "" //attr在后面将会用于获取最后一级的数据
    var i: Int = 0
    while (i < conditionArray.length) {
      val ininArray = conditionArray(i).split(Constant.SPLIT_CHAR_INNER_FORMULA)
      var j: Int = 0
      while (j < ininArray.length) {
        if (ininArray(j).indexOf(".") >= 0) {
          attr = ininArray(j)
          ininArray(j) = ininArray(j).substring(ininArray(j).lastIndexOf(".") + 1)
        }
        j = j + 1
      }
      conditionArray(i) = ininArray.mkString(Constant.SPLIT_CHAR_FORMULA)
      i = i + 1
    }
    //将求和式部分涉及的属性，改成只取最后一节，譬如条件中用到了chidren.age，那将该属性改成age
    i = 0
    while (i < formulaArray.length) {
      if (formulaArray(i).indexOf(".") >= 0) {
        formulaArray(i) = formulaArray(i).substring(formulaArray(i).lastIndexOf(".") + 1)
      }
      i = i + 1
    }
    //将sumif内的计算公式组织成一个实体，再调用方法calculateRangeRule来判断是true还是false
    val ruleEndList = new Array[RuleEntity](1)
    ruleEndList(0) = new RuleEntity(conditionArray, "1")
    //获取最后一级数据
    val result = this.getLatestData(attr.split("\\."), dataMap)
    var rtnValue: Double = 0
    if (result != None && result.isInstanceOf[List[_]]) {
      val list = result.asInstanceOf[List[Any]]
      i = 0
      //开始循环计算判断每一条数据的sumif条件式是true开始false，并累加，如果返回1表示是true，否则为false
      while (i < list.size) {
        val thisDataMap = list(i).asInstanceOf[Map[String, Any]]
        val res = CalculateUtil.calculateRangeRule(thisDataMap, ruleEndList)
        if (res.equals("1")) {
          val value = CalculateUtil.calculateFormula(formulaArray.mkString(Constant.SPLIT_CHAR_FORMULA), thisDataMap)
          if (value != null) {
            rtnValue = rtnValue + value.toDouble
          }
        }
        i = i + 1
      }
      rtnValue.toString
    } else {
      null
    }
  }

  def getLatestData(keyArray: Array[String], dataMap: Map[String, Any]): Any = {
    var result: Any = dataMap
    var i = 0
    while (i < keyArray.length - 1) {
      if (result != None && result.isInstanceOf[Map[_, _]]) {
        val value = result.asInstanceOf[Map[String, Any]].get(keyArray(i))
        if (value.isDefined) {
          result = value.get
        } else {
          result = None
        }
      }
      i = i + 1
    }
    result
  }

  def genPartnerDateMap(array: Array[String], dataMap: Map[String, Any], returnMap: Map[String, String], index: Int): Map[String, String] = {
    var value: String = null
    val partnerIndex = this.getPartnerIndex(array, index)
    if (partnerIndex > 0) {
      val result = this.getNormalValue(array(partnerIndex), dataMap)
      if (result != null) {
        val time = ComUtil.getDateLongFromStr(result.asInstanceOf[String])
        if (time != 0) {
          value = time.toString
        }
      }
    }
    returnMap ++ Map(array(partnerIndex) -> value)
  }

  def genPartnerTimeMap(array: Array[String], dataMap: Map[String, Any], returnMap: Map[String, String], index: Int): Map[String, String] = {
    var value: String = null
    val partnerIndex = this.getPartnerIndex(array, index)
    if (partnerIndex > 0) {
      val result = this.getNormalValue(array(partnerIndex), dataMap)
      if (result != null) {
        val time = ComUtil.getTimeLongFromStr(result.asInstanceOf[String])
        if (time != 0) {
          value = time.toString
        }
      }
    }
    returnMap ++ Map(array(partnerIndex) -> value)
  }

  def getPartnerIndex(array: Array[String], index: Int): Int = {
    if (array.length >= index + 3 && index > 0 && array(index - 1).equals("(") && array(index + 3).equals(")")) {
      index + 2
    } else if (array.length >= index + 1 && index > 2 && array(index - 3).equals("(") && array(index + 1).equals(")")) {
      index - 2
    } else {
      -1
    }
  }
}
