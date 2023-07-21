package com.roy.hspersona.web.entity;

import java.io.Serializable;

public class PanelGraphRelaNode implements Serializable {

	private static final long serialVersionUID = -1813770778496116613L;

	private String id;
	private String name;

	public PanelGraphRelaNode() {
		super();
	}

	public PanelGraphRelaNode(String id, Object name) {
		super();
		this.id = id;
		this.name = (String) name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

}
