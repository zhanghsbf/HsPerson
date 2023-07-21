package com.roy.hspersona.etl.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * ETL主表配置表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class EtlJsonConfig implements Serializable {

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
     * 用户账号
     */
    @TableField("userName")
    private String userName;

    /**
     * ETL主题
     */
    @TableField("etlName")
    private String etlName;

    /**
     * 主表数据类型名，如Person
     */
    @TableField("typeName")
    private String typeName;

    /**
     * 主表文件名
     */
    @TableField("primaryTableFileName")
    private String primaryTableFileName;

    /**
     * 主表主键下标
     */
    @TableField("primaryTableKeyIndex")
    private Integer primaryTableKeyIndex;

    /**
     * 主表需要解析列属性规则如（0,name），多个用split隔开
     */
    @TableField("primaryTableProperties")
    private String primaryTableProperties;

    /**
     * ETL日志
     */
    private String logs;

    /**
     * 所属的行业ID，值见字典表type=industryType
     */
    @TableField("industryType")
    private Integer industryType;

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
    public String getEtlName() {
        return etlName;
    }

    public void setEtlName(String etlName) {
        this.etlName = etlName;
    }
    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
    public String getPrimaryTableFileName() {
        return primaryTableFileName;
    }

    public void setPrimaryTableFileName(String primaryTableFileName) {
        this.primaryTableFileName = primaryTableFileName;
    }
    public Integer getPrimaryTableKeyIndex() {
        return primaryTableKeyIndex;
    }

    public void setPrimaryTableKeyIndex(Integer primaryTableKeyIndex) {
        this.primaryTableKeyIndex = primaryTableKeyIndex;
    }
    public String getPrimaryTableProperties() {
        return primaryTableProperties;
    }

    public void setPrimaryTableProperties(String primaryTableProperties) {
        this.primaryTableProperties = primaryTableProperties;
    }
    public String getLogs() {
        return logs;
    }

    public void setLogs(String logs) {
        this.logs = logs;
    }
    public Integer getIndustryType() {
        return industryType;
    }

    public void setIndustryType(Integer industryType) {
        this.industryType = industryType;
    }
    public String getEnable() {
        return enable;
    }

    public void setEnable(String enable) {
        this.enable = enable;
    }

    @Override
    public String toString() {
        return "EtlJsonConfig{" +
            "id=" + id +
            ", userId=" + userId +
            ", userName=" + userName +
            ", etlName=" + etlName +
            ", typeName=" + typeName +
            ", primaryTableFileName=" + primaryTableFileName +
            ", primaryTableKeyIndex=" + primaryTableKeyIndex +
            ", primaryTableProperties=" + primaryTableProperties +
            ", logs=" + logs +
            ", industryType=" + industryType +
            ", enable=" + enable +
        "}";
    }
}
