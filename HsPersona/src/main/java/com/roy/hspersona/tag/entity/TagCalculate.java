package com.roy.hspersona.tag.entity;

import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 用户计算配置表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagCalculate implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 所属用户ID
     */
    @TableField("userId")
    private String userId;

    /**
     * 用户名
     */
    @TableField("userName")
    private String userName;

    /**
     * 计算主题
     */
    private String name;

    /**
     * 数据源路径
     */
    @TableField("dataPath")
    private String dataPath;

    /**
     * 生成时间
     */
    @TableField("createDate")
    private LocalDateTime createDate;

    /**
     * 执行开始时间
     */
    @TableField("startDate")
    private LocalDateTime startDate;

    /**
     * 执行结束时间
     */
    @TableField("endDate")
    private LocalDateTime endDate;

    /**
     * 计算日志
     */
    private String logs;

    @TableField("ENABLE")
    private String enable;

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
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getDataPath() {
        return dataPath;
    }

    public void setDataPath(String dataPath) {
        this.dataPath = dataPath;
    }
    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }
    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }
    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }
    public String getLogs() {
        return logs;
    }

    public void setLogs(String logs) {
        this.logs = logs;
    }
    public String getEnable() {
        return enable;
    }

    public void setEnable(String enable) {
        this.enable = enable;
    }

    @Override
    public String toString() {
        return "TagCalculate{" +
            "id=" + id +
            ", userId=" + userId +
            ", userName=" + userName +
            ", name=" + name +
            ", dataPath=" + dataPath +
            ", createDate=" + createDate +
            ", startDate=" + startDate +
            ", endDate=" + endDate +
            ", logs=" + logs +
            ", enable=" + enable +
        "}";
    }
}
