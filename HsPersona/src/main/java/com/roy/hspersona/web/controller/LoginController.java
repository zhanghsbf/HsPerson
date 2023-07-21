package com.roy.hspersona.web.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.SessionBean;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.tag.entity.TagAccount;
import com.roy.hspersona.tag.service.TagAccountService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author roy
 * @date 2021/11/30
 * @desc
 */
@Controller("webLoginController")
@RequestMapping("/web/login")
public class LoginController extends WebBaseController {

    @Resource
    private TagAccountService tagAccountService;

    @RequestMapping("/to")
    public String to(){
        return "web/login";
    }

    @RequestMapping("/check")
    public String check(@RequestParam(defaultValue = "-1") String loginName, String password,
                        HttpSession session, Model model, HttpServletResponse response) throws IOException {
        String info = "";
        if (StringUtils.isNotEmpty(loginName) && StringUtils.isNotEmpty(password)) {
            // 用户名和密码不为空
            // 校验登陆用户用户名与密码
            String userPwdCode = password;
            Map<String, Object> map = new HashMap<>();
            map.put("ww_account", loginName);
            Page<TagAccount> searchResult = tagAccountService.getTagAccount(map, 1, 1);
            TagAccount tagAccount = searchResult.getRecords().size() > 0 ? searchResult.getRecords().get(0) : null;
            if (tagAccount == null) {
                info = "用户名（" + loginName + "）不存在";
            } else if (!userPwdCode.toUpperCase().equals(tagAccount.getPassword().toUpperCase())) {
                info = "密码输入错误";
            } else if (tagAccount.getStatus() == 0) {
                info = "该账户不可用，请联系管理员";
            }

            if ("".equals(info)) {
                // 登录成功
                // 获取用户信息,此处共用系统用户服务类
                // 进行session保存操作
                // 将用户信息放入session中
                SessionBean sessionBean = new SessionBean();
                sessionBean.setUserId(tagAccount.getUserId());
                sessionBean.setUserName(tagAccount.getRealName());
                sessionBean.setAccountId(tagAccount.getId());
                sessionBean.setAccountName(tagAccount.getAccount());
                sessionBean.setRealName(tagAccount.getRealName());
                sessionBean.setInfo("success");
                setAccountSession(session,sessionBean);
//                response.sendRedirect("/web/seach/search");
                return "redirect:/web/search/search";
            }
            // 登录失败
        } else {
            info = "用户名或密码为空！";
        }
        // 若用户登录不成功
        model.addAttribute("info", info);
        model.addAttribute("url","/web/login/to");
        return "information";
    }

    @RequestMapping("/out")
    public String out(HttpSession session) {
        try {
            setAccountSession(session,null);
            session.invalidate();
            // this.outSuccessJson();
        } catch (Exception e) {
            // this.outFailJson(e.toString());
        }
        return "web/login";
    }

    @ResponseBody
    @RequestMapping("/changePassword")
    public String changePassword(String oldPass, String newPass, HttpSession session) {
        if(StringUtils.isBlank(oldPass) || StringUtils.isBlank(newPass)){
            return this.outFailJson("参数异常");
        }
        //验证密码
        TagAccount tagAccount = tagAccountService.getTagAccountByAccount(this.getAccountSession(session).getAccountName());
        if(!oldPass.equalsIgnoreCase(tagAccount.getPassword())){
            return this.outFailJson("原密码输入错误");
        }
        //更新密码
        tagAccount.setPassword(newPass);
        tagAccountService.updateTagAccount(tagAccount);
        return this.outSuccessJson();
    }

    @RequestMapping("/ill")
    public String ill(HttpServletResponse response) {
        response.setHeader("sessionstatus", "timeout");
        return "invalidSession";
    }
}
