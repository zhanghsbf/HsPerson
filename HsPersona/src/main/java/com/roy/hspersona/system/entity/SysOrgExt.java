package com.roy.hspersona.system.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/3
 * @desc
 */
public class SysOrgExt extends SysOrg{

    private static final long serialVersionUID = 5537389082037859237L;

    /**
     * 树节点状态:open展开，closed折叠
     */
    private String state;

    /**
     * 树节点的子节点列表
     */
    private List<SysOrgExt> children = new ArrayList<SysOrgExt>();

    public SysOrgExt() {
    }

    public SysOrgExt(SysOrg org) {
        this.setId(org.getId());
        this.setName(org.getName());
        this.setParentId(org.getParentId());
        this.setTreeCode(org.getTreeCode());
        this.setType(org.getType());
        this.setTypeName(org.getTypeName());
        this.setStatus(org.getStatus());
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public List<SysOrgExt> getChildren() {
        return children;
    }

    public void setChildren(List<SysOrgExt> children) {
        this.children = children;
    }
}
