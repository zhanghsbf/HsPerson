package com.roy.hspersona.system.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 机构表
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public class SysOrg implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 机构名称
     */
    private String name;

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
     * 机构类型，参见字典表中type=orgType的数据
     */
    private Integer type;

    /**
     * 状态：1：正常，0：废弃
     */
    private Integer status;

    /**
     * 状态：1：正常，0：废弃
     */
    private Integer leaf;

    @TableField(exist = false)
    private String typeName;

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
    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    public Integer getLeaf() {
        return leaf;
    }

    public void setLeaf(Integer leaf) {
        this.leaf = leaf;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    @Override
    public String toString() {
        return "SysOrg{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", treeCode='" + treeCode + '\'' +
                ", parentId='" + parentId + '\'' +
                ", type=" + type +
                ", status=" + status +
                ", leaf=" + leaf +
                ", typeName='" + typeName + '\'' +
                '}';
    }
}
