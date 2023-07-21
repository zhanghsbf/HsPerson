package com.roy.hspersona.etl.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author roy
 * @since 2021-12-06
 */
public class EtlUploadFileData implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId("ID")
    private String id;

    @TableField("USERID")
    private String userid;

    @TableField("NAME")
    private String name;

    @TableField("SOURCEPATH")
    private String sourcepath;

    @TableField("TARGETPATH")
    private String targetpath;

    @TableField("CREATEDATE")
    private LocalDateTime createdate;

    @TableField("STARTDATE")
    private LocalDateTime startdate;

    @TableField("ENDDATE")
    private LocalDateTime enddate;

    @TableField("LOGS")
    private String logs;

    @TableField("ENABLE")
    private String enable;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    public String getSourcepath() {
        return sourcepath;
    }

    public void setSourcepath(String sourcepath) {
        this.sourcepath = sourcepath;
    }
    public String getTargetpath() {
        return targetpath;
    }

    public void setTargetpath(String targetpath) {
        this.targetpath = targetpath;
    }
    public LocalDateTime getCreatedate() {
        return createdate;
    }

    public void setCreatedate(LocalDateTime createdate) {
        this.createdate = createdate;
    }
    public LocalDateTime getStartdate() {
        return startdate;
    }

    public void setStartdate(LocalDateTime startdate) {
        this.startdate = startdate;
    }
    public LocalDateTime getEnddate() {
        return enddate;
    }

    public void setEnddate(LocalDateTime enddate) {
        this.enddate = enddate;
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
        return "EtlUploadFileData{" +
            "id=" + id +
            ", userid=" + userid +
            ", name=" + name +
            ", sourcepath=" + sourcepath +
            ", targetpath=" + targetpath +
            ", createdate=" + createdate +
            ", startdate=" + startdate +
            ", enddate=" + enddate +
            ", logs=" + logs +
            ", enable=" + enable +
        "}";
    }
}
