package com.roy.personaeng.base

import com.roy.personaeng.common.Constant
import org.apache.spark.sql.execution.datasources.jdbc.{JDBCOptions, JdbcUtils}
import org.apache.spark.sql.types.StructType
import org.apache.spark.sql.{Row, SaveMode, SparkSession}

import java.util.Properties
import scala.collection.mutable.ArrayBuffer

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
class BaseService {
  /**
   * 获取sql上下文
   * @return sql上下文
   */
//  private def getSqlContext: SQLContext = {
//    val sparkSession = SparkSession.builder().config(ComUtil.getSparkConfig("123")).getOrCreate()
//    Container.sparkContext
//    new SQLContext(Container.sparkContext)
//  }

  private def getSparkSession: SparkSession = {
    Container.sparkSession
  }

  /**
   * 获取数据库配置属性
   * @return 数据库配置属性实体
   */
  private def getSqlProperties: Properties = {
    val prop = new Properties()
    prop.setProperty("driver" , Constant.DB_DRIVER)
    prop.setProperty("user", Constant.DB_USERNAME)
    prop.setProperty("password", Constant.DB_PASSWORD)
    prop
  }

  private def getJdbcParam : Map[String,String] = {
    val paramMap:Map[String,String] = Map(JDBCOptions.JDBC_URL->Constant.DB_URL,
      "user" ->Constant.DB_USERNAME, "password" -> Constant.DB_PASSWORD,
      "driver" -> Constant.DB_DRIVER)
    paramMap
  }


  /**
   * 从表中查询符合条件的数据数据
   * @param tableName : 需要查询的表名
   * @param condition : 过滤条件
   * @return 结果数组
   */
  protected def find(tableName: String, condition: ArrayBuffer[String]): Array[Row] = {
    if (condition.isEmpty) {
      this.getSparkSession.read.jdbc(Constant.DB_URL, tableName, this.getSqlProperties).collect()
    } else {
      this.getSparkSession.read.jdbc(Constant.DB_URL, tableName, condition.toArray, this.getSqlProperties).collect()
    }
  }

  /**
   * 插入数据到数据库
   * @param tableName : 需要insert的表名
   * @param structType  : 表的schema结构类型
   * @param list : 要插入的数据
   */
  protected def save(tableName: String, structType: StructType, list: List[Row]) = {
    val rdd = Container.sparkContext.parallelize(list)
    val writer = this.getSparkSession.createDataFrame(rdd, structType).write
    writer.mode(SaveMode.Append)
    writer.jdbc(Constant.DB_URL, tableName, this.getSqlProperties)
  }

  /**
   * 修改数据
   * @param tableName : 被修改的表名
   * @param set : 修改内容，如stats=1
   * @param condition : 条件串，入status=1 and isdelete=0
   */
  protected def update(tableName: String, set: String, condition: String) {
    var paramMap = this.getJdbcParam
    paramMap += ("dbtable" -> tableName)

    val jdbcOptions = new JDBCOptions(paramMap)
    val conn = JdbcUtils.createConnectionFactory(jdbcOptions).apply()

    val sql = s"UPDATE $tableName SET $set WHERE $condition"
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

  }
}
