package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 标签网边实体类
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagEdge implements Serializable {

    private static final long serialVersionUID = 1L;

    public final static int DADSON = 1;//父子关系边，对应字典表edgeType的父子关系边
    public final static int FRIEND = 2;//朋友关系边，对应字典表edgeType的朋友关系边
    /**
     * 主键ID
     */
    private String id;

    /**
     * 边的一个端点，如果是父子关系的边，A节点必须存放父节点
     */
    @TableField("vertexAid")
    private String vertexAid;

    /**
     * 边的另一个端点，如果是父子关系的边，B节点必须存放子节点
     */
    @TableField("vertexBid")
    private String vertexBid;

    /**
     * 边的类型，具体见字典表type=edgeType
     */
    private Integer type;

    /**
     * 是否可用0不可用，1可用
     */
    private Integer enable;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getVertexAid() {
        return vertexAid;
    }

    public void setVertexAid(String vertexAid) {
        this.vertexAid = vertexAid;
    }
    public String getVertexBid() {
        return vertexBid;
    }

    public void setVertexBid(String vertexBid) {
        this.vertexBid = vertexBid;
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

    @Override
    public String toString() {
        return "TagEdge{" +
            "id=" + id +
            ", vertexAid=" + vertexAid +
            ", vertexBid=" + vertexBid +
            ", type=" + type +
            ", enable=" + enable +
        "}";
    }
}
