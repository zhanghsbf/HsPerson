package com.roy.hspersona.system.entity;

import java.io.Serializable;

/**
 * <p>
 * 参数表
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public class SysParam implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 参数编码
     */
    private String code;

    /**
     * 备注说明
     */
    private String memo;

    /**
     * 参数值
     */
    private String value;

    /**
     * 是否可用 0不可用，1可用
     */
    private Integer enable;

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
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }
    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }

    @Override
    public String toString() {
        return "SysParam{" +
            "id=" + id +
            ", code=" + code +
            ", memo=" + memo +
            ", value=" + value +
            ", enable=" + enable +
        "}";
    }
}
