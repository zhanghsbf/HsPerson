package com.roy.hspersona.web.entity;

import com.roy.hspersona.web.anno.TagElement;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName: DataVOList.java
 * @Description:搜索的数据列表中用于展示的对象。 需要根据模型定制
 * @since JDK1.7
 */
public class PersonVO implements Serializable {

	private static final long serialVersionUID = -6027168233985832722L;
	/**
	 * 主键ID
	 */
	private String id;
	/**
	 * 姓名
	 */
	@TagElement("DS_USER_NAME")
	private String name;
	/**
	 * 年龄
	 */
	@TagElement(value = "DS_USER_AGE",formatMethod = "formatAge")
	private String age;
	/**
	 * 性别
	 */
	@TagElement(value = "DS_USER_GENDER")
	private String gender;
	/**
	 * 手机号
	 */
	@TagElement(value = "DS_USER_PHONE")
	private String phone;
	/**
	 * 注册时间
	 */
	@TagElement(value="DS_USER_REGTIME")
	private String regTime;
	/**
	 * 身份证号
	 */
	@TagElement(value="DS_USER_IDENTIFICATION")
	private String idcard;
	/**
	 * 地址
	 */
	@TagElement("DS_USER_HOMEADDR")
	private String address;

	/**
	 * 预留字段1
	 */
	@TagElement("DS_USER_ORDER_COUNT")
	private String refer1;
	/**
	 * 预留字段2
	 */
	@TagElement("DS_USER_ORDER_AMOUNT")
	private String refer2;
	/**
	 * 预留字段3
	 */
	private String refer3;

	/**
	 * 预留字段3
	 */
	private String refer4;
	/**
	 * 预留字段3
	 */
	private String refer5;
	/**
	 * 预留字段3
	 */
	private String refer6;
	/**
	 * 预留字段3
	 */
	private String refer7;
	/**
	 * 预留字段3
	 */
	private String refer8;
	/**
	 * 描述
	 */
	private String description;
	/**
	 * 标签列表
	 */
	private List<String> tagNames = new ArrayList<String>();

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<String> getTagNames() {
		return tagNames;
	}

	public void setTagNames(List<String> tagNames) {
		this.tagNames = tagNames;
	}

	public String getRefer1() {
		return refer1;
	}

	public void setRefer1(String refer1) {
		this.refer1 = refer1;
	}

	public String getRefer2() {
		return refer2;
	}

	public void setRefer2(String refer2) {
		this.refer2 = refer2;
	}

	public String getRefer3() {
		return refer3;
	}

	public void setRefer3(String refer3) {
		this.refer3 = refer3;
	}

	public String getRefer4() {
		return refer4;
	}

	public void setRefer4(String refer4) {
		this.refer4 = refer4;
	}

	public String getRefer5() {
		return refer5;
	}

	public void setRefer5(String refer5) {
		this.refer5 = refer5;
	}

	public String getRefer6() {
		return refer6;
	}

	public void setRefer6(String refer6) {
		this.refer6 = refer6;
	}

	public String getRefer7() {
		return refer7;
	}

	public void setRefer7(String refer7) {
		this.refer7 = refer7;
	}

	public String getRefer8() {
		return refer8;
	}

	public void setRefer8(String refer8) {
		this.refer8 = refer8;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getRegTime() {
		return regTime;
	}

	public void setRegTime(String regTime) {
		this.regTime = regTime;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}
}
