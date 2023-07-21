package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 用户计算标签选择表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagCalculateSelect implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 所属计算ID
     */
    @TableField("calculateId")
    private String calculateId;

    /**
     * 选择的标签ID
     */
    @TableField("tagId")
    private String tagId;

    /**
     * 标签计算规则
     */
    private String rule;

    /**
     * 标签内容
     */
    @TableField("tagContent")
    private String tagContent;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getCalculateId() {
        return calculateId;
    }

    public void setCalculateId(String calculateId) {
        this.calculateId = calculateId;
    }
    public String getTagId() {
        return tagId;
    }

    public void setTagId(String tagId) {
        this.tagId = tagId;
    }
    public String getRule() {
        return rule;
    }

    public void setRule(String rule) {
        this.rule = rule;
    }
    public String getTagContent() {
        return tagContent;
    }

    public void setTagContent(String tagContent) {
        this.tagContent = tagContent;
    }

    @Override
    public String toString() {
        return "TagCalculateSelect{" +
            "id=" + id +
            ", calculateId=" + calculateId +
            ", tagId=" + tagId +
            ", rule=" + rule +
            ", tagContent=" + tagContent +
        "}";
    }
}
