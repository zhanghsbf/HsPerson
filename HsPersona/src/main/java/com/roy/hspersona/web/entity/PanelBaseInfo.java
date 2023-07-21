package com.roy.hspersona.web.entity;

import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.util.DateUtil;
import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/17
 * @desc
 */
public class PanelBaseInfo implements Serializable {
    private static final long serialVersionUID = 9012635292111544034L;
    /**
     * 面板标题
     */
    private String title;
    /**
     * 介绍信息
     */
    private String introduce;
    /**
     * 总评分，通常结合机器学习给出一个总的评估分。
     */
    private double score = 0.00;
    /**
     * 基本信息，以map的形式进行存储，方便进行动态
     */
    private List<KeyValue> baseInfoItems = new ArrayList<>();

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public List<KeyValue> getBaseInfoItems() {
        return baseInfoItems;
    }

    public void setBaseInfoItems(List<KeyValue> baseInfoItems) {
        this.baseInfoItems = baseInfoItems;
    }

    public void setBaseInfoItems(JSONObject jsonObject) {
        List<KeyValue> list = new ArrayList<KeyValue>();
        list.add(new KeyValue("民族", "暂未提供"));
        list.add(new KeyValue("国籍", "暂未提供"));
        list.add(new KeyValue("年龄", "暂未提供"));
        list.add(new KeyValue("出生地", "暂未提供"));
        this.baseInfoItems = list;
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }
}
