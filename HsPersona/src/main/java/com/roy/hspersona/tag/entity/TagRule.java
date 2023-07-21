package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 标签规则表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagRule implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 所属用户
     */
    @TableField("userId")
    private String userId;

    /**
     * 所属标签节点ID
     */
    @TableField("tagId")
    private String tagId;

    /**
     * 规则类型，具体见type=ruleType字典
     */
    private Integer type;

    /**
     * 规则
     */
    private String rule;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getTagId() {
        return tagId;
    }

    public void setTagId(String tagId) {
        this.tagId = tagId;
    }
    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
    public String getRule() {
        return rule;
    }

    public void setRule(String rule) {
        this.rule = rule;
    }

    @Override
    public String toString() {
        return "TagRule{" +
            "id=" + id +
            ", userId=" + userId +
            ", tagId=" + tagId +
            ", type=" + type +
            ", rule=" + rule +
        "}";
    }
}
