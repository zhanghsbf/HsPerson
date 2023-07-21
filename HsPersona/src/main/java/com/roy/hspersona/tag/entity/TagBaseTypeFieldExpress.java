package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 基础模型属性表述模板
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagBaseTypeFieldExpress implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    @TableField("baseTypeFieldId")
    private String baseTypeFieldId;

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
    public String getBaseTypeFieldId() {
        return baseTypeFieldId;
    }

    public void setBaseTypeFieldId(String baseTypeFieldId) {
        this.baseTypeFieldId = baseTypeFieldId;
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
        return "TagBaseTypeFieldExpress{" +
            "id=" + id +
            ", baseTypeFieldId=" + baseTypeFieldId +
            ", type=" + type +
            ", express=" + express +
        "}";
    }
}
