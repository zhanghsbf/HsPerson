package com.roy.hspersona.system.entity;

import java.io.Serializable;

/**
 * <p>
 * 系统角色表
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public class SysRole implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 角色名称
     */
    private String name;

    /**
     * 是否可用：0不可用，1可用
     */
    private Integer enable;

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
    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    @Override
    public String toString() {
        return "SysRole{" +
            "id=" + id +
            ", name=" + name +
            ", enable=" + enable +
        "}";
    }
}
