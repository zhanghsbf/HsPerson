package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 基础模型数据类型属性
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagBaseTypeField implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    @TableField("belongTypeId")
    private String belongTypeId;

    @TableField("typeElementId")
    private String typeElementId;

    /**
     * 自己的数据类型
     */
    @TableField("selfTypeId")
    private String selfTypeId;

    /**
     * 属性数据类型长度
     */
    @TableField("typeLength")
    private Integer typeLength;

    /**
     * 属性数据类型精度
     */
    @TableField("typePrecision")
    private Integer typePrecision;

    /**
     * 是否是列表：0不是，1是
     */
    @TableField("isArray")
    private Integer isArray;

    /**
     * 搜索时是否可查询：0不是，1是
     */
    @TableField("isQuery")
    private Integer isQuery;

    /**
     * 说明
     */
    private String memo;

    /**
     * 临时字段，不关联数据库
     */
    @TableField(exist = false)
    private String tmp;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getBelongTypeId() {
        return belongTypeId;
    }

    public void setBelongTypeId(String belongTypeId) {
        this.belongTypeId = belongTypeId;
    }
    public String getTypeElementId() {
        return typeElementId;
    }

    public void setTypeElementId(String typeElementId) {
        this.typeElementId = typeElementId;
    }
    public String getSelfTypeId() {
        return selfTypeId;
    }

    public void setSelfTypeId(String selfTypeId) {
        this.selfTypeId = selfTypeId;
    }
    public Integer getTypeLength() {
        return typeLength;
    }

    public void setTypeLength(Integer typeLength) {
        this.typeLength = typeLength;
    }
    public Integer getTypePrecision() {
        return typePrecision;
    }

    public void setTypePrecision(Integer typePrecision) {
        this.typePrecision = typePrecision;
    }
    public Integer getIsArray() {
        return isArray;
    }

    public void setIsArray(Integer isArray) {
        this.isArray = isArray;
    }
    public Integer getIsQuery() {
        return isQuery;
    }

    public void setIsQuery(Integer isQuery) {
        this.isQuery = isQuery;
    }
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }


    public String getTmp() {
        return tmp;
    }

    public void setTmp(String tmp) {
        this.tmp = tmp;
    }

    @Override
    public String toString() {
        return "TagBaseTypeField{" +
            "id=" + id +
            ", belongTypeId=" + belongTypeId +
            ", typeElementId=" + typeElementId +
            ", selfTypeId=" + selfTypeId +
            ", typeLength=" + typeLength +
            ", typePrecision=" + typePrecision +
            ", isArray=" + isArray +
            ", isQuery=" + isQuery +
            ", memo=" + memo +
        "}";
    }
}
