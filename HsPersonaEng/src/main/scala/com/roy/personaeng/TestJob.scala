package com.roy.personaeng

import com.roy.personaeng.base.Container
import com.roy.personaeng.util.ComUtil
import org.apache.spark.SparkContext
import org.apache.spark.sql.execution.datasources.jdbc.{JDBCOptions, JdbcUtils}

import java.util.Properties

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
object TestJob {

  def main(args: Array[String]): Unit = {
    ComUtil.initParams()

    val conf = ComUtil.getSparkConfig("TestJob")
    //    Container.sparkSession = SparkSession.builder().config(conf).getOrCreate()
    Container.sparkContext = new SparkContext(conf)

    val connectionProperties = new Properties()
    connectionProperties.put("user", "username")
    connectionProperties.put("password", "password")

    //    val sql = "update etl_json_config set logs='aaa' where id='ID2112091711475243549542338'"
    val sql = "update user set sex='male' where id='1'"
    val paramMap: Map[String, String] = Map(JDBCOptions.JDBC_URL -> "jdbc:mysql://192.168.65.174:3306/testdb?characterEncoding=UTF-8&serverTimezone=GMT",
      "user" -> "root", "password" -> "root", "dbtable" -> "etl_json_config",
      "driver" -> "com.mysql.cj.jdbc.Driver")
    val jdbcOptions = new JDBCOptions(paramMap)
    val conn = JdbcUtils.createConnectionFactory(jdbcOptions).apply()
    try {
      val statement = conn.createStatement
      try {
        statement.executeUpdate(sql)
      } finally {
        if (statement != null && !statement.isClosed) {
          statement.close()
        }
      }
    } finally {
      if (conn != null && !conn.isClosed) {
        conn.close()
      }
    }
    Container.sparkContext.stop()
  }

}
