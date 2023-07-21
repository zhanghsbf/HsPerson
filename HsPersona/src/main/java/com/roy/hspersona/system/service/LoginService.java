package com.roy.hspersona.system.service;

import com.roy.hspersona.system.entity.SysUser;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author roy
 * @date 2021/11/30
 * @desc
 */
@Service
public class LoginService {
    @Resource
    private SysUserService sysUserService;

    public Object checkUser(String name, String password) {
        String userPwdCode = password;
        SysUser user = sysUserService.getUserByOrgAndName(name, null);
        if (user == null) {
            return "用户名（" + name + "）不存在";
        }
        String userPasswd = user.getPassword();
        if(StringUtils.isBlank(userPasswd)||  !userPwdCode.equalsIgnoreCase(userPasswd)){
            return "密码输入错误";
        }
        if (user.getEnable() == 0) {
            return "该账户不可用，请联系管理员";
        }
        return user;
    }
}
