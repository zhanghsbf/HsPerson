package com.roy.hspersona.web.entity;

import java.io.Serializable;

public class PanelGraphRelaLink implements Serializable {

	private static final long serialVersionUID = -7344949077320628208L;
	
	private int source;
	private int target;
	private String value;

	public int getSource() {
		return source;
	}

	public void setSource(int source) {
		this.source = source;
	}

	public int getTarget() {
		return target;
	}

	public void setTarget(int target) {
		this.target = target;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
}
