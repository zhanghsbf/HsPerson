package com.roy.hspersona.system.entity;

import com.baomidou.mybatisplus.annotation.TableField;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 系统用户表
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public class SysUser implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 登陆用户名
     */
    private String name;

    /**
     * 密码
     */
    private String password;

    /**
     * 用户名称
     */
    @TableField("realName")
    private String realName;

    /**
     * 创建日期
     */
    @TableField("createDate")
    private LocalDateTime createDate;

    /**
     * 是否可用：0不可用，1可用
     */
    private Integer enable;

    /**
     * 所属机构
     */
    @TableField("orgId")
    private String orgId;

    @TableField(exist = false)
    private String orgName;

    @TableField("industryTypes")
    private String industrytypes;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }
    public LocalDateTime getCreateDate() {
        return createDate;
    }

    public void setCreateDate(LocalDateTime createDate) {
        this.createDate = createDate;
    }
    public Integer getEnable() {
        return enable;
    }

    public void setEnable(Integer enable) {
        this.enable = enable;
    }
    public String getOrgId() {
        return orgId;
    }

    public void setOrgId(String orgId) {
        this.orgId = orgId;
    }
    public String getIndustrytypes() {
        return industrytypes;
    }

    public void setIndustrytypes(String industrytypes) {
        this.industrytypes = industrytypes;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    @Override
    public String toString() {
        return "SysUser{" +
            "id=" + id +
            ", name=" + name +
            ", password=" + password +
            ", realName=" + realName +
            ", createDate=" + createDate +
            ", enable=" + enable +
            ", orgId=" + orgId +
            ", industrytypes=" + industrytypes +
        "}";
    }
}
