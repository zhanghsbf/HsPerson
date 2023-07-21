package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 行业扩展模型属性表述模板
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagExtTypeFieldExpress implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 行业类型（见字典表type=industryType）
     */
    @TableField("industryType")
    private Integer industryType;

    @TableField("extTypeFieldId")
    private String extTypeFieldId;

    /**
     * 表达类型，具体见字典表type=expressType
     */
    private Integer type;

    /**
     * 表达模板
     */
    private String express;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public Integer getIndustryType() {
        return industryType;
    }

    public void setIndustryType(Integer industryType) {
        this.industryType = industryType;
    }
    public String getExtTypeFieldId() {
        return extTypeFieldId;
    }

    public void setExtTypeFieldId(String extTypeFieldId) {
        this.extTypeFieldId = extTypeFieldId;
    }
    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
    public String getExpress() {
        return express;
    }

    public void setExpress(String express) {
        this.express = express;
    }

    @Override
    public String toString() {
        return "TagExtTypeFieldExpress{" +
            "id=" + id +
            ", industryType=" + industryType +
            ", extTypeFieldId=" + extTypeFieldId +
            ", type=" + type +
            ", express=" + express +
        "}";
    }
}
