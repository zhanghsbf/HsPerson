package com.roy.personaeng.calculate

import com.roy.personaeng.base.Container
import com.roy.personaeng.common.Constant
import com.roy.personaeng.service.{SysParamService, TagCalculateSelectService, TagCalculateService}
import com.roy.personaeng.util.CalculateUtil.RuleEntity
import com.roy.personaeng.util.{CalculateUtil, ComUtil, Log}
import org.apache.spark.sql.SparkSession
import org.elasticsearch.spark.rdd.EsSpark

import scala.collection.mutable.ArrayBuffer
import scala.util.parsing.json.JSON

/**
 *
 * @author roy
 * @date 2021/12/14
 * @desc
 */
object CalculateJob {
  def main(args: Array[String]) {
    //args[0]计算ID，args[1]计算用户名与主题,args[2]:runDate
    ComUtil.initParams()
    /**
     * 检查运行参数是否正确
     */
    if (args == null || args.length != 3) {
      Log.error("运行参数不正确，参数长度应该为3")
      System.exit(1)
    }
    Log.info("计算ID（args[0]）:" + args(0))
    Log.info("计算主题（args[1]）:" + args(1))
    if (args(0) == null || "".equals(args(0).trim)) {
      Log.error("计算配置ID为空")
      System.exit(1)
    }
    /**
     * 初始化sparkContext
     */
    val conf = ComUtil.getSparkConfig(args(1))
    conf.set("es.nodes", Constant.ES_ADDRESS)
//    conf.setMaster("local[*]")
    Container.sparkSession = SparkSession.builder().config(conf).getOrCreate()
    Container.sparkContext = Container.sparkSession.sparkContext

    /**
     * 初始化Service
     */
    val tagCalculateService = new TagCalculateService()
    val tagCalculateSelectService = new TagCalculateSelectService()
    val sysParamService = new SysParamService()

    try {
      /**
       * 检查计算配置的合法性
       */
      val tagCalculate = tagCalculateService.getTagCalculateById(args(0))
      if (tagCalculate == null) {
        Log.error("计算ID错误")
        Container.sparkContext.stop()
        System.exit(1)
      }
      val selectedTagArray = tagCalculateSelectService.getTagCalculateSelectByCalculateId(args(0))
      if (selectedTagArray.length == 0) {
        tagCalculateService.updateTagCalculateLogs(args(0), "计算配置所选择的标签为空，计算未开始")
        Log.error("计算配置所选择的标签为空")
        Container.sparkContext.stop()
        System.exit(1)
      }
      val prePathParam = sysParamService.getSysParamByCode(Constant.DATA_ROOT_PATH)
      if (prePathParam == null || prePathParam.value == null || "".equals(prePathParam.value)) {
        tagCalculateService.updateTagCalculateLogs(args(0), "请联系系统管理员配置好系统参数（" + Constant.DATA_ROOT_PATH + "）")
        Log.error("请联系系统管理员配置好系统参数（" + Constant.DATA_ROOT_PATH + "）")
        Container.sparkContext.stop()
        System.exit(1)
      }
      /**
       * 准备常用变量
       */
      //规则列表(每一个标签一个),用格式化好的规则Map列表做value，
      val ruleArray = new Array[Array[RuleEntity]](selectedTagArray.length)
      //标签结果映射列表(每一个标签一个)，用标签值与标签名称键值对作为value
      val tagArray = new Array[Map[String, String]](selectedTagArray.length)
      //被计算的标签ID列表，在合并老标签时方便使用
      val tagIdArray = new Array[String](selectedTagArray.length)
      for (i <- selectedTagArray.indices) {
        val ruleOption = JSON.parseFull(selectedTagArray(i).rule)
        val ruleStartList = ruleOption.get.asInstanceOf[List[Map[String, String]]]
        val ruleEndList = new Array[RuleEntity](ruleStartList.size)
        for (j <- ruleStartList.indices) {
          val array = ruleStartList(j).get("sql").get.split(Constant.SPLIT_CHAR_EXPRESS)
          ruleEndList(j) = new RuleEntity(array, ruleStartList(j).get("result").get)
        }
        ruleArray(i) = ruleEndList
        tagIdArray(i) = selectedTagArray(i).tagId
        tagArray(i) = selectedTagArray(i).tagContent.split(",").map(r => {
          val sp = r.split(":")
          (sp(0), sp(1))
        }).toMap //把标签内容解析为Map格式，如Map(1->男,2->女)
      }
      //将数据放入到广播变量
      val selectedTagArraySc = Container.sparkContext.broadcast(selectedTagArray)
      val ruleArraySc = Container.sparkContext.broadcast(ruleArray)
      val tagArraySc = Container.sparkContext.broadcast(tagArray)
      val nowSc = Container.sparkContext.broadcast(System.currentTimeMillis())
      val runDateSc = Container.sparkContext.broadcast(args(2))
      tagCalculateService.updateTagCalculateLogs(args(0), "计算配置检查通过，开始计算")
      Log.info("计算配置检查通过，开始计算")
      /**
       * 开始计算
       */
      //数据库中已有的数据 老版本ES的index下可以有多个type，新版本已经没有了type的概念。
//      val esRdd = EsSpark.esRDD(Container.sparkContext, Constant.ES_DB_NAME + "/" + tagCalculate.userName)
      val esRdd = EsSpark.esRDD(Container.sparkContext, Constant.ES_DB_NAME)
      var path = tagCalculate.dataPath
      path = path.replace(Constant.runDateStr,runDateSc.value)
      path= path.replace("//","/")
      Log.info(path)
      if(!path.startsWith("/")){
        path = "/"+path
      }
      path = Constant.HDFS_PATH+"/"+path
      val dataRdd = Container.sparkContext.textFile(path)
      val rdd = dataRdd.map(line => {
        val jsonDataOption = JSON.parseFull(line)
        //只有符合格式的数据在处理
        if (jsonDataOption.isDefined) {
          val dataMap = jsonDataOption.get.asInstanceOf[Map[String, Any]]
          val tagResultArray = ArrayBuffer[Map[String, Any]]()
          //对每一个标签进行打标
          for (i <- selectedTagArraySc.value.indices) {
            val rtnTagValue = CalculateUtil.calculateRangeRule(dataMap, ruleArraySc.value(i))
            //如果返回的是负值，表示该标签不能被计算出来，就不贴该标签（譬如计算标签的某个数据不存在，就不计算，返回负值）
            if (!rtnTagValue.startsWith("-") && tagArraySc.value(i).get(rtnTagValue).isDefined) {
              val rtnTagName = tagArraySc.value(i).get(rtnTagValue).get
              tagResultArray += Map("tagValue" -> rtnTagValue, "tagName" -> rtnTagName, "tagTime" -> nowSc.value, "ruleTagId" -> selectedTagArraySc.value(i).tagId, "unionTagId" -> (rtnTagValue + "_" + selectedTagArraySc.value(i).tagId), "isLatest" -> 1)
            }
          }
          //JsonUtil.toJsonObjectString(dataMap ++ Map("@tag" -> tagResultArray.toList))
          //将unid作为_id来组织数据，随后还需要对历史标签数据进行合并，ES中保存数据时会自动覆盖_id相同的数据
          if (dataMap.get("unid").isDefined) {
            (dataMap.get("unid").get.asInstanceOf[String], (dataMap, tagResultArray))
          } else {
            ("", (None, None))
          }
        } else {
          ("", (None, None))
        }
      }).filter(kv => kv._2._1 != None).leftOuterJoin(esRdd).map(data => {
        //获取ES中已有用户的数据，取他的标签历史数据合并到新的标签数据中，未保存的新纪录中就包含了现在的原始数据、新标签数据和老标签数据
        //然后以unid为_id保存数据，这样就会覆盖原来的unid对应的数据
        var dataMap = data._2._1._1.asInstanceOf[Map[String, Any]]
        //新标签必须放在列表前头，这个重要，会影响查询是历史曲线显示的顺序
        val newTagArray = data._2._1._2.asInstanceOf[ArrayBuffer[Map[String, Any]]]
        val latestTagId = ArrayBuffer[String]()
        for(i<-newTagArray.indices){
          latestTagId += newTagArray(i).get("ruleTagId").get.asInstanceOf[String]
        }
        val tagNameArray = ArrayBuffer[String]()
        if (data._2._2.isDefined) {
          val oldMap = data._2._2.get
          if (oldMap.get("@tag").isDefined && oldMap.get("@tag").get.isInstanceOf[scala.collection.mutable.Buffer[_]]) {
            //读取老标签并加入到新标签中
            val oldTagList = oldMap.get("@tag").get.asInstanceOf[scala.collection.mutable.Buffer[Any]]
            for (i <- oldTagList.indices) {
              if (oldTagList(i).isInstanceOf[scala.collection.mutable.Map[_, _]]) {
                val map = oldTagList(i).asInstanceOf[scala.collection.mutable.Map[String, Any]]
                if (latestTagId.contains(map.get("ruleTagId").get)) {
                  newTagArray += Map("tagValue" -> map.get("tagValue").get, "tagName" -> map.get("tagName").get, "tagTime" -> map.get("tagTime").get, "ruleTagId" -> map.get("ruleTagId").get, "unionTagId" -> map.get("unionTagId").get, "isLatest" -> 0)
                } else {
                  newTagArray += Map("tagValue" -> map.get("tagValue").get, "tagName" -> map.get("tagName").get, "tagTime" -> map.get("tagTime").get, "ruleTagId" -> map.get("ruleTagId").get, "unionTagId" -> map.get("unionTagId").get, "isLatest" -> map.get("isLatest").get)
                }
              }
            }
          }
          //从旧数据里面取东西放到新的数据中，规则为：旧数据中的@tag和@tagIndex数据不取，其他数据中如果新数据中已经有了的不取，没有的取过来加入
          val oldMapKeys = oldMap.keysIterator
          while (oldMapKeys.hasNext) {
            val oldMapKey = oldMapKeys.next()
            if (!"@tag".equals(oldMapKey) && !"@tagIndex".equals(oldMapKey) && !dataMap.contains(oldMapKey)) {
              dataMap ++= Map(oldMapKey -> oldMap.get(oldMapKey).get)
            }
          }
        }
        for (i <- newTagArray.indices) {
          if (newTagArray(i).get("isLatest").get.asInstanceOf[Int] == 1) {
            tagNameArray += newTagArray(i).get("tagName").get.asInstanceOf[String]
          }
        }
        (data._1, dataMap ++ Map("@tag" -> newTagArray.toList, "@tagIndex" -> ("#" + tagNameArray.mkString("#") + "#")))
      }) //.collect() //.foreach(println)
      /**
       * 保存到ES
       */
      //EsSpark.saveJsonToEs(rdd,  Constant.ES_DB_NAME + "/" + tagCalculate.userName)
      Log.info(Constant.ES_DB_NAME + "/" + tagCalculate.userName)
      EsSpark.saveToEsWithMeta(rdd, Constant.ES_DB_NAME)
      System.out.println("---------------------3:"+System.currentTimeMillis())
      System.out.println("---------------------3:"+System.currentTimeMillis())
      tagCalculateService.updateTagCalculateLogs(args(0), "计算成功结束")
      Log.info("计算成功结束")
    } catch {
      case ex: Exception =>
        Log.error("计算发生错误 " + ex.getMessage)
        if (ex.toString.length > 980) {
          tagCalculateService.updateTagCalculateLogs(args(0), "计算发生错误：" + ex.getMessage.substring(0, 980))
        } else {
          tagCalculateService.updateTagCalculateLogs(args(0), "计算发生错误：" + ex.getMessage)
        }
        ex.printStackTrace()
        Container.sparkSession.stop()
        System.exit(1)
    } finally {
      Container.sparkSession.stop()
    }
  }
}
