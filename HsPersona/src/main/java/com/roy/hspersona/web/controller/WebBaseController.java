package com.roy.hspersona.web.controller;

import com.roy.hspersona.common.SessionBean;
import com.roy.hspersona.core.base.MngBaseController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.http.HttpSession;

/**
 * @author roy
 * @date 2021/12/15
 * @desc
 */
public class WebBaseController extends MngBaseController {

    protected static Logger log = LoggerFactory.getLogger(WebBaseController.class);

    /**
     * 从session中获取登录用户信息
     */
    public SessionBean getAccountSession(HttpSession session) {
        return (SessionBean) session.getAttribute("accountSession");
    }

    /**
     * 设置session中登录的用户信息
     */
    public void setAccountSession(HttpSession session , SessionBean sessionBean) {
        session.setAttribute("accountSession", sessionBean);
    }
}
