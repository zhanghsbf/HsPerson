package com.roy.hspersona.system.entity;

import com.roy.hspersona.common.TreeNode;

import java.util.ArrayList;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/3
 * @desc
 */
public class SysMenuExt extends SysMenu {

    private static final long serialVersionUID = 2883267683674418773L;

    /**
     * 树节点状态:open展开，closed折叠
     */
    private String state;

    /**
     * 树节点的子节点列表
     */
    private List<SysMenuExt> children = new ArrayList<SysMenuExt>();

    public SysMenuExt() {
    }

    public SysMenuExt(SysMenu menu) {
        this.setId(menu.getId());
        this.setName(menu.getName());
        this.setParentId(menu.getParentId());
        this.setTreeCode(menu.getTreeCode());
        this.setUrl(menu.getUrl());
        this.setEnable(menu.getEnable());
        this.setLevels(menu.getTreeCode().length() / TreeNode.CODE_LEN);
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public List<SysMenuExt> getChildren() {
        return children;
    }

    public void setChildren(List<SysMenuExt> children) {
        this.children = children;
    }
}
