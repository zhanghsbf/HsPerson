package com.roy.hspersona.system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.core.base.BaseService;
import com.roy.hspersona.system.entity.SysMenu;
import com.roy.hspersona.system.entity.SysPermission;
import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.system.mapper.SysPermissionMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: SysPermissionService
 * @Description: 权限点相关业务处理Service
 * @author
 * @date
 */
@Service
public class SysPermissionService extends BaseService {

	@Resource
	private SysPermissionMapper sysPermissionMapper;
	@Resource
	private SysMenuService sysMenuService;

	/**
	 * @Description: 根据用户信息获取所拥有的权限点
	 * @param user : 用户数据
	 * @return: 拥有的权限点列表
	 */
	public List<SysPermission> getPermissionByUser(SysUser user) {
		if (user == null || StringUtils.isEmpty(user.getId())) {
			return new ArrayList<>();
		}
//		return sysPermissionDao.getPermissionByUserId(user.getId());
		final List<SysPermission> sysPermissions = sysPermissionMapper.getPermissionByUserId(user.getId());
		return sysPermissions;
	}

	public List<SysPermission> getUsedPermissionByParentTreeCode(String treeCode) {
		return sysPermissionMapper.getUsedPermissionByParentTreeCode(treeCode);
	}

	public void deletePermissionByMenuTreeCode(String pTreeCode) {
		UpdateWrapper<SysPermission> cond = new UpdateWrapper<>();
		cond.like("treeCode",pTreeCode+"%");
		sysPermissionMapper.delete(cond);
	}

	public void sortPermissionByMenu(SysMenu menu) {
		QueryWrapper<SysPermission> cond = new QueryWrapper<>();
		cond.eq("menuId",menu.getId());
		final List<SysPermission> list = sysPermissionMapper.selectList(cond);

		for (int i = 0; i < list.size(); i++) {
			SysPermission permission = list.get(i);
			String treeCode = menu.getTreeCode() + TreeNode.genTreeCode(i + 1);
			if (!treeCode.equals(permission.getTreeCode())) {
				permission.setTreeCode(treeCode);
				sysPermissionMapper.updateById(permission);
			}
		}
	}

	public List<SysPermission> getPermission(String code, String menuId){
		QueryWrapper<SysPermission> queryWrapper = new QueryWrapper<>();
		if(StringUtils.isNotEmpty(code)){
			queryWrapper.eq("code",code);
		}
		if(StringUtils.isNotEmpty(menuId)){
			queryWrapper.eq("menuId",menuId);
		}
		queryWrapper.orderByAsc("treeCode");
		return sysPermissionMapper.selectList(queryWrapper);
	}

	public SysPermission getPermissionById(String id) {
		return sysPermissionMapper.selectById(id);
	}

	public int deletePermissionById(String id) {
		//删除前检查依赖关系 根本就没有维护外键
		//删除
		return sysPermissionMapper.deleteById(id);

	}

	public String genTreeCode(String menuId) {
		SysMenu menu = sysMenuService.getMenuById(menuId);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menuId", menuId);
		List<SysPermission> list = this.getPermission("",menuId);
		if (list.size() == 0) {
			return menu.getTreeCode() + TreeNode.genTreeCode(1);
		} else {
			SysPermission permission = list.get(list.size() - 1);
			int length = permission.getTreeCode().length();
			int i = Integer.parseInt(permission.getTreeCode().substring(length - TreeNode.CODE_LEN, length)) + 1;
			return menu.getTreeCode() + TreeNode.genTreeCode(i);
		}
	}

	public void savePermission(SysPermission permission) {
		sysPermissionMapper.insert(permission);
	}

	public void updatePermission(SysPermission permission) {
		sysPermissionMapper.updateById(permission);
	}

    public TreeNode genPermissionTreeNode(String roleId) {
		// 按treeCode排好的的菜单列表menuList
		List<SysMenu> menuList = sysMenuService.getAllMenu();
		// 按treeCode排好序的权限点列表permissionList
		List<SysPermission> permissionList = this.getAllPermission();
//		Map<String,Object> param = new HashMap<>();
//		param.put("id",roleId);
//		List<SysPermission> haveList = sysPermissionMapper.selectByMap(param);
		List<SysPermission> haveList = sysPermissionMapper.getPermissionByRoleId(roleId);
		// 将已有权限的权限点放入Map中后随时读取
		Map<String, String> haveMap = new HashMap<>();
		for (int i = 0; i < haveList.size(); i++) {
			haveMap.put(haveList.get(i).getId(), "have");
		}

		List<TreeNode> nodeList = new ArrayList<TreeNode>();
		for (int i = 0, j = 0; i < menuList.size(); i++) {
			SysMenu menu = menuList.get(i);
			TreeNode node = new TreeNode();
			node.setId(menu.getId());
			node.setText(menu.getName());
			/*
			 * 如果是一级菜单(length=TreeNode.CODE_LEN)直接加入nodeList
			 * 如果是二级菜单(length=TreeNode.CODE_LEN*2)那么nodeList的最后一个节点一定是他的父节点
			 * ，因为menuList是按treeCode排好序的 如果是三级菜单(length=TreeNode.CODE_LEN*3)
			 * 那么nodeList的最后一个节点的孩子的最后一个节点一定是他的父节点，理由同上
			 * 三级菜单时，同时处理权限点节点，将权限点节点作为三级菜单的子节点处理
			 */
			if (menu.getTreeCode().length() == TreeNode.CODE_LEN) {
				nodeList.add(node);
			} else if (menu.getTreeCode().length() == TreeNode.CODE_LEN * 2) {
				nodeList.get(nodeList.size() - 1).getChildren().add(node);
			} else if (menu.getTreeCode().length() == TreeNode.CODE_LEN * 3) {
				while (j < permissionList.size()) {
					SysPermission permission = permissionList.get(j);
					String treeCode = permission.getTreeCode().substring(0, TreeNode.CODE_LEN * 3);
					if (treeCode.compareTo(menu.getTreeCode()) > 0) {
						break;
					} else if (menu.getTreeCode().equals(treeCode)) {
						TreeNode nodePermission = new TreeNode();
						nodePermission.setId(permission.getId());
						nodePermission.setText(permission.getMemo());
						if (haveMap.get(permission.getId()) != null) {
							nodePermission.setChecked(true);
						}
						node.getChildren().add(nodePermission);
					}
					j++;
				}
				int size = nodeList.get(nodeList.size() - 1).getChildren().size();
				nodeList.get(nodeList.size() - 1).getChildren().get(size - 1).getChildren().add(node);
			}
		}
		TreeNode rooNode = new TreeNode();
		rooNode.setId("");
		rooNode.setText("系统权限点");
		rooNode.setChildren(nodeList);
		return rooNode;
    }

	private List<SysPermission> getAllPermission() {
		QueryWrapper<SysPermission> queryWrapper = new QueryWrapper<>();
		queryWrapper.orderByAsc("treeCode");
		return sysPermissionMapper.selectList(queryWrapper);
	}

	public TreeNode genHavePermissionTreeNode(String roleId) {
		List<SysMenu> menuList = sysMenuService.getAllMenu();
		List<SysPermission> haveList = sysPermissionMapper.getPermissionByRoleId(roleId);

		// menu的treeCode与permssion的treeCode是一一对应的
		// 两个List都已按treeCode排序
		// 下面是去掉没有权限关联的菜单，包括一、二、三级，利用上面的规则
		for (int i = 0; i < menuList.size(); i++) {
			boolean have = false;
			for (int j = 0; j < haveList.size(); j++) {
				SysMenu menu = menuList.get(i);
				SysPermission permission = haveList.get(j);
				String treeCode = permission.getTreeCode().substring(0, menu.getTreeCode().length());
				if (treeCode.compareTo(menu.getTreeCode()) > 0) {
					break;
				} else if (treeCode.compareTo(menu.getTreeCode()) == 0) {
					have = true;
					break;
				}
			}
			if (!have) {
				menuList.remove(i);
				i--;
			}
		}
		List<TreeNode> nodeList = new ArrayList<>();
		for (int i = 0, j = 0; i < menuList.size(); i++) {
			SysMenu menu = menuList.get(i);
			TreeNode node = new TreeNode();
			node.setId(menu.getId());
			node.setText(menu.getName());
			if (menu.getTreeCode().length() == TreeNode.CODE_LEN) {
				nodeList.add(node);
			} else if (menu.getTreeCode().length() == TreeNode.CODE_LEN * 2) {
				nodeList.get(nodeList.size() - 1).getChildren().add(node);
			} else if (menu.getTreeCode().length() == TreeNode.CODE_LEN * 3) {
				while (j < haveList.size()) {
					SysPermission permission = haveList.get(j);
					String treeCode = permission.getTreeCode().substring(0, TreeNode.CODE_LEN * 3);
					if (treeCode.compareTo(menu.getTreeCode()) > 0) {
						break;
					} else if (menu.getTreeCode().equals(treeCode)) {
						TreeNode nodePermission = new TreeNode();
						nodePermission.setId(permission.getId());
						nodePermission.setText(permission.getMemo());
						node.getChildren().add(nodePermission);
					}
					j++;
				}
				int size = nodeList.get(nodeList.size() - 1).getChildren().size();
				nodeList.get(nodeList.size() - 1).getChildren().get(size - 1).getChildren().add(node);
			}
		}
		TreeNode rooNode = new TreeNode();
		rooNode.setId("");
		rooNode.setText("系统权限点");
		rooNode.setChildren(nodeList);
		return rooNode;
	}

    public boolean havePermisssion(String userId, String permissionCode) {
		List<SysPermission> list = sysPermissionMapper.queryUserPermission(userId,permissionCode);
		return list.size() > 0;
    }
}
