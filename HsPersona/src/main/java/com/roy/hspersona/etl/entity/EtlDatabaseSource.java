package com.roy.hspersona.etl.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * ETL数据源配置表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class EtlDatabaseSource implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 所属用户
     */
    @TableField("userId")
    private String userId;

    /**
     * 数据源别名
     */
    private String alias;

    /**
     * 数据库类型，见系统字典type=dbType
     */
    @TableField("dbType")
    private Integer dbType;

    /**
     * IPv4地址
     */
    private String ip;

    /**
     * 端口
     */
    private Integer port;

    /**
     * 数据库名
     */
    @TableField("dbName")
    private String dbName;

    /**
     * 用户名
     */
    @TableField("userName")
    private String userName;

    /**
     * 密码
     */
    private String password;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }
    public String getAlias() {
        return alias;
    }

    public void setAlias(String alias) {
        this.alias = alias;
    }
    public Integer getDbType() {
        return dbType;
    }

    public void setDbType(Integer dbType) {
        this.dbType = dbType;
    }
    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }
    public Integer getPort() {
        return port;
    }

    public void setPort(Integer port) {
        this.port = port;
    }
    public String getDbName() {
        return dbName;
    }

    public void setDbName(String dbName) {
        this.dbName = dbName;
    }
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String toString() {
        return "EtlDatabaseSource{" +
            "id=" + id +
            ", userId=" + userId +
            ", alias=" + alias +
            ", dbType=" + dbType +
            ", ip=" + ip +
            ", port=" + port +
            ", dbName=" + dbName +
            ", userName=" + userName +
            ", password=" + password +
        "}";
    }
}
