package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 入参配置表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagParamIn implements Serializable {

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
     * 所属标签节点ID，只能是规则节点
     */
    @TableField("tagId")
    private String tagId;

    /**
     * 所属模型属性ID
     */
    @TableField("fieldId")
    private String fieldId;

    /**
     * 上级节点ID
     */
    @TableField("parentId")
    private String parentId;

    /**
     * 树结构编码
     */
    @TableField("treeCode")
    private String treeCode;

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
    public String getFieldId() {
        return fieldId;
    }

    public void setFieldId(String fieldId) {
        this.fieldId = fieldId;
    }
    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
    public String getTreeCode() {
        return treeCode;
    }

    public void setTreeCode(String treeCode) {
        this.treeCode = treeCode;
    }

    @Override
    public String toString() {
        return "TagParamIn{" +
            "id=" + id +
            ", userId=" + userId +
            ", tagId=" + tagId +
            ", fieldId=" + fieldId +
            ", parentId=" + parentId +
            ", treeCode=" + treeCode +
        "}";
    }
}
