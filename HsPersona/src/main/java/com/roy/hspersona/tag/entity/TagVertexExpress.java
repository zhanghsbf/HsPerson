package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 标签表述模板
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagVertexExpress implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 所属标签
     */
    @TableField("vertexId")
    private String vertexId;

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
    public String getVertexId() {
        return vertexId;
    }

    public void setVertexId(String vertexId) {
        this.vertexId = vertexId;
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
        return "TagVertexExpress{" +
            "id=" + id +
            ", vertexId=" + vertexId +
            ", type=" + type +
            ", express=" + express +
        "}";
    }
}
