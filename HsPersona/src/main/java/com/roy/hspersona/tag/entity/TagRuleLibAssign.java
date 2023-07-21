package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 标签规则库授权表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagRuleLibAssign implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 标签规则库ID
     */
    @TableField("ruleLibId")
    private String ruleLibId;

    /**
     * 所属用户ID
     */
    @TableField("userId")
    private String userId;

    /**
     * 备注
     */
    private String memo;

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
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Override
    public String toString() {
        return "TagRuleLibAssign{" +
            "id=" + id +
            ", ruleLibId=" + ruleLibId +
            ", userId=" + userId +
            ", memo=" + memo +
        "}";
    }
}
