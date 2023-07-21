package com.roy.hspersona.system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.roy.hspersona.system.entity.SysUserRole;
import com.roy.hspersona.system.mapper.SysUserRoleMapper;
import com.roy.hspersona.util.KeyUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/5
 * @desc
 */
@Service
public class SysUserRoleService {
    @Resource
    private SysUserRoleMapper sysUserRoleMapper;

    public List<SysUserRole> getUserRoleByRoleId(String roleId) {
        QueryWrapper<SysUserRole> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("roleId",roleId);
        return sysUserRoleMapper.selectList(queryWrapper);
    }

    public List<SysUserRole> getUserRoleByUserId(String userId) {
        QueryWrapper<SysUserRole> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("userId",userId);
        queryWrapper.orderByDesc("roleId");
        return sysUserRoleMapper.selectList(queryWrapper);
    }

    public void assignRoleToUser(String userId, String[] ida) {
        UpdateWrapper<SysUserRole> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("userId",userId);
        sysUserRoleMapper.delete(updateWrapper);
        for (int i = 0; i < ida.length; i++) {
            SysUserRole sur = new SysUserRole();
            sur.setId(KeyUtil.getKey());
            sur.setRoleId(ida[i]);
            sur.setUserId(userId);
            sysUserRoleMapper.insert(sur);
        }
    }

    public void deleteUserRoleByUserId(String userId) {
        UpdateWrapper<SysUserRole> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("userId",userId);
        sysUserRoleMapper.delete(updateWrapper);
    }
}
