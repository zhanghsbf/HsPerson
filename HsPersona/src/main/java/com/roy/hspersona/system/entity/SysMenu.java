package com.roy.hspersona.system.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;

/**
 * <p>
 * 菜单表
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public class SysMenu implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 菜单名称
     */
    private String name;

    /**
     * 菜单URL
     */
    private String url;

    /**
     * 树结构编码
     */
    @TableField("treeCode")
    private String treeCode;

    /**
     * 父节点ID
     */
    @TableField("parentId")
    private String parentId;

    /**
     * 是否可用，0不可用，1可用
     */
    private Integer enable;

    /**
     * 菜单级别。临时字段，不存入数据库
     */
    @TableField(exist=false)
    private int levels;

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
    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
    public String getTreeCode() {
        return treeCode;
    }

    public void setTreeCode(String treeCode) {
        this.treeCode = treeCode;
    }
    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    public int getLevels() {
        return levels;
    }

    public void setLevels(int levels) {
        this.levels = levels;
    }

    @Override
    public String toString() {
        return "SysMenu{" +
            "id=" + id +
            ", name=" + name +
            ", url=" + url +
            ", treeCode=" + treeCode +
            ", parentId=" + parentId +
            ", enable=" + enable +
        "}";
    }
}
