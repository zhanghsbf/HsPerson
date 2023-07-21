package com.roy.personaeng.util

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
object Log {
  private def print(message: Any): Unit = {
    System.err.println(message)
  }

  def info(message:Any):Unit = {
    this.print("<font color=green><b>[info]: " + message + "</b></font>")
  }

  def error(message:Any): Unit ={
    this.print("<font color=red><b>[error]: " + message + "</b></font>")
  }

  def debug(message:Any): Unit ={
    this.print("<font color=blue>[debug]: " + message + "</b></font>")
  }
}
