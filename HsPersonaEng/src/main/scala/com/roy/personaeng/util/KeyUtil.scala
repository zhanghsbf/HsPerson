package com.roy.personaeng.util

import java.text.SimpleDateFormat
import java.util.{Calendar, Random}

/**
 *
 * @author roy
 * @date 2021/12/13
 * */
object KeyUtil {

  def getKey: String = {
    val date = Calendar.getInstance().getTime
    val df = new SimpleDateFormat("yyMMddHHmmssSSS")
    val random = new Random()
    val s1 = Integer.toString(Math.abs(random.nextInt()) % 100000 + 100000)
    val s2 = Integer.toString(Math.abs(random.nextInt()) % 100000 + 100000)
    "ID" + df.format(date) + s1.substring(1) + s2.substring(1)
  }
}
