package com.roy.hspersona.tag.entity;

import java.io.Serializable;

/**
 * @author roy
 * @date 2021/12/9
 * @desc
 */
public class TagGraphEdge implements Serializable {

    private static final long serialVersionUID = 5776307797806623640L;

    /**
     * 边ID
     */
    private String id;
    /**
     * 来源顶点索引
     */
    private int source;
    /**
     * 目的顶点索引
     */
    private int target;
    /**
     * 附属值
     */
    private int value;

    public int getSource() {
        return source;
    }
    public void setSource(int source) {
        this.source = source;
    }
    public int getTarget() {
        return target;
    }
    public void setTarget(int target) {
        this.target = target;
    }
    public int getValue() {
        return value;
    }
    public void setValue(int value) {
        this.value = value;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
}
