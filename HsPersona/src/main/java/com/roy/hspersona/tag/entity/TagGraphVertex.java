package com.roy.hspersona.tag.entity;

import java.io.Serializable;

/**
 * @author roy
 * @date 2021/12/9
 * @desc
 */
public class TagGraphVertex implements Serializable {

    private static final long serialVersionUID = -8576455938888479709L;
    /**
     * 顶点ID
     */
    private String id;
    /**
     * 顶点名称
     */
    private String name;
    /**
     * 顶点组
     */
    private int group;
    /**
     * 深度
     */
    private int depth;

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

    public int getGroup() {
        return group;
    }

    public void setGroup(int group) {
        this.group = group;
    }

    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }
}
