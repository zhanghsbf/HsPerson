package com.roy.hspersona.web.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * @author roy
 * @date 2021/12/17
 * @desc
 */
public class NodeDetailVO implements Serializable {
    private static final long serialVersionUID = 7115809565776082774L;
    /**
     * 编号
     */
    private String id;

    /**
     * 个人信息
     */
    private PersonVO person;
    /**
     * 基本信息
     */
    private PanelBaseInfo baseInfo;
    /**
     * 标签信息
     */
    private PanelTagInfo tagInfo;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }


    public PanelBaseInfo getBaseInfo() {
        return baseInfo;
    }

    public void setBaseInfo(PanelBaseInfo baseInfo) {
        this.baseInfo = baseInfo;
    }

    public PanelTagInfo getTagInfo() {
        return tagInfo;
    }

    public void setTagInfo(PanelTagInfo tagInfo) {
        this.tagInfo = tagInfo;
    }

    public PersonVO getPerson() {
        return person;
    }

    public void setPerson(PersonVO person) {
        this.person = person;
    }
}
