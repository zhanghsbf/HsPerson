package com.roy.hspersona.common;

import java.util.HashMap;
import java.util.Map;

/**
 * 系统参数相关常量
 */
public class ConstantParam {
	public static final String LOCAL_TMP_PATH = "localTmpPath";
	/**
	 * 系统参数预加载Map
	 */
	public static Map<String, String> paramMap = new HashMap<>();
	/**
	 * 默认密码
	 */
	public static final String DEFAULT_PASSWORD = "defaultPassword";
	/**
	 * 标签图显示深度
	 */
	public static final String TAG_GRAPH_DEPTH = "tagGraphDepth";
	/**
	 * 模型顶级类名
	 */
	public static final String MODEL_TOP_CLASS = "modelTopClass";
	/**
	 * JSONLD的context地址
	 */
	public static final String JSONLD_CONTEXT = "jsonldContext";
	/**
	 * ElasticSearch集群名称
	 */
	public static final String ES_CLUSTER_NAME = "esClusterName";
	/**
	 * ElasticSearch集群入口地址
	 */
	public static final String ES_CLUSTER_IPV4S = "esClusterIpv4s";
	/**
	 * ElasticSearch数据库索引名
	 */
	public static final String ES_INDEX_NAME = "esIndexName";
	/**
	 * 系统hdfs数据存储根目录
	 */
	public static final String DATA_ROOT_PATH = "dataRootPath";
	/**
	 * ETL时数据抽取使用的集群核心数
	 */
	public static final String ETL_PROCESS_CORE_NUM = "etlProcessCoreNum";
	/**
	 * SSH连接的地址
	 */
	public static final String SSH_HOST_NAME = "sshHostName";
	/**
	 * SSH连接的用户名
	 */
	public static final String SSH_USER_NAME = "sshUserName";
	/**
	 * SSH连接的密码
	 */
	public static final String SSH_PASSWORD = "sshPassword";
	/**
	 * 服务器上spark安装目录
	 */
	public static final String SPARK_HOME = "sparkHome";
	/**
	 * 服务器上sqoop安装目录
	 */
	public static final String SQOOP_HOME = "sqoopHome";
	/**
	 * 服务器上hadoop安装目录
	 */
	public static final String HADOOP_HOME = "hadoopHome";
	/**
	 * 计算引擎jar目录
	 */
	public static final String USER_TAG_ENGINE_JAR = "userTagEngineJar";
	/**
	 * webhdfs路径地址前缀
	 */
	public static final String WEB_HDFS_ADDRESS = "webHdfsAddress";
	/**
	 * webhdfs文件系统用户名
	 */
	public static final String WEB_HDFS_USERNAME = "webHdfsUsername";
	/**
	 * spark所在操作系统名称
	 */
	public static final String SPARK_SYSTEM_TYPE = "sparkSystemType";
	/**
	 * Spark的RestAPI接口路径前缀
	 */
	public static final String SPARK_REST_ADDRESS = "sparkRestAddress";
	
}
