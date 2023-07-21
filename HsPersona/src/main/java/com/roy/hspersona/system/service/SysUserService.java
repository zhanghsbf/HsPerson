package com.roy.hspersona.system.service;

import com.baomidou.mybatisplus.core.conditions.query.Query;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Constants;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.core.base.BaseService;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.system.mapper.SysUserMapper;
import com.roy.hspersona.tag.entity.TagAccount;
import com.roy.hspersona.tag.service.TagAccountService;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 系统用户相关业务处理Service
 * @author
 * @date
 */
@Service
public class SysUserService extends BaseService {

	@Resource
	private SysUserMapper sysUserMapper;

	@Resource
	private TagAccountService tagAccountService;
	@Resource
	private SysUserRoleService sysUserRoleService;

	/**
	 * @Description: 根据登录用户名和机构ID获取用户
	 * @param name: 登录用户名
	 * @param orgId: 机构Id
	 * @return: 用户数据
	 */
	public SysUser getUserByOrgAndName(String name, String orgId) {
		QueryWrapper<SysUser> cond = new QueryWrapper<>();
		cond.eq("name",name);
		if(StringUtils.isNotEmpty(orgId)){
			cond.eq("orgId",orgId);
		}
		final List<SysUser> sysUsers = sysUserMapper.selectList(cond);
		if(sysUsers.size()>0){
			return sysUsers.get(0);
		}
		return null;
	}

	/**
	 * @Description: 根据用户主键ID删除用户数据，删除用户之前需要查验account表中是否只有自己或者是否可以删除
	 * @param id: 用户数据主键ID
	 * @return: 删除结果提示信息
	 */
	public void deleteUserById(String id) throws MyException {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("userId", id);
		Page<TagAccount> searchResult = tagAccountService.getTagAccount(map, 1, 2);
		if(searchResult.getTotal()>1){
			throw new MyException("该用户存在客户账户，不允许删除！");
		}else if(searchResult.getTotal()==1){
			tagAccountService.deleteTagAccount(searchResult.getRecords().get(0));
		}

		sysUserRoleService.deleteUserRoleByUserId(id);

		sysUserMapper.deleteById(id);
	}
	
	/**
	 * 更新用户信息，更新用户信息时需要同步更新account信息
	 * @param user 用户信息
	 */
	public void updateUser(SysUser user) {
//		TagAccount tagAccount = tagAccountService.getTagAccountByAccount(user.getName());
//		if(tagAccount!=null ){
//			//只会有用户真实姓名的修改
//			tagAccount.setPassword(user.getPassword());
//			tagAccount.setRealName(user.getRealName());
//			tagAccount.setStatus(user.getEnable());
//		}
		sysUserMapper.updateById(user);
	}
	
	/**
	 * 保存用户，保存用户需要同时向Account表中插入相关数据
	 * @param user
	 */
	public void saveUser(SysUser user) {
		sysUserMapper.insert(user);
		//保存前端用户
		TagAccount tagAccount = new TagAccount();
		tagAccount.setId(KeyUtil.getKey());
		tagAccount.setAccount(user.getName());
		tagAccount.setPassword(user.getPassword());
		tagAccount.setRealName(user.getRealName());
		tagAccount.setStatus(0);
		tagAccount.setMemo("系统用户");
		tagAccount.setType(TagAccount.ACCOUNT_TYPE_SYS_USER);
		tagAccountService.saveTagAccount(tagAccount);
	}

	public SysUser getUserById(String id){
		return sysUserMapper.selectById(id);
	}

    public Page<SysUser> getUserByOrgTreeCode(String treeCode, long page, long rows) {
		Page<SysUser> pager = new Page<>(page,rows);
		QueryWrapper<SysUser> queryWrapper = new QueryWrapper<>();
		queryWrapper.like("treeCode",treeCode+"%");
		queryWrapper.orderByAsc("name");
		return sysUserMapper.getUserByOrgTreeCode(pager,treeCode);
//		return sysUserMapper.selectPage(pager,queryWrapper);
    }
}
