package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 标签规则库入参详细表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagParamInLib implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 所属标签规则库ID
     */
    @TableField("ruleLibId")
    private String ruleLibId;

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
    public String getRuleLibId() {
        return ruleLibId;
    }

    public void setRuleLibId(String ruleLibId) {
        this.ruleLibId = ruleLibId;
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
        return "TagParamInLib{" +
            "id=" + id +
            ", ruleLibId=" + ruleLibId +
            ", fieldId=" + fieldId +
            ", parentId=" + parentId +
            ", treeCode=" + treeCode +
        "}";
    }
}
