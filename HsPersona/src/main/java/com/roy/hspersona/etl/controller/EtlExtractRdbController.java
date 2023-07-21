package com.roy.hspersona.etl.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.common.HdfsFile;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.etl.entity.EtlDatabaseSource;
import com.roy.hspersona.etl.entity.EtlSqoopLoadData;
import com.roy.hspersona.etl.entity.SqoopImportBean;
import com.roy.hspersona.etl.service.EtlDatabaseSourceService;
import com.roy.hspersona.etl.service.EtlSqoopLoadDataService;
import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.system.service.SysUserService;
import com.roy.hspersona.util.KeyUtil;
import com.roy.hspersona.util.SSHCommand;
import com.roy.hspersona.util.WebHdfsUtil;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/9
 * @desc
 */
@Controller
@RequestMapping("/etl/etlExtractRdb")
public class EtlExtractRdbController extends MngBaseController {

    @Resource
    private EtlSqoopLoadDataService etlSqoopLoadDataService;
    @Resource
    private EtlDatabaseSourceService etlDatabaseSourceService;
    @Resource
    private SysUserService sysUserService;

    private Logger logger = LoggerFactory.getLogger(EtlExtractRdbController.class);

    @RequestMapping("/to")
    public String to(Model model){
        String dataRootPath = ConstantParam.paramMap.get(ConstantParam.DATA_ROOT_PATH);
        model.addAttribute("dataRootPath",dataRootPath);
        return "etl/mngHdfs";
    }

    @RequestMapping("/toIFRDB")
    public String toIFRDB(){
        return "etl/initImportFromRDB";
    }
    @ResponseBody
    @RequestMapping("/queryHdfs")
    public String queryHdfs(String path, HttpSession session) {
        String dataRootPath = ConstantParam.paramMap.get(ConstantParam.DATA_ROOT_PATH);
        if (StringUtils.isEmpty(dataRootPath)) {
            return this.outJson("{\"total\":0,\"rows\":[],\"dataRootPath\":\""+dataRootPath+"\"}");
        }
        dataRootPath = WebHdfsUtil.getPath(dataRootPath) + "/" + this.getUserSession(session).getUserName();
        String hdfsPath = WebHdfsUtil.getPath(path);
        if(StringUtils.isBlank(hdfsPath)){
            hdfsPath = dataRootPath;
        }
        try {
            List<HdfsFile> list = WebHdfsUtil.getFileList(hdfsPath);
            if (StringUtils.isEmpty(path) && list.size() == 0) {
                WebHdfsUtil.createFolder("", dataRootPath);
            }
            JSONArray json = JSON.parseArray(JSON.toJSONString(list));
            return this.outJson("{\"total\":" + list.size() + ",\"rows\":" + json + ",\"dataRootPath\":\""+dataRootPath+"\"}");
        } catch (MyException e) {
            return this.outJson("{\"total\":0,\"rows\":[],\"dataRootPath\":\""+dataRootPath+"\"}");
        }
    }

    @ResponseBody
    @RequestMapping("/addHdfs")
    public String addHdfs(String path ,String name,HttpSession session) {
        String dataRootPath = ConstantParam.paramMap.get(ConstantParam.DATA_ROOT_PATH);
        if (StringUtils.isEmpty(dataRootPath)) {
            return this.outFailJson("请联系系统管理员设置系统hdfs数据存储根目录参数（" + ConstantParam.DATA_ROOT_PATH + "）");
        }
        dataRootPath = WebHdfsUtil.getPath(dataRootPath) + "/" + this.getUserSession(session).getUserName();
        String hdfsPath = WebHdfsUtil.getPath(path);
        if(StringUtils.isBlank(hdfsPath)){
            hdfsPath = dataRootPath;
        }
        if (StringUtils.isEmpty(name)) {
            return this.outFailJson("新增的文件夹名称不能为空");
        }
        if (WebHdfsUtil.isExist( WebHdfsUtil.getPath(hdfsPath)+"/"+name)) {
            return this.outFailJson("新增的文件夹名称已经存在");
        }
        try {
            WebHdfsUtil.createFolder(hdfsPath, name);
            return this.outSuccessJson();
        } catch (MyException e) {
            return this.outFailJson(e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("/deleteHdfs")
    public String deleteHdfs(String path ,String name,HttpSession session) {
        String dataRootPath = ConstantParam.paramMap.get(ConstantParam.DATA_ROOT_PATH);
        if (StringUtils.isEmpty(dataRootPath)) {
            return this.outFailJson("请联系系统管理员设置系统hdfs数据存储根目录参数（" + ConstantParam.DATA_ROOT_PATH + "）");
        }
        dataRootPath = WebHdfsUtil.getPath(dataRootPath) + "/" + this.getUserSession(session).getUserName();
        String hdfsPpath = WebHdfsUtil.getPath(path);
        if (StringUtils.isEmpty(hdfsPpath)) {
            return this.outFailJson("被删除文件夹名称不能为空");
        }
        try {
            WebHdfsUtil.deleteFiles( hdfsPpath + "/"+name);
            return this.outSuccessJson();
        } catch (MyException e) {
            return this.outFailJson(e.getMessage());
        }
    }

    @ResponseBody
    @RequestMapping("/editHdfs")
    public String editHdfs(HttpSession session,String path, String oldName, String newName) {
        String dataRootPath = ConstantParam.paramMap.get(ConstantParam.DATA_ROOT_PATH);
        if (StringUtils.isEmpty(dataRootPath)) {
            return this.outFailJson("请联系系统管理员设置系统hdfs数据存储根目录参数（" + ConstantParam.DATA_ROOT_PATH + "）");
        }
        dataRootPath = WebHdfsUtil.getPath(dataRootPath) + "/" + this.getUserSession(session).getUserName();
        String hdfsPath = WebHdfsUtil.getPath(path);
        if (StringUtils.isEmpty(oldName)) {
            return this.outFailJson("原文件(夹)名称不能为空");
        }
        if (StringUtils.isEmpty(newName)) {
            return this.outFailJson("新文件(夹)名称不能为空");
        }
        if (oldName.equals(newName)) {
            return this.outFailJson("新文件(夹)与原文件夹名称相同");
        }

        if (WebHdfsUtil.isExist( hdfsPath + WebHdfsUtil.getPath(newName))) {
            return this.outFailJson("修改后的文件(夹)名称已经存在");
        }
        try {
            WebHdfsUtil.renameFiles( hdfsPath, oldName, newName);
            return this.outSuccessJson();
        } catch (MyException e) {
            return this.outFailJson(e.getMessage());
        }
    }

    @ResponseBody()
    @RequestMapping("/upload")
    public String upload(HttpSession session, String fileName ,String filePath, @RequestParam("upfile") MultipartFile upfile) {
        String dataRootPath = ConstantParam.paramMap.get(ConstantParam.DATA_ROOT_PATH);
        if (StringUtils.isEmpty(dataRootPath)) {
            return this.outFailJson("请联系系统管理员设置系统hdfs数据存储根目录参数（" + ConstantParam.DATA_ROOT_PATH + "）");
        }
//        String path = WebHdfsUtil.getPath(dataRootPath) + "/" + this.getUserSession(session).getUserName();
        String path = WebHdfsUtil.getPath(filePath) + WebHdfsUtil.getPath(fileName);
        String localTmpPath = ConstantParam.paramMap.get(ConstantParam.LOCAL_TMP_PATH);
        File dest = new File(localTmpPath,upfile.getOriginalFilename());
        try {
            upfile.transferTo(dest);
            WebHdfsUtil.uploadFile(path, dest);
            dest.delete();
            return this.outSuccessJson();
        } catch (Exception e) {
            e.printStackTrace();
            return this.outFailJson(e.getMessage());
        }
    }

    @ResponseBody()
    @RequestMapping("/init")
    public Object init(@RequestParam(defaultValue = "1")long page , @RequestParam(defaultValue = ""+Constant.PAGE_SIZE) long rows,
                       String name, String startTime, String endTime, HttpSession session) throws Exception{
        if (StringUtils.isNotEmpty(startTime)) {
            startTime = startTime + " 00:00:00";
        }
        if (StringUtils.isNotEmpty(endTime)) {
            endTime = endTime + " 23:59:59";
        }
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("startTime", startTime);
        map.put("endTime", endTime);
        map.put("name", name);
        map.put("enable", "1");
        map.put("userId", this.getUserSession(session).getUserId());
        Page<EtlSqoopLoadData> sr = etlSqoopLoadDataService.getEtlSqoopLoadData(map, page, rows);
        List<EtlSqoopLoadData> list = sr.getRecords();
        for(EtlSqoopLoadData etlSqoopLoadData : list){
            if(StringUtils.isNotEmpty(etlSqoopLoadData.getDatasourceid())){
                EtlDatabaseSource dbSource = etlDatabaseSourceService.getEtlDatabaseSourceById(etlSqoopLoadData.getDatasourceid());
                if(dbSource!=null){
                    etlSqoopLoadData.setDatasourcename(dbSource.getAlias());
                }
            }
            if(StringUtils.isNotEmpty(etlSqoopLoadData.getUserid())){
                SysUser user = sysUserService.getUserById(etlSqoopLoadData.getUserid());
                if (user != null) {
                    etlSqoopLoadData.setUsername(user.getRealName());
                }
            }
        }
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",list);
        return res;
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(String id, String name,String datasourceid, String loadsql, String splitby, String targetpath,
                       String etlprocesscorenum,HttpSession session) throws Exception{
        String sql = loadsql;
        String folderName = targetpath;
        if(StringUtils.isEmpty(name)){
            return this.outFailJson("抽取主题不能为空");
        }
        if (StringUtils.isEmpty(sql)) {
            return this.outFailJson("抽取SQL不能为空");
        }
        if (StringUtils.isEmpty(splitby)) {
            return this.outFailJson("分布式分区字段不能为空");
        }
        if (StringUtils.isEmpty(folderName)) {
            return this.outFailJson("存储文件夹名不能为空");
        }
        if (StringUtils.isEmpty(etlprocesscorenum)) {
            return this.outFailJson("线程数不能为空");
        }
        sql = sql.trim();
        if(sql.endsWith(";") ||sql.endsWith(".")||sql.endsWith(",")||sql.endsWith("。")||sql.endsWith("，")||sql.endsWith("；")){
            sql = sql.substring(0, sql.length()-1);
        }
        if(!sql.contains("where")){//存在子查询就不对了
            sql = sql +" where 1=1 ";
        }
        if (StringUtils.isEmpty(id)) {
            EtlSqoopLoadData etlSqoopLoadData = new EtlSqoopLoadData();
            etlSqoopLoadData.setId(KeyUtil.getKey());
            etlSqoopLoadData.setName(name);
            etlSqoopLoadData.setLoadsql(sql);
            etlSqoopLoadData.setCreatedate(LocalDateTime.now());
            etlSqoopLoadData.setUserid(this.getUserSession(session).getUserId());
            etlSqoopLoadData.setTargetpath(folderName);
            etlSqoopLoadData.setSplitby(splitby);
            etlSqoopLoadData.setEnable("1");
            etlSqoopLoadData.setDatasourceid(datasourceid);
            etlSqoopLoadData.setEtlprocesscorenum(etlprocesscorenum);
            etlSqoopLoadDataService.saveEtlSqoopLoadData(etlSqoopLoadData);
        } else {
            EtlSqoopLoadData etlSqoopLoadData =etlSqoopLoadDataService.getEtlSqoopLoadDataById(id);
            if (etlSqoopLoadData == null) {
                return this.outFailJson("传入的抽取配置ID不正确");
            }
            etlSqoopLoadData.setName(name);
            etlSqoopLoadData.setLoadsql(sql);
            etlSqoopLoadData.setTargetpath(folderName);
            etlSqoopLoadData.setSplitby(splitby);
            etlSqoopLoadData.setDatasourceid(datasourceid);
            etlSqoopLoadData.setEtlprocesscorenum(etlprocesscorenum);
            etlSqoopLoadDataService.updateEtlSqoopLoadData(etlSqoopLoadData);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object edit(String id) throws Exception{
        if(StringUtils.isEmpty(id)){
            return this.outFailJson("传入的ID为空");
        }
        EtlSqoopLoadData etlSqoopLoadData = etlSqoopLoadDataService.getEtlSqoopLoadDataById(id);
        if(etlSqoopLoadData==null){
            return this.outFailJson("传入的ID错误");
        }
        return etlSqoopLoadData;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = "9999") long rows,
                         String id) throws Exception{
        if(StringUtils.isEmpty(id)){
            return this.outFailJson("传入的ID为空");
        }
        EtlSqoopLoadData etlSqoopLoadData = etlSqoopLoadDataService.getEtlSqoopLoadDataById(id);
        if(etlSqoopLoadData==null){
            return this.outFailJson("传入的ID错误");
        }
        etlSqoopLoadData.setEnable("0");
        etlSqoopLoadDataService.updateEtlSqoopLoadData(etlSqoopLoadData);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/sqoopRdb")
    public String sqoopRdb(String id, String runDate, HttpSession session) {
        logger.debug("【抽取开始】");
        if(StringUtils.isEmpty(id)){
            return this.outFailJson("id为空");
        }
        String dataRootPath = ConstantParam.paramMap.get(ConstantParam.DATA_ROOT_PATH);
        if (dataRootPath == null) {
            return this.outFailJson("请联系系统管理员设置系统hdfs数据存储根目录参数（" + ConstantParam.DATA_ROOT_PATH + "）");
        }
        String etlProcessCoreNum = ConstantParam.paramMap.get(ConstantParam.ETL_PROCESS_CORE_NUM);
        if (etlProcessCoreNum == null) {
            return this.outFailJson("请联系系统管理员设置ETL时数据抽取使用的集群核心数参数（" + ConstantParam.ETL_PROCESS_CORE_NUM + "）");
        }
        EtlSqoopLoadData etlSqoopLoadData = etlSqoopLoadDataService.getEtlSqoopLoadDataById(id);
        if(etlSqoopLoadData==null){
            return this.outFailJson("id错误");
        }
        String sql = etlSqoopLoadData.getLoadsql().trim();
        if(sql.endsWith(";") ||sql.endsWith(".")||sql.endsWith(",")||sql.endsWith("。")||sql.endsWith("，")||sql.endsWith("；")){
            sql = sql.substring(0, sql.length()-1);
        }
        if(!sql.contains("where")){//存在子查询就不对了
            sql = sql +" where 1=1 ";
        }
        String target = etlSqoopLoadData.getTargetpath();
        if(StringUtils.isNotBlank(runDate)){
            target = target.replace(Constant.RUNDATE, runDate);
            sql = sql.replace(Constant.RUNDATE, runDate);
        }
        EtlDatabaseSource dbSource = etlDatabaseSourceService.getEtlDatabaseSourceById(etlSqoopLoadData.getDatasourceid());
        SqoopImportBean bean = new SqoopImportBean();
        bean.setDbIp(dbSource.getIp());
        bean.setDbName(dbSource.getDbName());
        bean.setDbPassword(dbSource.getPassword());
        bean.setDbPort(Integer.toString(dbSource.getPort()));
        bean.setSql(sql);
        bean.setSplitBy(etlSqoopLoadData.getSplitby());
        bean.setDbType(dbSource.getDbType());
        bean.setDbUserName(dbSource.getUserName());
        bean.setFolderName(target);
        bean.setSqoopDataFolder(dataRootPath);
        bean.setProcessCoreNum(Integer.parseInt(etlProcessCoreNum));
        bean.setUserName(this.getUserSession(session).getUserName());
        SSHCommand.submitToSqoopFromSQL(session, bean);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/showSqoopRdbLogs")
    public String showSqoopRdbLogs(HttpSession session) {
        String logs = (String) session.getAttribute(SSHCommand.SESSIONID_IMPORT_FROM_RDB);
        if (logs != null) {
            session.setAttribute(SSHCommand.SESSIONID_IMPORT_FROM_RDB, null);
            return logs;
        } else {
            return "";
        }
    }
}
