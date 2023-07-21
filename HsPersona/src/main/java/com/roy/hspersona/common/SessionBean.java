package com.roy.hspersona.common;

import java.io.Serializable;
import java.util.Map;

/**
 * @ClassName: SessionBean
 * @Description: 用户登录信息实体，登录后放入session中
 * @author
 * @date
 */
public class SessionBean implements Serializable {

	private static final long serialVersionUID = 1L;

	/**
	 * 用户编号ID
	 */
	private String userId;
	/**
	 * 账户ID，只有前端登陆才有
	 */
	private String accountId;
	/**
	 * 账户号，只有前端登陆才有
	 */
	private String accountName;
	/**
	 * 用户登陆名
	 */
	private String userName;
	/**
	 * 用户真实姓名
	 */
	private String realName;
	/**
	 * 登录提示信息
	 */
	private String info;
	/**
	 * 所属行业，如1,2,3
	 */
	private String industryTypes;
	/**
	 * 权限Map
	 */
	private Map<String, String> permissionMap;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRealName() {
		return realName;
	}

	public void setRealName(String realName) {
		this.realName = realName;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public Map<String, String> getPermissionMap() {
		return permissionMap;
	}

	public void setPermissionMap(Map<String, String> permissionMap) {
		this.permissionMap = permissionMap;
	}

	public String getAccountId() {
		return accountId;
	}

	public void setAccountId(String accountId) {
		this.accountId = accountId;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getIndustryTypes() {
		return industryTypes;
	}

	public void setIndustryTypes(String industryTypes) {
		this.industryTypes = industryTypes;
	}
}
