package com.roy.hspersona.system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.system.entity.SysMenu;
import com.roy.hspersona.system.entity.SysMenuExt;
import com.roy.hspersona.system.entity.SysPermission;
import com.roy.hspersona.system.mapper.SysMenuMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/1
 * @desc
 */
@Service
public class SysMenuService {

    @Resource
    private SysMenuMapper sysMenuMapper;

    @Resource
    private SysPermissionService sysPermissionService;
    /**
     * @Description: 根据登录用户获取三级menu实体列表
     * @param userId : 用户数据
     * @return: 该用户可见的三级菜单数据
     */
    public List<SysMenu> getMenu3ByUser(String userId) {
        if (StringUtils.isEmpty(userId)) {
            return new ArrayList<SysMenu>();
        }
        return sysMenuMapper.getMenu3ByUserId(userId);
    }

    /**
     * @Description: 根据登录用户获取二级menu实体列表
     * @param userId : 用户数据
     * @return: 该用户可见的二级菜单数据
     */
    public List<SysMenu> getMenu2ByUser(String userId) {
        if (StringUtils.isEmpty(userId)) {
            return new ArrayList<SysMenu>();
        }
        return sysMenuMapper.getMenu2ByUserId(userId);
    }

    /**
     * @Description: 根据登录用户获取一级menu实体列表
     * @param userId : 用户数据
     * @return: 该用户可见的一级菜单数据
     */
    public List<SysMenu> getMenu1ByUser(String userId) {
        if (StringUtils.isEmpty(userId)) {
            return new ArrayList<>();
        }
        return sysMenuMapper.getMenu1ByUserId(userId);
    }

    /**
     * @Description: 构建有所有菜单构成【表格树】节点关系
     * @return: 已构建成功的菜单节点关系
     */
    public List<SysMenu> genMenuTreeGridNode() {
        // 获取已按treeCode排好序的list
        List<SysMenu> list = this.getAllMenu();
        List<SysMenuExt> nodeList = new ArrayList<>();
        for (int i = 0; i < list.size(); i++) {
            SysMenu menu = list.get(i);
            SysMenuExt menuExt = new SysMenuExt(menu);
            /*
             * 如果是一级菜单(length=TreeNode.CODE_LEN)直接加入nodeList
             * 如果是二级菜单(length=TreeNode
             * .CODE_LEN*2)那么nodeList的最后一个节点一定是他的父节点，因为list是按treeCode排好序的
             * 如果是三级菜单
             * (length=TreeNode.CODE_LEN*3)那么nodeList的最后一个节点的孩子的最后一个节点一定是他的父节点
             * ，理由同上
             */
            if (menu.getTreeCode().length() == TreeNode.CODE_LEN) {
                nodeList.add(menuExt);
            } else if (menu.getTreeCode().length() == TreeNode.CODE_LEN * 2) {
                nodeList.get(nodeList.size() - 1).getChildren().add(menuExt);
            } else if (menu.getTreeCode().length() == TreeNode.CODE_LEN * 3) {
                int size = nodeList.get(nodeList.size() - 1).getChildren().size();
                nodeList.get(nodeList.size() - 1).getChildren().get(size - 1).getChildren().add(menuExt);
            }
        }
        List<SysMenu> res = new ArrayList<>();
        SysMenuExt sysMenuExt = new SysMenuExt();
        sysMenuExt.setId(TreeNode.TOP_NODE_ID);
        sysMenuExt.setName("菜单根节点");
        sysMenuExt.setEnable(1);
        sysMenuExt.setChildren(nodeList);
        res.add(sysMenuExt);
        return res;
    }

    public List<SysMenu> getAllMenu() {
        QueryWrapper<SysMenu> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("treeCode");
        return sysMenuMapper.selectList(queryWrapper);
    }

    public List<SysMenu> queryMenu(String name,String parentId){
        QueryWrapper<SysMenu> queryWrapper = new QueryWrapper<>();
        if(StringUtils.isNotEmpty(name)){
            queryWrapper.eq("name",name);
        }
        if(StringUtils.isNotEmpty(parentId)){
            queryWrapper.eq("parentId",parentId);
        }
        queryWrapper.orderByAsc("treeCode");
        return sysMenuMapper.selectList(queryWrapper);
    }
    /**
     * @Description: 判断一个菜单是否能删除（所有子孙节点及本节点对应的权限点是否被引用）
     * @param menuId : 菜单ID
     * @return: true说明能删除，false说明被引用不能删除
     */
    public boolean canDeleteMenuId(String menuId) {
        SysMenu menu = sysMenuMapper.selectById(menuId);
        List<SysPermission> list = sysPermissionService.getUsedPermissionByParentTreeCode(menu.getTreeCode());
        return list.size() == 0;
    }

    public SysMenu getMenuById(String menuId) {
        return sysMenuMapper.selectById(menuId);
    }

    public void deleteMenuByTreeCode(String pTreeCode) {
        sysPermissionService.deletePermissionByMenuTreeCode(pTreeCode);
        UpdateWrapper<SysMenu> cond = new UpdateWrapper<>();
        cond.like("treeCode",pTreeCode+"%");
        sysMenuMapper.delete(cond);
    }

    public void updateMenuEnable(SysMenu menu) {
        menu.setEnable((menu.getEnable() + 1) % 2);
        sysMenuMapper.updateById(menu);
        sysMenuMapper.updateChildEnable(menu);
    }

    public void updateMenu(SysMenu menu) {
        sysMenuMapper.updateById(menu);
    }

    public String genTreeCode(String parentId) {
        String pTreeCode = "";
        if (!parentId.equals(TreeNode.TOP_NODE_ID)) {
            SysMenu pMenu = this.getMenuById(parentId);
            pTreeCode = pMenu.getTreeCode();
        }
        int index = 0;
        String brotherCode = sysMenuMapper.getMaxTreeCode(parentId);
        if (brotherCode != null) {
            String subCode = brotherCode.substring(pTreeCode.length());
            index = Integer.parseInt(subCode);
        }
        return pTreeCode + TreeNode.genTreeCode(index + 1);
    }

    public void saveMenu(SysMenu menu) {
        sysMenuMapper.insert(menu);
    }

    public void sortMenuForList(List<SysMenu> list) {
        for (int i = 0; i < list.size(); i++) {
            SysMenu menu = list.get(i);
            if (StringUtils.isNotEmpty(menu.getTreeCode())) {
                if (i == 0) {
                    String pTreeCode = menu.getTreeCode().substring(0, menu.getTreeCode().length() - TreeNode.CODE_LEN);
                    menu.setTreeCode(pTreeCode + TreeNode.genTreeCode(1));
                    list.set(i, menu);
                    continue;
                }
                SysMenu upMenu = list.get(i - 1);
                // 与上一个菜单比，分三种情况分析，treeCode大于、小于、等于
                if (upMenu.getTreeCode().length() < menu.getTreeCode().length()) {
                    menu.setTreeCode(upMenu.getTreeCode() + TreeNode.genTreeCode(1));
                } else if (upMenu.getTreeCode().length() == menu.getTreeCode().length()) {
                    String upMenuTreeCode = upMenu.getTreeCode();
                    String brotherCode = upMenuTreeCode.substring(upMenuTreeCode.length() - TreeNode.CODE_LEN, upMenuTreeCode.length());
                    int brotherNum = Integer.parseInt(brotherCode);
                    menu.setTreeCode(upMenuTreeCode.substring(0, upMenuTreeCode.length() - TreeNode.CODE_LEN) + TreeNode.genTreeCode(brotherNum + 1));
                } else {
                    String upMenuTreeCode = upMenu.getTreeCode().substring(0, menu.getTreeCode().length());
                    String brotherCode = upMenuTreeCode.substring(upMenuTreeCode.length() - TreeNode.CODE_LEN, upMenuTreeCode.length());
                    int brotherNum = Integer.parseInt(brotherCode);
                    menu.setTreeCode(upMenuTreeCode.substring(0, upMenuTreeCode.length() - TreeNode.CODE_LEN) + TreeNode.genTreeCode(brotherNum + 1));
                }
                list.set(i, menu);
            } else {
                list.remove(i--);
            }
        }
        for (SysMenu menu : list) {
            final int res = sysMenuMapper.updateById(menu);
            if(res<=0){
                sysMenuMapper.insert(menu);
            }
        }
        for (int i = 0; i < list.size(); i++) {
            SysMenu menu = list.get(i);
            if (menu.getTreeCode().length() == TreeNode.CODE_LEN * 3) {
                sysPermissionService.sortPermissionByMenu(menu);
            }
        }
    }

    public void sortMenuForArray(String[] menuIds) {
        List<SysMenu> menuList = new ArrayList<SysMenu>();
        for (int i = 0; i < menuIds.length; i++) {
            SysMenu menu = this.getMenuById(menuIds[i]);
            List<SysMenu> list = this.getAllChildMenu(menu);
            menuList.addAll(list);
        }
        this.sortMenuForList(menuList);
    }

    private List<SysMenu> getAllChildMenu(SysMenu menu) {
        return sysMenuMapper.getAllChildMenu(menu);
    }

    /**
     * @Description: 构建有所有菜单构成【树】节点关系
     * @return: 已构建成功的菜单节点关系
     */
    public TreeNode genMenuTreeNode() {
        List<SysMenu> list = this.getAllMenu();
        List<TreeNode> nodeList = new ArrayList<TreeNode>();
        for (int i = 0; i < list.size(); i++) {
            SysMenu menu = list.get(i);
            TreeNode node = new TreeNode();
            node.setId(menu.getId());
            node.setText(menu.getName());
            if (menu.getTreeCode().length() == TreeNode.CODE_LEN) {
                nodeList.add(node);
            } else if (menu.getTreeCode().length() == TreeNode.CODE_LEN * 2) {
                nodeList.get(nodeList.size() - 1).getChildren().add(node);
            } else if (menu.getTreeCode().length() == TreeNode.CODE_LEN * 3) {
                int size = nodeList.get(nodeList.size() - 1).getChildren().size();
                nodeList.get(nodeList.size() - 1).getChildren().get(size - 1).getChildren().add(node);
            }
        }
        TreeNode rootNode = new TreeNode();
        rootNode.setId(TreeNode.TOP_NODE_ID);
        rootNode.setText("系统菜单树");
        rootNode.setChildren(nodeList);
        return rootNode;
    }
}
