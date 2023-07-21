package com.roy.hspersona.common;

import java.util.HashMap;
import java.util.Map;

/**
 * 系统字典表type的常量类
 */
public class ConstantDict {

	/**
	 * 标签字典-预加载Map
	 */
	public static Map<String, Map<String, String>> tagDictMap = new HashMap<String, Map<String, String>>();

	/**
	 * 系统字典-机构类型
	 */
	public static final String ORG_TYPE = "orgType";
	/**
	 * 系统字典-标签图边类型
	 */
	public static final String EDGE_TYPE = "edgeType";
	/**
	 * 系统字典-标签图顶点类型
	 */
	public static final String VERTEX_TYPE = "vertexType";
	/**
	 * 系统字典-数据类类型
	 */
	public static final String DATA_TYPE = "dataType";
	/**
	 * 系统字典-标签节点规则类型
	 */
	public static final String RULE_TYPE = "ruleType";
	/**
	 * 系统字典-基础模型属性表述模版类型
	 */
	public static final String EXPRESS_TYPE = "expressType";
	/**
	 * 系统字典-数据库类型
	 */
	public static final String DB_TYPE = "dbType";
	/**
	 * 系统字典-行业类型
	 */
	public static final String INDUSTRY_TYPE = "industryType";
	/**
	 * 系统字典-任务类型
	 */
	public static final String TASK_TYPE ="taskType";
	/**
	 * 系统字典--周期
	 */
	public static final String CYCLE="cycle";
}
