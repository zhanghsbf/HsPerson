package com.roy.hspersona.web.entity;

public class PanelTagInfoItem {

	/**
	 * 标签值
	 */
	private String tagValue;
	/**
	 * 标签名
	 */
	private String tagName;
	/**
	 * 所属规则节点ID
	 */
	private String ruleTagId;
	/**
	 * 计算时间
	 */
	private String tagTime;
	/**
	 * 是否最后有效标签，0不是，1是
	 */
	private int isLatest;

	public String getTagValue() {
		return tagValue;
	}

	public void setTagValue(String tagValue) {
		this.tagValue = tagValue;
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public String getRuleTagId() {
		return ruleTagId;
	}

	public void setRuleTagId(String ruleTagId) {
		this.ruleTagId = ruleTagId;
	}

	public String getTagTime() {
		return tagTime;
	}

	public void setTagTime(String tagTime) {
		this.tagTime = tagTime;
	}

	public int getIsLatest() {
		return isLatest;
	}

	public void setIsLatest(int isLatest) {
		this.isLatest = isLatest;
	}
}
