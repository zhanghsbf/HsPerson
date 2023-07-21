package com.roy.hspersona.system.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 权限点表
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public class SysPermission implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 所属菜单ID
     */
    @TableField("menuId")
    private String menuId;

    /**
     * 树结构代码
     */
    @TableField("treeCode")
    private String treeCode;

    /**
     * 权限点代码
     */
    private String code;

    /**
     * 说明描述
     */
    private String memo;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getMenuId() {
        return menuId;
    }

    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }
    public String getTreeCode() {
        return treeCode;
    }

    public void setTreeCode(String treeCode) {
        this.treeCode = treeCode;
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

    @Override
    public String toString() {
        return "SysPermission{" +
            "id=" + id +
            ", menuId=" + menuId +
            ", treeCode=" + treeCode +
            ", code=" + code +
            ", memo=" + memo +
        "}";
    }
}
