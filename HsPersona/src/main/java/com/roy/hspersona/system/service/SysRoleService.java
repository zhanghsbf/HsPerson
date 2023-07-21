package com.roy.hspersona.system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.system.entity.SysRole;
import com.roy.hspersona.system.mapper.SysRoleMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/5
 * @desc
 */
@Service
public class SysRoleService {

    @Resource
    private SysRoleMapper sysRoleMapper;

    @Resource
    private SysRolePermissionService sysRolePermissionService;

    public Page<SysRole> getRoleByName(String name, Long page, Long rows) {
        QueryWrapper<SysRole> queryWrapper = new QueryWrapper<>();
        if(StringUtils.isNotEmpty(name)){
            queryWrapper.eq("name",name);
        }
        Page<SysRole> pager = new Page<>(page,rows);
        return sysRoleMapper.selectPage(pager, queryWrapper);

    }

    public SysRole getRoleById(String roleId) {
        return sysRoleMapper.selectById(roleId);
    }

    public void updateRole(SysRole role) {
        sysRoleMapper.updateById(role);
    }

    public int deleteRoleById(String roleId) {
        sysRolePermissionService.deleteRolePermissionByRoleId(roleId);
        return sysRoleMapper.deleteById(roleId);
    }

    public void saveRole(SysRole role) {
        sysRoleMapper.insert(role);
    }

    public List<SysRole> getAllRole() {
        final QueryWrapper<SysRole> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("id");
        return sysRoleMapper.selectList(queryWrapper);
    }
}
