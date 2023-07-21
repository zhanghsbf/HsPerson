package com.roy.hspersona.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.roy.hspersona.system.entity.SysPermission;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 权限点表 Mapper 接口
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public interface SysPermissionMapper extends BaseMapper<SysPermission> {

    @Select("select p.id,p.`code`,p.memo,p.menuId,p.treeCode " +
            "from sys_role r , sys_user_role ur , sys_role_permission rp , sys_permission p " +
            "where r.id=ur.roleId and ur.roleId = rp.roleId and rp.permissionId = p.id and r.`enable`=1 and ur.userId=#{userId}")
    List<SysPermission> getPermissionByUserId(String userId);

    @Select("select distinct p.* " +
            "from sys_role_permission as rp,sys_permission as p " +
            "where rp.permissionId=p.id " +
            "and p.treeCode like '${treeCode}%'")
    List<SysPermission> getUsedPermissionByParentTreeCode(String treeCode);

    @Select("select p.* " +
            "from sys_role_permission as rp,sys_permission as p " +
            "where rp.permissionId=p.id " +
            "and rp.roleId = #{roleId} order by treeCode")
    List<SysPermission> getPermissionByRoleId(@Param("roleId") String roleId);

    @Select("select distinct p.* " +
            "from sys_role as r,sys_user_role as ur,sys_role_permission as rp,sys_permission as p " +
            "where r.id=ur.roleId and ur.roleId=rp.roleId and rp.permissionId=p.id " +
            "and r.enable=1 and ur.userId = #{userId} and p.code = #{permissionCode}")
    List<SysPermission> queryUserPermission(@Param("userId") String userId, @Param("permissionCode") String permissionCode);
}
