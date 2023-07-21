package com.roy.hspersona.web.entity;

import java.io.Serializable;

/**
 * @ClassName: KeyValue.java
 * @Description:
 */
public class KeyValue implements Serializable {

	private static final long serialVersionUID = -7386428322180201842L;

	private String key;
	private Object value;
	
	public KeyValue(String key, Object value) {
		super();
		this.key = key;
		this.value = value;
	}
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public Object getValue() {
		return value;
	}
	public void setValue(Object value) {
		this.value = value;
	}
}
