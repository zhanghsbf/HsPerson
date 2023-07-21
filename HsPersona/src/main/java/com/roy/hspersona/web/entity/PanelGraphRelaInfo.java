package com.roy.hspersona.web.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PanelGraphRelaInfo implements Serializable {

	private static final long serialVersionUID = 8338250303028441791L;

	private List<PanelGraphRelaNode> nodes = new ArrayList<PanelGraphRelaNode>();
	private List<PanelGraphRelaLink> links = new ArrayList<PanelGraphRelaLink>();

	public List<PanelGraphRelaNode> getNodes() {
		return nodes;
	}

	public void setNodes(List<PanelGraphRelaNode> nodes) {
		this.nodes = nodes;
	}

	public List<PanelGraphRelaLink> getLinks() {
		return links;
	}

	public void setLinks(List<PanelGraphRelaLink> links) {
		this.links = links;
	}
}
