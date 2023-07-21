package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 标签规则库详细表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagRuleLibDetail implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 所属规则库
     */
    @TableField("ruleLibId")
    private String ruleLibId;

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
    public String getRuleLibId() {
        return ruleLibId;
    }

    public void setRuleLibId(String ruleLibId) {
        this.ruleLibId = ruleLibId;
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
        return "TagRuleLibDetail{" +
            "id=" + id +
            ", ruleLibId=" + ruleLibId +
            ", type=" + type +
            ", rule=" + rule +
        "}";
    }
}
