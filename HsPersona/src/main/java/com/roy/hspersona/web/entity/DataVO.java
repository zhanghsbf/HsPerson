package com.roy.hspersona.web.entity;

import java.io.Serializable;

/**
 * @author roy
 * @date 2021/12/15
 * @desc
 */
public class DataVO implements Serializable {
    private static final long serialVersionUID = 8265551207636920904L;

    /**
     * 主键ID
     */
    private String id;
    /**
     * 匹配分数
     */
    private double score;
    /**
     * 具体数据内容
     */
    private String source;
    /**
     * 数据版本号
     */
    private double version;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public double getVersion() {
        return version;
    }

    public void setVersion(double version) {
        this.version = version;
    }
}
