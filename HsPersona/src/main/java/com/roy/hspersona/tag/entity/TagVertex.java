package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 标签网顶点实体类
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagVertex implements Serializable {

    private static final long serialVersionUID = 1L;

    public final static int CATAGORY = 1;// 分类节点，对应字典表vertexType的分类节点
    public final static int CONCEPT = 2;// 概念节点，对应字典表vertexType的概念节点
    public final static int RULE = 3;// 规则节点，对应字典表vertexType的规则节点
    public final static int TAG = 4;// 标签节点，对应字典表vertexType的标签节点


    /**
     * 主键ID
     */
    private String id;

    /**
     * 顶点名称
     */
    private String name;

    /**
     * 顶点类型，具体见字典表type=vertexType
     */
    private Integer type;

    /**
     * 是否可用0不可用，1可用
     */
    private Integer enable;

    /**
     * 标签对应的值
     */
    private String value;

    /**
     * 所属的行业ID，值见字典表type=industryType
     */
    @TableField("industryType")
    private Integer industryType;

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
    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
    public Integer getIndustryType() {
        return industryType;
    }

    public void setIndustryType(Integer industryType) {
        this.industryType = industryType;
    }

    @Override
    public String toString() {
        return "TagVertex{" +
            "id=" + id +
            ", name=" + name +
            ", type=" + type +
            ", enable=" + enable +
            ", value=" + value +
            ", industryType=" + industryType +
        "}";
    }

    public String getTypeStr() {
        switch (type) {
            case CATAGORY:
                return "分类节点";
            case CONCEPT:
                return "概念节点";
            case RULE:
                return "规则节点";
            case TAG:
                return "标签节点";
            default:
                return "";
        }
    }

    public String getNameHtml() {
        switch (type) {
            case CATAGORY:
                return name;
            case CONCEPT:
                return "<b>" + name + "</b>";
            case RULE:
                return "<font color=blue><b>" + name + "</b></font>";
            case TAG:
                return "<font color=green><b>" + name + "</b></font>";
            default:
                return name;
        }
    }
}
