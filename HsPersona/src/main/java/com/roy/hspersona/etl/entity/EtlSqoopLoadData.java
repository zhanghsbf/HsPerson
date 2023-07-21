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
public class EtlSqoopLoadData implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId("ID")
    private String id;

    @TableField("USERID")
    private String userid;
    @TableField(exist = false)
    private String username;

    @TableField("NAME")
    private String name;

    @TableField("DATASOURCEID")
    private String datasourceid;

    @TableField(exist = false)
    private String datasourcename;

    @TableField("LOADSQL")
    private String loadsql;

    @TableField("TARGETPATH")
    private String targetpath;

    @TableField("SPLITBY")
    private String splitby;

    @TableField("ETLPROCESSCORENUM")
    private String etlprocesscorenum;

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
    public String getDatasourceid() {
        return datasourceid;
    }

    public void setDatasourceid(String datasourceid) {
        this.datasourceid = datasourceid;
    }
    public String getLoadsql() {
        return loadsql;
    }

    public void setLoadsql(String loadsql) {
        this.loadsql = loadsql;
    }
    public String getTargetpath() {
        return targetpath;
    }

    public void setTargetpath(String targetpath) {
        this.targetpath = targetpath;
    }
    public String getSplitby() {
        return splitby;
    }

    public void setSplitby(String splitby) {
        this.splitby = splitby;
    }
    public String getEtlprocesscorenum() {
        return etlprocesscorenum;
    }

    public void setEtlprocesscorenum(String etlprocesscorenum) {
        this.etlprocesscorenum = etlprocesscorenum;
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

    public String getDatasourcename() {
        return datasourcename;
    }

    public void setDatasourcename(String datasourcename) {
        this.datasourcename = datasourcename;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String toString() {
        return "EtlSqoopLoadData{" +
            "id=" + id +
            ", userid=" + userid +
            ", name=" + name +
            ", datasourceid=" + datasourceid +
            ", loadsql=" + loadsql +
            ", targetpath=" + targetpath +
            ", splitby=" + splitby +
            ", etlprocesscorenum=" + etlprocesscorenum +
            ", createdate=" + createdate +
            ", startdate=" + startdate +
            ", enddate=" + enddate +
            ", logs=" + logs +
            ", enable=" + enable +
        "}";
    }
}
