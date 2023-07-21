package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 行业扩展模型数据类型
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagExtType implements Serializable {

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

    /**
     * 父数据类型
     */
    @TableField("parentTypeId")
    private String parentTypeId;

    /**
     * 数据类型编码
     */
    private String code;

    /**
     * 类名称
     */
    private String name;

    /**
     * 树结构编码
     */
    @TableField("treeCode")
    private String treeCode;

    /**
     * 类类型，具体参见字典表type=dataType
     */
    private Integer type;

    /**
     * 是否首先显示：0是，1不是
     */
    @TableField("isFirstShow")
    private Integer isFirstShow;

    /**
     * 备注
     */
    private String memo;

    /**
     * 层级，临时字段
     */
    @TableField(exist = false)
    private int level;
    /**
     * 属性字符串，临时字段
     */
    @TableField(exist = false)
    private String attrString;

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
    public String getParentTypeId() {
        return parentTypeId;
    }

    public void setParentTypeId(String parentTypeId) {
        this.parentTypeId = parentTypeId;
    }
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getTreeCode() {
        return treeCode;
    }

    public void setTreeCode(String treeCode) {
        this.treeCode = treeCode;
    }
    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
    public Integer getIsFirstShow() {
        return isFirstShow;
    }

    public void setIsFirstShow(Integer isFirstShow) {
        this.isFirstShow = isFirstShow;
    }
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getAttrString() {
        return attrString;
    }

    public void setAttrString(String attrString) {
        this.attrString = attrString;
    }

    @Override
    public String toString() {
        return "TagExtType{" +
            "id=" + id +
            ", industryType=" + industryType +
            ", parentTypeId=" + parentTypeId +
            ", code=" + code +
            ", name=" + name +
            ", treeCode=" + treeCode +
            ", type=" + type +
            ", isFirstShow=" + isFirstShow +
            ", memo=" + memo +
        "}";
    }
}
