package com.roy.hspersona.system.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.roy.hspersona.system.entity.SysOrg;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 * 机构表 Mapper 接口
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public interface SysOrgMapper extends BaseMapper<SysOrg> {

    @Select("select treeCode " +
            "from sys_org " +
            "where parentId=#{parentId} " +
            "order by treeCode desc limit 1")
    String getMaxTreeCode(String parentId);

    @Select("select * from sys_org where treeCode like '${treeCode}%' order by treeCode")
    List<SysOrg> getAllChildOrg(String treeCode);

    @ResultType(Integer.class)
    @Select("select count(u.id) count from sys_user as u,sys_org as o where u.orgid=o.id and o.treeCode like #{treeCode}    ")
    Integer queryOrgUser(String treeCode);
}
