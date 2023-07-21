package com.roy.hspersona.tag.entity;

import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 账户表
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public class TagAccount implements Serializable {

    public static final int ACCOUNT_TYPE_SYS_USER = 1;
    public static final int ACCOUNT_TYPE_TAG_ACC  = 0;

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 所属后端用户
     */
    @TableField("userId")
    private String userId;

    /**
     * 账号
     */
    private String account;

    /**
     * 密码
     */
    private String password;

    /**
     * 用户真实姓名
     */
    @TableField("realName")
    private String realName;

    /**
     * 创建时间
     */
    @TableField("createDate")
    private LocalDateTime createDate;

    /**
     * 用户状态 0 不可用 1 可用
     */
    private Integer status;

    /**
     * 联系电话
     */
    private String phone;

    /**
     * 所属单位
     */
    private String memo;

    @TableField("TYPE")
    private Integer type;

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
    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
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
    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }
    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "TagAccount{" +
            "id=" + id +
            ", userId=" + userId +
            ", account=" + account +
            ", password=" + password +
            ", realName=" + realName +
            ", createDate=" + createDate +
            ", status=" + status +
            ", phone=" + phone +
            ", memo=" + memo +
            ", type=" + type +
        "}";
    }
}
