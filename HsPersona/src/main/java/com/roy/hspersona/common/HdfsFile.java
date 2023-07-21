package com.roy.hspersona.common;

import java.util.Date;

/**
 * hdfs文件信息实体
 */
public class HdfsFile {

	/**
	 * 文件或文件夹名称
	 */
	private String name;
	/**
	 * 类型DIRECTORY文件夹，FILE文件
	 */
	private String type;
	/**
	 * 包含的子项个数
	 */
	private int childrenNum;
	/**
	 * 修改时间
	 */
	private Date modificationTime;
	/**
	 * 文件大小，单位B
	 */
	private long length = 0;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getChildrenNum() {
		return childrenNum;
	}

	public void setChildrenNum(int childrenNum) {
		this.childrenNum = childrenNum;
	}

	public Date getModificationTime() {
		return modificationTime;
	}

	public void setModificationTime(Date modificationTime) {
		this.modificationTime = modificationTime;
	}

	public long getLength() {
		return length;
	}

	public void setLength(long length) {
		this.length = length;
	}

}
