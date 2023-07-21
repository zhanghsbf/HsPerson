package com.roy.hspersona.tag.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 标签字典表
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class TagDictionary implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    private String id;

    /**
     * 内部排序号
     */
    private Integer orders;

    /**
     * 字典类型
     */
    private String type;

    /**
     * 字典项名称
     */
    @TableField("itemName")
    private String itemName;

    /**
     * 字典项值
     */
    @TableField("itemValue")
    private String itemValue;

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
    public Integer getOrders() {
        return orders;
    }

    public void setOrders(Integer orders) {
        this.orders = orders;
    }
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }
    public String getItemValue() {
        return itemValue;
    }

    public void setItemValue(String itemValue) {
        this.itemValue = itemValue;
    }
    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    @Override
    public String toString() {
        return "TagDictionary{" +
            "id=" + id +
            ", orders=" + orders +
            ", type=" + type +
            ", itemName=" + itemName +
            ", itemValue=" + itemValue +
            ", memo=" + memo +
        "}";
    }
}
