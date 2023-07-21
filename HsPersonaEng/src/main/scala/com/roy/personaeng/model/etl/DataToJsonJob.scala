package com.roy.personaeng.model.etl

import com.roy.personaeng.base.Container
import com.roy.personaeng.common.Constant
import com.roy.personaeng.service.{EtlJsonConfigService, EtlJsonTableConfigService, SysParamService}
import com.roy.personaeng.util._
import org.apache.spark.rdd.RDD
import org.apache.spark.sql.SparkSession

/**
 * 二维表转JSON计算任务
 * @author roy
 * @date 2021/12/13
 * @desc
 */
object DataToJsonJob {
  def main(args: Array[String]): Unit = {
//    参数：args(0) - taskId
//     args(1) - ETLName 管理端会传入当前登录用户名作为任务名。
//     args(2) - dataPath 二维表文件HDFS地址。
//     args(3) rundate - 执行日期 如果没有rundate，管理端会传个/

    ComUtil.initParams()
    if(args == null || args.length != 4){
      Log.error("运行参数个数应该为4")
      Log.error(s"params should be : taskid, etlName,datapath, rundate")
      System.exit(1)
    }

    Log.info("ETLID - args[0]:"+args(0))
    Log.info("ETL主题- args[1]:" + args(1))
    if(args(0) == null || "".equals(args(0).trim)){
      Log.error("ETL配置的ID为空")
      System.exit(1)
    }

    val conf = ComUtil.getSparkConfig(args(1))
//    conf.setMaster("local[*]")
    Container.sparkSession = SparkSession.builder().config(conf).getOrCreate()
    Container.sparkContext = Container.sparkSession.sparkContext

    val sysParamService = new SysParamService()
    val etlJsonConfigService = new EtlJsonConfigService()
    val etlJsonTableConfigService = new EtlJsonTableConfigService()

    try {
      /**
       * 获取ETL配置数据
       */
      val etlJsonConfig = etlJsonConfigService.getEtlJsonConfigById(args(0))
      if (etlJsonConfig == null) {
        Log.error("ETL配置ID错误")
        Container.sparkContext.stop()
        System.exit(1)
      }
      Container.dataRootPath = Constant.HDFS_DATAROOTPATH+"/"+args(1)+"/"+args(0)+"/"//数据路径
      val etlJsonTableConfigs = etlJsonTableConfigService.getEtlJsonTableConfigsByConfigId(args(0))

//      if (etlJsonTableConfigs.isEmpty) {
//        Log.error("不存在的ETL任务对应的从表映射")
//        etlJsonConfigService.updateEtlJsonConfigLog(etlJsonConfig.id, "不存在的ETL任务对应的从表表映射")
//        Container.sparkContext.stop()
//        System.exit(0)
//      }
      val properties = etlJsonConfig.primaryTableProperties.split(Constant.SPLIT_CHAR).map(line => {
        val data = line.split(",")
        (data(0).toInt, data(1))
      })
      val sysParam = sysParamService.getSysParamByCode(Constant.DATA_ROOT_PATH)
      if (sysParam == null) {
        Log.error("系统参数未设置(" + Constant.DATA_ROOT_PATH + ")")
        etlJsonConfigService.updateEtlJsonConfigLog(etlJsonConfig.id, "系统参数未设置(" + Constant.DATA_ROOT_PATH + ")")
        Container.sparkContext.stop()
        System.exit(1)
      }
      /**
       * 存入至广播变量
       */
      val etlJsonConfigSc = Container.sparkContext.broadcast(etlJsonConfig)
      val propertiesSc = Container.sparkContext.broadcast(properties)
      val etlJsonTableConfigsSc = Container.sparkContext.broadcast(etlJsonTableConfigs)
      val etlDataRootPathSc = Container.sparkContext.broadcast(Container.dataRootPath)
      val runDateSc = Container.sparkContext.broadcast(args(3))
      /**
       * 获取主表数据
       */
      var primaryTableFilePath = etlJsonConfigSc.value.primaryTableFileName
      primaryTableFilePath = primaryTableFilePath.replace(Constant.runDateStr,runDateSc.value).replace("//","/")
      if(!primaryTableFilePath.startsWith("/")){
        primaryTableFilePath="/"+primaryTableFilePath
      }
      primaryTableFilePath = Constant.HDFS_PATH+"/"+primaryTableFilePath

      val primaryRdd = EtlUtil.getDataRowFromFile(primaryTableFilePath).map(data => {
        val array = new Array[(String, String)](propertiesSc.value.length + 2)
        array(0) = ("@type", etlJsonConfigSc.value.typeName)
        val primaryKey = data(etlJsonConfigSc.value.primaryTableKeyIndex)
        array(1) = ("unid", primaryKey)
        for (i <- propertiesSc.value.indices) {
          array(i + 2) = (propertiesSc.value(i)._2, data(propertiesSc.value(i)._1))
        }
        (primaryKey, array.toMap.asInstanceOf[Map[String, Any]])
      })
      primaryRdd.count()
      /**
       * 将数据分割并剔除不需要计算的列，然后按对应主表的外键求组归类
       */
      val rddArray = new Array[RDD[(String, Map[String, Any])]](etlJsonTableConfigsSc.value.length + 1)
      rddArray(0) = primaryRdd
      for (i <- etlJsonTableConfigsSc.value.indices) {
        Log.debug(etlJsonTableConfigsSc.value(i).fileName)
        val secondaryRdd = MyEtlUtil.getGroupDataFromFile(etlJsonTableConfigsSc.value(i), etlJsonConfigSc.value.userName,runDateSc.value)
        rddArray(i + 1) = rddArray(i).leftOuterJoin(secondaryRdd).map(data => {
          var map = data._2._1
          if (data._2._2.isDefined) {
            val array = data._2._2.get.toList
            if (etlJsonTableConfigsSc.value(i).mappingType == 0) {
              map += (etlJsonTableConfigsSc.value(i).keyName -> array.head)
            } else {
              map += (etlJsonTableConfigsSc.value(i).keyName -> array)
            }
          }
          (data._1, map)
        })
      }

      var savePath= etlDataRootPathSc.value.replace("//","/")
      Log.info(s"ETL任务输出地址：${savePath}")
      if(!savePath.startsWith("/")){
        savePath = "/"+savePath
      }
      savePath=Constant.HDFS_PATH+"/"+savePath
      rddArray(rddArray.length - 1).map(data => {
        JsonUtil.toJsonObjectString(data._2)
      }).saveAsTextFile(savePath)
      Log.info("ETL成功结束")
      etlJsonConfigService.updateEtlJsonConfigLog(args(0), "ETL成功结束")
    }
    catch {
      case ex: Exception =>
        if (ex.getMessage.length > 980) {
          etlJsonConfigService.updateEtlJsonConfigLog(args(0), "计算发生错误：" + ex.getMessage.substring(0, 980))
        } else {
          etlJsonConfigService.updateEtlJsonConfigLog(args(0), "计算发生错误：" + ex.getMessage)
        }
        Log.error(ex.getMessage)
        ex.printStackTrace()
//        Container.sparkContext.stop()
        Container.sparkSession.stop()
        System.exit(1)
    } finally {
      Container.sparkSession.stop()
//      Container.sparkContext.stop()
    }
  }
}
