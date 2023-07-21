package com.roy.hspersona.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.system.entity.SysUser;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

/**
 * <p>
 * 系统用户表 Mapper 接口
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public interface SysUserMapper extends BaseMapper<SysUser> {

    @Select("select u.* " +
            "from sys_user as u,sys_org as o " +
            "where u.orgid=o.id " +
            "and o.treeCode like '${treeCode}%' " +
            "order by name "
            )
    Page<SysUser> getUserByOrgTreeCode(Page<SysUser> page,@Param("treeCode")String treeCode);
}
