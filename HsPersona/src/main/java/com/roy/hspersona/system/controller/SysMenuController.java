package com.roy.hspersona.system.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.entity.SysMenu;
import com.roy.hspersona.system.entity.SysMenuExt;
import com.roy.hspersona.system.service.SysMenuService;
import com.roy.hspersona.system.service.SysPermissionService;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/3
 * @desc
 */
@Controller
@RequestMapping("/system/menu")
public class SysMenuController extends MngBaseController {

    @Resource
    private SysMenuService sysMenuService;

    @Resource
    private SysPermissionService sysPermissionService;

    @RequestMapping("/to")
    public String to(){
        return "system/initMenu";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(){
        List<SysMenu> menuExt = sysMenuService.genMenuTreeGridNode();
        return menuExt;
    }

    @ResponseBody
    @RequestMapping("/getChild")
    public Object getChild(String menuId){
        Map<String, Object> res = new HashMap<String, Object>();
        List<SysMenu> list = sysMenuService.queryMenu("",menuId);
        res.put("total", list.size());
        res.put("rows",list);
        return res;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String menuId){
        if (StringUtils.isNotEmpty(menuId)) {
            boolean canDelete = sysMenuService.canDeleteMenuId(menuId);
            if (canDelete) {
                SysMenu menu = sysMenuService.getMenuById(menuId);
                sysMenuService.deleteMenuByTreeCode(menu.getTreeCode());
                return this.outSuccessJson();
            } else {
                return this.outFailJson("存在部分该菜单或子孙菜单所对应的权限点已经被引用");
            }
        } else {
            return this.outFailJson("传入的菜单ID为空");
        }
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object edit(String id){
        if (StringUtils.isNotEmpty(id)) {
            return sysMenuService.getMenuById(id);
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/ban")
    public String ban(String menuId){
        if (StringUtils.isNotEmpty(menuId)) {
            SysMenu menu = sysMenuService.getMenuById(menuId);
            sysMenuService.updateMenuEnable(menu);
            return this.outSuccessJson();
        }else{
            return this.outFailJson("传入的启禁菜单ID为空");
        }
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(SysMenu sysMenu){
        String parentId = sysMenu.getParentId();
        String name = sysMenu.getName();
        String id = sysMenu.getId();
        String url = sysMenu.getUrl();
        if (StringUtils.isEmpty(name)) {
            return this.outFailJson("菜单名称为空！");
        }
        if (StringUtils.isEmpty(parentId)) {
            return this.outFailJson("父节点ID为空！");
        }

        if (StringUtils.isEmpty(id)) {
            int enable = 1;
            if (!TreeNode.TOP_NODE_ID.equals(parentId)) {
                SysMenu parentMenu = sysMenuService.getMenuById(parentId);
                enable = parentMenu.getEnable();
            }
            SysMenu menu = new SysMenu();
            menu.setId(KeyUtil.getKey());
            menu.setName(name);
            menu.setParentId(parentId);
            menu.setUrl(url);
            menu.setEnable(enable);// 与上级状态同步
            menu.setTreeCode(sysMenuService.genTreeCode(parentId));
            sysMenuService.saveMenu(menu);
            return this.outSuccessJson();
        } else {
            SysMenu menu = sysMenuService.getMenuById(id);
            if (menu == null) {
                return this.outFailJson("传入的菜单ID错误");
            }
            menu.setName(name);
            menu.setUrl(url);
            sysMenuService.updateMenu(menu);
            return this.outSuccessJson();
        }
    }

    /**
     * @Title: allSort
     * @Description: 菜单按现有顺序全部重排（把空余的编号挪移补充）
     * @return
     */
    @ResponseBody
    @RequestMapping("/allSort")
    public String allSort(){
        List<SysMenu> list = sysMenuService.getAllMenu();
        SysMenu rootMenu = new SysMenu();
        rootMenu.setId(TreeNode.TOP_NODE_ID);
        rootMenu.setTreeCode("");
        list.add(0, rootMenu);
        sysMenuService.sortMenuForList(list);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/sort")
    public String sort( String menuId){
        if (StringUtils.isNotEmpty(menuId)) {
            String[] ida = menuId.split(";");
            sysMenuService.sortMenuForArray(ida);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的排序菜单ID字符串为空");
        }
    }

    @ResponseBody
    @RequestMapping("/tree")
    public Object tree(){
        TreeNode treeNode = sysMenuService.genMenuTreeNode();
        List<TreeNode> res = new ArrayList<>();
        res.add(treeNode);
        return res;
    }

    @ResponseBody
    @RequestMapping("/treePermission")
    public Object treePermission(String roleId) {
        TreeNode treeNode = sysPermissionService.genPermissionTreeNode(roleId);
        List<TreeNode> res = new ArrayList<>();
        res.add(treeNode);
        return res;
    }

    @ResponseBody
    @RequestMapping("/treeHavePermission")
    public Object treeHavePermission(String roleId) {
        TreeNode treeNode = sysPermissionService.genHavePermissionTreeNode(roleId);
        List<TreeNode> res = new ArrayList<>();
        res.add(treeNode);
        return res;
    }
}
