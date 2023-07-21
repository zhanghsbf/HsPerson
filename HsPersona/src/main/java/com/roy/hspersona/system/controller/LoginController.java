package com.roy.hspersona.system.controller;

import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.SessionBean;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.entity.SysPermission;
import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.system.service.LoginService;
import com.roy.hspersona.system.service.SysMenuService;
import com.roy.hspersona.system.service.SysPermissionService;
import com.roy.hspersona.system.service.SysUserService;
import com.roy.hspersona.util.LoginedSessionHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/11/30
 * @desc
 */
@Controller("systemLoginController")
@RequestMapping("/system/login")
public class LoginController extends MngBaseController {

    @Resource
    private LoginService loginService;
    @Resource
    private SysUserService sysUserService;
    @Resource
    private SysPermissionService sysPermissionService;
    @Resource
    private SysMenuService sysMenuService;

    private SysUser user;

    @RequestMapping("/to")
    public String to(Model model){
        model.addAttribute("version", Constant.version);
        return "login";
    }

    @RequestMapping("/ill")
    public String ill(HttpServletResponse response){
        response.setHeader("sessionstatus", "timeout");
        return "invalidSession";
    }

    @RequestMapping("/quickStart")
    public String quickStart(){
        return "system/quickStart";
    }

    @RequestMapping("/check")
    public String check(String loginName, String password, HttpSession session, Model model){
        Object info = loginService.checkUser(loginName, password);
        if (info instanceof SysUser) {
            user = sysUserService.getUserByOrgAndName(loginName, null);
            /**
             * 获取当前用户拥有的权限点，并加载到内存
             */
            List<SysPermission> permissionList = sysPermissionService.getPermissionByUser(user);
            Map<String, String> map = new HashMap<String, String>();
            for (int i = 0; i < permissionList.size(); i++) {
                SysPermission permission = permissionList.get(i);
                map.put(permission.getCode(), permission.getMemo());
            }

            /**
             * 将用户信息放入session中
             */
            SessionBean sessionBean = new SessionBean();
            sessionBean.setUserId(user.getId());
            sessionBean.setRealName(user.getRealName());
            sessionBean.setUserName(user.getName());
            sessionBean.setIndustryTypes(user.getIndustrytypes());
            sessionBean.setInfo("success");
            sessionBean.setPermissionMap(map);
            this.setUserSession(session,sessionBean);
            LoginedSessionHolder.sessionLogin(session);

            return this.success(session,model);
        } else {
            model.addAttribute("info", info);
            model.addAttribute("url", Constant.projectName + "/system/login/to");
            return "information";
        }
    }

    @RequestMapping("/success")
    public String success(HttpSession session,Model model){
        final SessionBean sessionBean = this.getUserSession(session);
        if(null == sessionBean){
            model.addAttribute("info", "登录超时或没有任何权限，请重新登录");
            model.addAttribute("url", Constant.projectName + "/system/login/to");
            return "information";
        }
        //根据用户获取菜单
        final String userId = sessionBean.getUserId();
        model.addAttribute("menu1List",sysMenuService.getMenu1ByUser(userId));
        model.addAttribute("menu2List",sysMenuService.getMenu2ByUser(userId));
        model.addAttribute("menu3List",sysMenuService.getMenu3ByUser(userId));

        return "system/frame";
    }

    @ResponseBody
    @RequestMapping("/out")
    public String out(HttpSession session){
        this.setUserSession(session,null);
        session.invalidate();
        LoginedSessionHolder.sessionLogut(session);
        return this.outSuccessJson();
    }
}
