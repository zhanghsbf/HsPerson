package com.roy.hspersona.common;

import java.util.Map;

/**
 * @author roy
 * @date 2021/11/30
 * @desc
 */
public class Constant {
    /**
     * 默认每页记录条数
     */
    public static final long PAGE_SIZE = 15;
    /**
     * 项目名称
     */
    public static String projectName = "";
    /**
     * 系统发布版本
     */
    public static String version = "1.0";

    /**
     * ftp登录用户名
     */
    public static String FTP_USERNAME = "";

    /**
     * ftp登录密码
     */
    public static String FTP_PASSWORD = "";

    /**
     * ftp登录端口
     */
    public static int FTP_PORT = 0;

    /**
     * ftp所在IP地址
     */
    public static String FTP_IP = "";

    /**
     * ftp依赖的下载服务对应的端口
     */
    public static int FTP_HTTP_PORT = 0;

    /**
     * ftp依赖的下载服务对应的别名
     */
    public static String FTP_HTTP_ALIAS = "";
    /**
     * 数据分割符
     */
    public final static String DATA_SPLIT = "\02";
    /**
     * 配置任务时的时间参数模版
     */
    public final static String RUNDATE ="${runDate}";

    public static void setProjectName(String projectName) {
        Constant.projectName = projectName;
    }

    public static void setVersion(String version) {
        Constant.version = version;
    }
}
