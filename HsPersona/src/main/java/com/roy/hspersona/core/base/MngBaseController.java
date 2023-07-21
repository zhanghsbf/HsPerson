package com.roy.hspersona.core.base;

import com.alibaba.fastjson.JSON;
import com.roy.hspersona.common.SessionBean;

import javax.servlet.http.HttpSession;

/**
 * @author roy
 * @date 2021/12/1
 * @desc
 */
public class MngBaseController {

    public SessionBean getUserSession(HttpSession session){
        return (SessionBean)session.getAttribute("userSession");
    }

    public void setUserSession(HttpSession session, SessionBean user){
        session.setAttribute("userSession",user);
    }

    public String outSuccessJson(){
        return "{\"success\":1}";
    }

    public String outFailJson(String info){
        return "{\"success\":0,\"info\":\"" + info + "\"}";
    }

    protected String outJson(String s) { return JSON.toJSONString(JSON.parseObject(s));}
}
