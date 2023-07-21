package com.roy.hspersona.etl.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.etl.entity.EtlDatabaseSource;
import com.roy.hspersona.etl.service.EtlDatabaseSourceService;
import com.roy.hspersona.system.service.SysDictionaryService;
import com.roy.hspersona.util.KeyUtil;
import com.roy.hspersona.util.NumUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/8
 * @desc
 */
@Controller
@RequestMapping("/etl/databaseSource")
public class EtlDatabaseSourceController extends MngBaseController {
    @Resource
    private EtlDatabaseSourceService etlDatabaseSourceService;
    @Resource
    private SysDictionaryService sysDictionaryService;

    @RequestMapping("/to")
    public String to(){
        return "etl/initDatabaseSource";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                       String alias, HttpSession session) {
        Page<EtlDatabaseSource> sr = etlDatabaseSourceService.getEtlDatabaseSource(this.getUserSession(session).getUserId(), alias, page, rows);
        List<EtlDatabaseSource> list = sr.getRecords();
        JSONArray jsonArray = new JSONArray();
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.DB_TYPE);
        for (int i = 0; i < list.size(); i++) {
            final EtlDatabaseSource etlDatabaseSource = list.get(i);
            final JSONObject json = JSON.parseObject(JSON.toJSONString(etlDatabaseSource));
            json.put("dbTypeName", dictMap.get(Integer.toString(list.get(i).getDbType())));
            jsonArray.add(json);
        }
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String dictionaryId) {
        if (StringUtils.isNotEmpty(dictionaryId)) {
            etlDatabaseSourceService.deleteEtlDatabaseSourceById(dictionaryId);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的ETL数据源数据ID为空,不能删除");
        }
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(String id, String alias, @RequestParam(defaultValue = "0") int dbType,String ip, int port,
                       String dbName,String userName ,String password,HttpSession session) {
        if (StringUtils.isEmpty(alias)) {
            return this.outFailJson("数据源别名不能为空！");
        }
        if (dbType <= 0) {
            return this.outFailJson("数据库类型不能为空！");
        }
        if (StringUtils.isEmpty(ip)) {
            return this.outFailJson("IP地址不能为空！");
        }
        String[] p = ip.split("\\.");
        if (p.length != 4) {
            return this.outFailJson("IP地址有误！");
        }
        for (int i = 0; i < p.length; i++) {
            if (StringUtils.isEmpty(p[0]) || !NumUtil.isInt(p[0], 0, 255)) {
                return this.outFailJson("IP地址有误！");
            }
        }
        if (StringUtils.isEmpty(dbName)) {
            return  this.outFailJson("数据库名不能为空！");
        }
        if (port <= 0) {
            return this.outFailJson("端口不正确！");
        }
        if (StringUtils.isEmpty(userName)) {
            return this.outFailJson("用户名不能为空！");
        }
        if (StringUtils.isEmpty(password)) {
            return this.outFailJson("密码不能为空！");
        }
        if (StringUtils.isEmpty(id)) {
            EtlDatabaseSource dbSource = new EtlDatabaseSource();
            dbSource.setId(KeyUtil.getKey());
            dbSource.setAlias(alias);
            dbSource.setDbType(dbType);
            dbSource.setIp(ip);
            dbSource.setPassword(password);
            dbSource.setPort(port);
            dbSource.setDbName(dbName);
            dbSource.setUserId(this.getUserSession(session).getUserId());
            dbSource.setUserName(userName);
            etlDatabaseSourceService.saveEtlDatabaseSource(dbSource);
        } else {
            EtlDatabaseSource dbSource = etlDatabaseSourceService.getEtlDatabaseSourceById(id);
            if (dbSource == null) {
                return this.outFailJson("传入的ETL数据源ID错误！");
            }
            dbSource.setAlias(alias);
            dbSource.setDbType(dbType);
            dbSource.setIp(ip);
            dbSource.setDbName(dbName);
            dbSource.setPassword(password);
            dbSource.setPort(port);
            dbSource.setUserName(userName);
            etlDatabaseSourceService.updateEtlDatabaseSource(dbSource);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/list")
    public Object list(HttpSession session) {
        String userId = this.getUserSession(session).getUserId();
        return etlDatabaseSourceService.getEtlDatabaseSourceByUserId(userId);
    }
}
