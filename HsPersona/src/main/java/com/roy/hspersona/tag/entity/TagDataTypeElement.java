package com.roy.hspersona.tag.entity;

import java.io.Serializable;

/**
 * <p>
 * 数据类型要素表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagDataTypeElement implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 要素编码
     */
    private String code;

    /**
     * 要素名称
     */
    private String name;

    /**
     * 是否可用：1可用，0不可用
     */
    private Integer enable;

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
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Override
    public String toString() {
        return "TagDataTypeElement{" +
            "id=" + id +
            ", code=" + code +
            ", name=" + name +
            ", enable=" + enable +
            ", memo=" + memo +
        "}";
    }
}
