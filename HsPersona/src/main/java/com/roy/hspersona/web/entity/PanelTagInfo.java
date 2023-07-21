package com.roy.hspersona.web.entity;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.util.DateUtil;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/17
 * @desc
 */
public class PanelTagInfo implements Serializable {

    private static final long serialVersionUID = -465915436334971673L;
    /**
     * 面板标题
     */
    private String title;
    /**
     * 标签列表
     */
    private List<PanelTagInfoItem> panelTagInfoItems = new ArrayList<PanelTagInfoItem>();

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<PanelTagInfoItem> getPanelTagInfoItems() {
        return panelTagInfoItems;
    }

    public void setPanelTagInfoItems(List<PanelTagInfoItem> panelTagInfoItems) {
        this.panelTagInfoItems = panelTagInfoItems;
    }

    public void setPanelTagInfoItems(JSONObject jsonObject) {
        if (jsonObject != null) {
            List<PanelTagInfoItem> list = new ArrayList<PanelTagInfoItem>();
            // 获取人的标签
            JSONArray jsonArray = (JSONArray) jsonObject.get("@tag");
            if (null != jsonArray && !jsonArray.isEmpty()) {
                for (int i = 0; i < jsonArray.size(); i++) {
                    JSONObject object = jsonArray.getJSONObject(i);
                    PanelTagInfoItem item = new PanelTagInfoItem();
                    if (object.get("isLatest") != null) {
                        item.setIsLatest(object.getInteger("isLatest"));
                    }
                    item.setTagValue((String) object.getString("tagValue"));
                    item.setTagName((String) object.getString("tagName"));
                    item.setRuleTagId((String) object.getString("ruleTagId"));
                    if (object.get("tagTime") != null) {
                        item.setTagTime(DateUtil.toString(new Date(object.getLong("tagTime")), "yyyy-MM-dd"));
                    }
                    list.add(0, item);
                }
            }
            this.panelTagInfoItems = list;
        }
    }
}
