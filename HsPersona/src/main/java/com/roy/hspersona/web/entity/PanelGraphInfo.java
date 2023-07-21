package com.roy.hspersona.web.entity;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.common.ConstantDict;
import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: CustomRelationship.java
 * @Description:
 * @since JDK1.7
 * @author zxc
 * @date 2016-7-27 下午9:42:53
 *
 */
public class PanelGraphInfo implements Serializable {

	private static final long serialVersionUID = -2890950711853561607L;

	private String title;

	private List<String> tags = new ArrayList<String>();

	private PanelGraphRelaInfo panelGraphRelaInfo;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public List<String> getTags() {
		return tags;
	}

	public void setTags(List<String> tags) {
		this.tags = tags;
	}

	public PanelGraphRelaInfo getPanelGraphRelaInfo() {
		return panelGraphRelaInfo;
	}

	public void setPanelGraphRelaInfo(PanelGraphRelaInfo panelGraphRelaInfo) {
		this.panelGraphRelaInfo = panelGraphRelaInfo;
	}

	public void setTags(JSONObject jsonObject) {
		if (jsonObject != null) {
			List<String> list = new ArrayList<String>();
			// 获取人的标签
			JSONArray jsonArray = jsonObject.getJSONArray("@tag");
			if (null != jsonArray && !jsonArray.isEmpty()) {
				for (int i = 0; i < jsonArray.size(); i++) {
					JSONObject object = jsonArray.getJSONObject(i);
					if (object.get("isLatest") != null && object.getInteger("isLatest") == 1) {
						list.add((String) object.getString("tagName"));
					}
				}
			}
			if (list.size() > 0) {
				int i = 0;
				// 如果不够50个，循环重复取，筹齐50个
				while (list.size() < 50) {
					list.add(list.get(i++));
				}
			}
			this.tags = list;
		}
	}

	public void setPanelGraphRelaInfo(JSONArray jsonArray) {
		if (jsonArray != null) {

			Map<String, Integer> nodeMap = new HashMap<String, Integer>();
			Map<String, Integer> linkMap = new HashMap<String, Integer>();
			PanelGraphRelaInfo relaInfo = new PanelGraphRelaInfo();
			List<PanelGraphRelaNode> nodes = new ArrayList<PanelGraphRelaNode>();
			List<PanelGraphRelaLink> links = new ArrayList<PanelGraphRelaLink>();

			// jsonArray中第一条存放的是自己的数据，其他存放的是与自己有关系的人的数据。
			for (int i = 0; i < jsonArray.size(); i++) {
				JSONObject jsonObject = jsonArray.getJSONObject(i);
				String id = (String) jsonObject.get("unid");
				// 第一条本次查询用户的数据，先将自己作为一个节点放入。其他记录因为包含在第一条的关系节点中，所以不需要再放入
				if (i == 0) {
					PanelGraphRelaNode nodeMe = new PanelGraphRelaNode(id, jsonObject.get("name"));
					nodes.add(nodeMe);
					nodeMap.put(nodeMe.getId(), 0);
				}
				JSONArray familyArray = (JSONArray) jsonObject.get("family");
				if (familyArray != null) {
					for (int j = 0; j < familyArray.size(); j++) {
						JSONObject familyObject = familyArray.getJSONObject(j);
						/*
						 * 先将节点放入
						 */
						String memberId = (String) familyObject.get("familyMemberLabel");
						if (StringUtils.isNotEmpty(memberId)) {
							// 节点在Map中没有的时候才放入
							if (nodeMap.get(memberId) == null) {
								PanelGraphRelaNode node = new PanelGraphRelaNode(memberId, familyObject.get("familyMembername"));
								nodes.add(node);
								nodeMap.put(memberId, nodes.size() - 1);
							}
							if (linkMap.get(id + "@@" + memberId) == null && linkMap.get(memberId + "@@" + id) == null) {
								PanelGraphRelaLink link = new PanelGraphRelaLink();
								link.setSource(nodeMap.get(id));
								link.setTarget(nodeMap.get(memberId));
								String relaCode = (String) familyObject.get("familyRelationsCode");
								if (StringUtils.isNotEmpty(relaCode)) {
									link.setValue(ConstantDict.tagDictMap.get("familyRelationsCode").get(relaCode));
								}
								links.add(link);
								linkMap.put(id + "@@" + memberId, 0);
							}
						}
					}
				}
			}
			relaInfo.setNodes(nodes);
			relaInfo.setLinks(links);
			this.panelGraphRelaInfo = relaInfo;
		}
	}
}
