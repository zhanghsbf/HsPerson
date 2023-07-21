package com.roy.hspersona.util;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/3
 * @desc 保存所有登录的session。用于进行页面控件的权限判断。
 */
public class LoginedSessionHolder {
    private static Map<String, HttpSession> sessionMap = new HashMap<>();

    public static void sessionLogin(HttpSession session){
        sessionMap.put(session.getId(),session);
    }

    public static void sessionLogut(HttpSession session){
        sessionMap.remove(session.getId());
    }

    public static HttpSession getSessionById(String sessionId){
        return sessionMap.containsKey(sessionId)?sessionMap.get(sessionId):null;
    }
}
