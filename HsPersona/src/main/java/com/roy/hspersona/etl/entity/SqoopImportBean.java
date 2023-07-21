package com.roy.hspersona.etl.entity;

/**
 * @author roy
 * @date 2021/12/9
 * @desc
 */
public class SqoopImportBean {
    /**
     * 数据库IP类型：1mysql
     */
    private int dbType;
    /**
     * 数据库IP地址
     */
    private String dbIp;
    /**
     * 数据库端口
     */
    private String dbPort;
    /**
     * 数据库名
     */
    private String dbName;
    /**
     * 数据库用户名
     */
    private String dbUserName;
    /**
     * 数据库密码
     */
    private String dbPassword;
    /**
     * 抽取SQL
     */
    private String sql;
    /**
     * 分布式分区字段
     */
    private String splitBy;
    /**
     * 目标文件夹名字，用于区分多次导入
     */
    private String folderName;
    /**
     * 导入时登陆的系统用户名
     */
    private String userName;
    /**
     * SQOOP默认根路径，由系统参数dataRootPath设置
     */
    private String sqoopDataFolder;
    /**
     * 处理核心数，由系统参数etlProcessCoreNum设置
     */
    private int processCoreNum;

    public int getDbType() {
        return dbType;
    }

    public void setDbType(int dbType) {
        this.dbType = dbType;
    }

    public String getDbIp() {
        return dbIp;
    }

    public void setDbIp(String dbIp) {
        this.dbIp = dbIp;
    }

    public String getDbPort() {
        return dbPort;
    }

    public void setDbPort(String dbPort) {
        this.dbPort = dbPort;
    }

    public String getDbUserName() {
        return dbUserName;
    }

    public void setDbUserName(String dbUserName) {
        this.dbUserName = dbUserName;
    }

    public String getDbPassword() {
        return dbPassword;
    }

    public void setDbPassword(String dbPassword) {
        this.dbPassword = dbPassword;
    }

    public String getSql() {
        return sql;
    }

    public void setSql(String sql) {
        this.sql = sql;
    }

    public String getSplitBy() {
        return splitBy;
    }

    public void setSplitBy(String splitBy) {
        this.splitBy = splitBy;
    }

    public String getFolderName() {
        return folderName;
    }

    public void setFolderName(String folderName) {
        this.folderName = folderName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName;
    }

    public String getSqoopDataFolder() {
        return sqoopDataFolder;
    }

    public void setSqoopDataFolder(String sqoopDataFolder) {
        this.sqoopDataFolder = sqoopDataFolder;
    }

    public int getProcessCoreNum() {
        return processCoreNum;
    }

    public void setProcessCoreNum(int processCoreNum) {
        this.processCoreNum = processCoreNum;
    }

    public String getUrl() {
        if (dbType == 1) {
            // mysql
            return "jdbc:mysql://" + dbIp + ":" + dbPort + "/" + dbName + "?characterEncoding=UTF-8";
        } else {
            return "";
        }
    }

    public String getDir() {
        if (folderName.startsWith("/")) {
            folderName = folderName.substring(1);
        }
        if (folderName.endsWith("/")) {
            folderName = folderName.substring(0, folderName.length() - 1);
        }
        if (sqoopDataFolder.endsWith("/")) {
            return sqoopDataFolder + userName + "/" + folderName;
        } else {
            return sqoopDataFolder + "/" + userName + "/" + folderName;
        }
    }
}
