package com.roy.hspersona.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.roy.hspersona.system.entity.SysMenu;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * <p>
 * 菜单表 Mapper 接口
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public interface SysMenuMapper extends BaseMapper<SysMenu> {

    @Select("select distinct m1.* " +
            "from sys_role as r,sys_user_role as ur,sys_role_permission as rp,sys_permission as p, sys_menu as m3,sys_menu as m2,sys_menu as m1 " +
            "where r.id=ur.roleId " +
            "and ur.roleId=rp.roleId " +
            "and rp.permissionId=p.id " +
            "and p.menuId=m3.id " +
            "and m3.parentId=m2.id " +
            "and m2.parentId=m1.id " +
            "and r.enable=1 " +
            "and m3.enable=1 " +
            "and ur.userId =  #{userId} " +
            "order by m1.treeCode ")
    List<SysMenu> getMenu1ByUserId(String userid);

    @Select("select distinct m2.* " +
            "from sys_role as r,sys_user_role as ur,sys_role_permission as rp,sys_permission as p,sys_menu as m3,sys_menu as m2 " +
            "where r.id=ur.roleId " +
            "and ur.roleId=rp.roleId " +
            "and rp.permissionId=p.id " +
            "and p.menuId=m3.id " +
            "and m3.parentId=m2.id " +
            "and r.enable=1 " +
            "and m3.enable=1 " +
            "and ur.userId = #{userId} " +
            "order by m2.treeCode")
    public List<SysMenu> getMenu2ByUserId(String userid);

    @Select("select distinct m.* " +
            "from sys_role as r,sys_user_role as ur,sys_role_permission as rp,sys_permission as p,sys_menu as m " +
            "where r.id=ur.roleId " +
            "and ur.roleId=rp.roleId " +
            "and rp.permissionId=p.id " +
            "and p.menuId=m.id " +
            "and r.enable=1 " +
            "and m.enable=1 " +
            "and ur.userId = #{userId} " +
            "order by m.treeCode")
    public List<SysMenu> getMenu3ByUserId(String userid);

    @Update("update sys_menu set enable= #{enable} where treeCode like '${treeCode}%'")
    void updateChildEnable(SysMenu menu);


    @Select("select treeCode " +
            "from sys_menu " +
            "where parentId=#{parentId} " +
            "order by treeCode desc limit 1")
    String getMaxTreeCode(String parentId);

    @Select("select * from sys_menu where treeCode like '${treeCode}%' order by treeCode")
    List<SysMenu> getAllChildMenu(SysMenu menu);
}
