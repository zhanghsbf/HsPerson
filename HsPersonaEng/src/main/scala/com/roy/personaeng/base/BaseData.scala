package com.roy.personaeng.base

import org.apache.spark.sql.Row
import org.apache.spark.sql.types.{BinaryType, BooleanType, ByteType, DateType, DecimalType, DoubleType, FloatType, IntegerType, LongType, NullType, ShortType, StringType, StructField, StructType, TimestampType}

/**
 *
 * @author roy
 * @date 2021/12/13
 * @desc
 */
class BaseData extends Serializable {
  //属性数组
  val fields = Array("")
  //类型映射Map
  private val typeMap = Map("null" -> NullType,
    "boolean" -> BooleanType,
    "byte" -> ByteType,
    "short" -> ShortType,
    "int" -> IntegerType,
    "long" -> LongType,
    "float" -> FloatType,
    "double" -> DoubleType,
    "binary" -> BinaryType,
    "class java.lang.Integer" -> IntegerType,
    "class java.lang.Double" -> DoubleType,
    "class scala.Double" -> DoubleType,
    "class scala.math.BigDecimal" -> DecimalType.SYSTEM_DEFAULT,
    "class java.lang.String" -> StringType,
    "class java.sql.Date" -> DateType,
    "class java.sql.Timestamp" -> TimestampType)

  /**
   * 获取类型的Schema:StructType
   * @return StructType
   */
  def getStructType: StructType = {
    val fieldArray = new Array[StructField](this.fields.length)
    val fields = this.getClass.getDeclaredFields
    for (i <- this.fields.indices) {
      val gType = this.getClass.getDeclaredField(this.fields(i)).getGenericType
      fieldArray(i) = StructField(fields(i).getName, typeMap.get(gType.toString).get)
    }
    StructType(fieldArray)
  }

  /**
   * 将一个Row数据按属性数组顺序换成自定义的实体对象
   * @param row : 数据库读出的Row数据
   * @tparam T : 自定义的实体对象
   * @return 已填充数据的自定义实体对象
   */
  def fromRow[T](row: Row): T = {
    for (i <- 0 until row.length) {
      if (row(i) != null) {
        val method = this.getClass.getDeclaredMethod(this.fields(i) + "_$eq", row(i).getClass)
        method.invoke(this, row(i).asInstanceOf[Object])
      }
    }
    this.asInstanceOf[T]
  }

  /**
   * 将自己按属性数组顺序生成Row数据
   * @return 能被存入到数据库的Row数据
   */
  def toRow: Row = {
    val buffer = new Array[Any](this.fields.length)
    for (i <- this.fields.indices) {
      buffer(i) = this.getClass.getDeclaredMethod(this.fields(i)).invoke(this)
    }
    Row.fromSeq(buffer)
  }
}
