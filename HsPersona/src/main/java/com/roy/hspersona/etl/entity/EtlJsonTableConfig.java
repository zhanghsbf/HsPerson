package com.roy.hspersona.etl.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * ETL从表数据配置表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class EtlJsonTableConfig implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 所属配置ID
     */
    @TableField("configId")
    private String configId;

    /**
     * 该表对应数据Key
     */
    @TableField("keyName")
    private String keyName;

    /**
     * 该表所在的文件名
     */
    @TableField("fileName")
    private String fileName;

    /**
     * 表数据类型名，如Family
     */
    @TableField("typeName")
    private String typeName;

    /**
     * 需要解析列属性规则如（0,name），多个用split隔开
     */
    private String properties;

    /**
     * 外键所在数据下标
     */
    @TableField("foreignKeyIndex")
    private Integer foreignKeyIndex;

    /**
     * 映射类型：0是一对一，1是一对多
     */
    @TableField("mappingType")
    private Integer mappingType;

    /**
     * 备注
     */
    private String memo;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getConfigId() {
        return configId;
    }

    public void setConfigId(String configId) {
        this.configId = configId;
    }
    public String getKeyName() {
        return keyName;
    }

    public void setKeyName(String keyName) {
        this.keyName = keyName;
    }
    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }
    public String getProperties() {
        return properties;
    }

    public void setProperties(String properties) {
        this.properties = properties;
    }
    public Integer getForeignKeyIndex() {
        return foreignKeyIndex;
    }

    public void setForeignKeyIndex(Integer foreignKeyIndex) {
        this.foreignKeyIndex = foreignKeyIndex;
    }
    public Integer getMappingType() {
        return mappingType;
    }

    public void setMappingType(Integer mappingType) {
        this.mappingType = mappingType;
    }
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Override
    public String toString() {
        return "EtlJsonTableConfig{" +
            "id=" + id +
            ", configId=" + configId +
            ", keyName=" + keyName +
            ", fileName=" + fileName +
            ", typeName=" + typeName +
            ", properties=" + properties +
            ", foreignKeyIndex=" + foreignKeyIndex +
            ", mappingType=" + mappingType +
            ", memo=" + memo +
        "}";
    }
}
