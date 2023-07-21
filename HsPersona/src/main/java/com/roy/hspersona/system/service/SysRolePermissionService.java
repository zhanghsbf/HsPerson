package com.roy.hspersona.system.service;

import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.roy.hspersona.system.entity.SysRolePermission;
import com.roy.hspersona.system.mapper.SysRolePermissionMapper;
import com.roy.hspersona.util.KeyUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author roy
 * @date 2021/12/5
 * @desc
 */
@Service
public class SysRolePermissionService {

    @Resource
    private SysRolePermissionMapper sysRolePermissionMapper;


    public void deleteRolePermissionByRoleId(String roleId) {
        UpdateWrapper<SysRolePermission> wrapper = new UpdateWrapper<>();
        wrapper.eq("roleId",roleId);
        sysRolePermissionMapper.delete(wrapper);
    }

    public void assignPermissionToRole(String roleId, String[] ida) {
        UpdateWrapper<SysRolePermission> deleteWrapper = new UpdateWrapper<>();
        deleteWrapper.eq("roleId",roleId);
        sysRolePermissionMapper.delete(deleteWrapper);
        for (int i = 0; i < ida.length; i++) {
            SysRolePermission rolePermission = new SysRolePermission();
            rolePermission.setId(KeyUtil.getKey());
            rolePermission.setPermissionId(ida[i]);
            rolePermission.setRoleId(roleId);
            sysRolePermissionMapper.insert(rolePermission);
        }
    }
}
