package com.roy.personaeng.util

import scala.util.parsing.json.JSON

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
object JsonUtil {
  def toJsonObjectString(map: Map[String, Any]): String = {
    val sb = new StringBuffer("{")
    val iterator = map.keysIterator
    while (iterator.hasNext) {
      val key = iterator.next()
      sb.append("\"").append(key).append("\":")
      val value = map.get(key).get
      value match {
        case i: String =>
          var str = value.asInstanceOf[String]
          if("null".equalsIgnoreCase(str)){
            str = ""
          }
          sb.append("\"").append(str).append("\"")
        case l: List[Any] =>
          sb.append("[")
          val list = value.asInstanceOf[List[Any]]
          for (i <- list.indices) {
            val element = list(i)
            element match {
              case s: String =>
                var str = element.asInstanceOf[String]
                if("null".equalsIgnoreCase(str)){
                  str = ""
                }
                sb.append("\"").append(str).append("\"")
              case m: Map[_, _] =>
                sb.append(toJsonObjectString(element.asInstanceOf[Map[String, Any]]))
              case _ =>
                sb.append(element)
            }
            if (i != list.size - 1) {
              sb.append(",")
            }
          }
          sb.append("]")
        case m: Map[_, _] =>
          sb.append(toJsonObjectString(value.asInstanceOf[Map[String, Any]]))
        case _ =>
          sb.append(value)
      }
      if (iterator.hasNext) {
        sb.append(",")
      }
    }
    sb.append("}")
    sb.toString
  }


  /**
   * 将一个JSON字符串转为JSON对象，并从JSON对象中取出key所包含的数据以数组返回
   * @param content: JSON字符串
   * @param key: 要返回的值对应的key
   * @return 返回值二维数组
   */
  def toArray(content: String, key: Array[String]): Array[Array[String]] = {
    val option = JSON.parseFull(content)
    if (option.isDefined && option.get.isInstanceOf[List[_]]) {
      val list = option.get.asInstanceOf[List[Map[String, String]]]
      val matrix = new Array[Array[String]](list.size)
      for (i <- list.indices) {
        val row = new Array[String](key.length)
        for (j <- key.indices) {
          val data = list(i).get(key(j))
          row(j) = data.getOrElse("")
        }
        matrix(i) = row
      }
      matrix
    } else {
      Array()
    }
  }
}
