package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 标签规则库表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagRuleLib implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 规则库名称
     */
    private String name;

    /**
     * 规则库描述
     */
    private String description;

    /**
     * 所属规则节点
     */
    @TableField("tagId")
    private String tagId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public String getTagId() {
        return tagId;
    }

    public void setTagId(String tagId) {
        this.tagId = tagId;
    }

    @Override
    public String toString() {
        return "TagRuleLib{" +
            "id=" + id +
            ", name=" + name +
            ", description=" + description +
            ", tagId=" + tagId +
        "}";
    }
}
