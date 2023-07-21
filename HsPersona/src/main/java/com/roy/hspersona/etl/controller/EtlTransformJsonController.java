package com.roy.hspersona.etl.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.common.ConstantTag;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.etl.entity.EtlJsonConfig;
import com.roy.hspersona.etl.entity.EtlJsonTableConfig;
import com.roy.hspersona.etl.service.EtlJsonConfigService;
import com.roy.hspersona.etl.service.EtlJsonTableConfigService;
import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.system.service.SysDictionaryService;
import com.roy.hspersona.system.service.SysUserService;
import com.roy.hspersona.tag.entity.TagExtTypeField;
import com.roy.hspersona.tag.service.TagExtTypeFieldService;
import com.roy.hspersona.util.KeyUtil;
import com.roy.hspersona.util.SSHCommand;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
 * @date 2021/12/9
 * @desc
 */
@Controller
@RequestMapping("/etl/etlTransformJson")
public class EtlTransformJsonController extends MngBaseController {

    @Resource
    private SysDictionaryService sysDictionaryService;
    @Resource
    private EtlJsonConfigService etlJsonConfigService;
    @Resource
    private SysUserService sysUserService;
    @Resource
    private EtlJsonTableConfigService etlJsonTableConfigService;
    @Resource
    private TagExtTypeFieldService tagExtTypeFieldService;

    @RequestMapping("/to")
    private String to(){
        return "etl/initTableToJson";
    }

    @RequestMapping("/toSec")
    private String toSec(String configId, String code, int industryType, Model model){
        model.addAttribute("configId",configId);
        model.addAttribute("code",code);
        model.addAttribute("industryType",industryType);
        return "etl/initTableToJsonSecondary";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                       String etlName, HttpSession session) {
        String userId = this.getUserSession(session).getUserId();
        Map<String, Object> map = new HashMap<>();
        map.put("etlName", etlName);
        map.put("userId", userId);
        map.put("enable","1");
        Page<EtlJsonConfig> sr = etlJsonConfigService.getEtlJsonConfig(map, page, rows);
        JSONArray jsonArray = new JSONArray();
        Map<String, String> industryMap = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        for (int i = 0; i < sr.getRecords().size(); i++) {
            final EtlJsonConfig etlJsonConfig = sr.getRecords().get(i);
            int industry = etlJsonConfig.getIndustryType();
            final JSONObject json = JSON.parseObject(JSON.toJSONString((etlJsonConfig)));
            json.put("industryName", industryMap.get(Integer.toString(industry)));
            jsonArray.add(json);
        }
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/initPrimary")
    public Object initPrimary(String id) {
        if (StringUtils.isEmpty(id)) {
            return this.outJson("{\"total\":0,\"rows\":[]}");
        }
        EtlJsonConfig config = etlJsonConfigService.getEtlJsonConfigById(id);
        if (config == null) {
            return this.outJson("{\"total\":0,\"rows\":[]}");
        }
        if (StringUtils.isEmpty(config.getPrimaryTableProperties())) {
            return this.outJson("{\"total\":0,\"rows\":[]}");
        }
        String[] properties = config.getPrimaryTableProperties().split(Constant.DATA_SPLIT);
        JSONArray json = new JSONArray();
        for (int i = 0; i < properties.length; i++) {
            String[] data = properties[i].split(",");
            JSONObject object = new JSONObject();
            object.put("index", data[0]);
            object.put("code", data[1]);
            object.put("name", ConstantTag.elementMap.get(data[1]));
            json.add(object);
        }
        Map<String,Object> res = new HashMap<>();
        res.put("total",json.size());
        res.put("rows",json);
        return res;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String id) {
        if (StringUtils.isEmpty(id)) {
            return this.outFailJson("传入的ETL配置ID为空");
        }
        EtlJsonConfig etlJsonConfig = etlJsonConfigService.getEtlJsonConfigById(id);
        if(etlJsonConfig==null){
            return this.outFailJson("传入的ID参数信息为空");
        }else{
            etlJsonConfig.setEnable("0");
            etlJsonConfigService.updateEtlJsonConfig(etlJsonConfig);
            return this.outSuccessJson();
        }
    }

    @ResponseBody
    @RequestMapping("/startEtl")
    public String startEtl(String id ,@RequestParam(defaultValue = "")String runDate, HttpSession session) {
        if (StringUtils.isEmpty(id)) {
            return this.outFailJson("传入的ETL配置ID为空");
        }
        EtlJsonConfig etlJsonConfig = etlJsonConfigService.getEtlJsonConfigById(id);
        if (etlJsonConfig == null) {
            return this.outFailJson("传入的ETL配置ID错误");
        }
        SysUser sysUser = sysUserService.getUserById(etlJsonConfig.getUserId());
        String dataRootPath = ConstantParam.paramMap.get(ConstantParam.DATA_ROOT_PATH);
        runDate = StringUtils.isBlank(runDate)?"/":runDate;//不能穿空值，所以传一个路径信息
        //往计算任务传参
        String param = etlJsonConfig.getId() + " " + sysUser.getName() + " " + etlJsonConfig.getPrimaryTableFileName() + " " + runDate;
        SSHCommand.submitToCalculateEngine(session,SSHCommand.SESSIONID_ETL_JSON,SSHCommand.ENTRY_ETL_AUTO, param);
        //SSHCommand.submitToCalculateEngine(this.getSession(), SSHCommand.SESSIONID_ETL_JSON, SSHCommand.ENTRY_ETL, id + " " + id);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(String id , String etlName,@RequestParam(defaultValue = "-1")int industryType,String typeName,
                       String primaryTableFileName,int primaryTableKeyIndex,HttpSession session) {
        if (StringUtils.isEmpty(etlName)) {
            return this.outFailJson("ETL主题为空");
        }
        if (StringUtils.isEmpty(typeName)) {
            return this.outFailJson("主表数据类型名为空");
        }
        if (StringUtils.isEmpty(primaryTableFileName)) {
            return this.outFailJson("主表文件名为空");
        }
        if (primaryTableKeyIndex < 0) {
            return this.outFailJson("主表主键下标不正确");
        }
        Map<String, String> industryMap = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        if (industryMap.get(Integer.toString(industryType)) == null) {
            return this.outFailJson("行业类型不正确");
        }
        if (StringUtils.isEmpty(id)) {
            EtlJsonConfig config = new EtlJsonConfig();
            config.setId(KeyUtil.getKey());
            config.setEtlName(etlName);
            config.setIndustryType(industryType);
            config.setTypeName(typeName);
            config.setPrimaryTableFileName(primaryTableFileName);
            config.setPrimaryTableKeyIndex(primaryTableKeyIndex);
            config.setUserId(this.getUserSession(session).getUserId());
            config.setUserName(this.getUserSession(session).getUserName());
            config.setEnable("1");
            etlJsonConfigService.saveEtlJsonConfig(config);
        } else {
            EtlJsonConfig config = etlJsonConfigService.getEtlJsonConfigById(id);
            if (config == null) {
                return this.outFailJson("传入的配置ID错误！");
            }
            config.setIndustryType(industryType);
            config.setEtlName(etlName);
            config.setTypeName(typeName);
            config.setPrimaryTableFileName(primaryTableFileName);
            config.setPrimaryTableKeyIndex(primaryTableKeyIndex);
            etlJsonConfigService.updateEtlJsonConfig(config);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/deletePrimary")
    public String deletePrimary(String code ,String configId) {
        if (StringUtils.isEmpty(code)) {
            return this.outFailJson("传入的数据模型类型属性编码为空");
        }
        if (StringUtils.isEmpty(configId)) {
            return this.outFailJson("传入的ETL配置ID为空");
        }
        EtlJsonConfig config = etlJsonConfigService.getEtlJsonConfigById(configId);
        if (config == null) {
            return this.outFailJson("传入的ETL配置ID错误");
        }
        String[] properties = config.getPrimaryTableProperties().split(Constant.DATA_SPLIT);
        StringBuffer sb = new StringBuffer();
        for (String property : properties) {
            String[] data = property.split(",");
            if (!data[1].equals(code)) {
                if (sb.length() != 0) {
                    sb.append(Constant.DATA_SPLIT);
                }
                sb.append(property);
            }
        }
        config.setPrimaryTableProperties(sb.toString());
        etlJsonConfigService.updateEtlJsonConfig(config);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/savePrimary")
    public String savePrimary(String code, String configId,@RequestParam(defaultValue = "-1")int index) {
        if (StringUtils.isEmpty(code)) {
            return this.outFailJson("传入的数据模型类型属性编码为空");
        }
        if (index < 0) {
            return this.outFailJson("传入的数据列下标不正确");
        }
        if (ConstantTag.elementMap.get(code) == null) {
            return this.outFailJson("传入的数据模型类型属性编码错误");
        }
        if (StringUtils.isEmpty(configId)) {
            return this.outFailJson("传入的ETL配置ID为空");
        }
        EtlJsonConfig config = etlJsonConfigService.getEtlJsonConfigById(configId);
        if (config == null) {
            return this.outFailJson("传入的ETL配置ID错误");
        }
        if (StringUtils.isEmpty(config.getPrimaryTableProperties())) {
            config.setPrimaryTableProperties(index + "," + code);
            etlJsonConfigService.updateEtlJsonConfig(config);
        } else {
            String[] properties = config.getPrimaryTableProperties().split(Constant.DATA_SPLIT);
            for (String property : properties) {
                String[] data = property.split(",");
                if (data[1].equals(code)) {
                    return this.outFailJson("该数据模型类型属性已经存在映射");
                }
            }
            config.setPrimaryTableProperties(config.getPrimaryTableProperties() + Constant.DATA_SPLIT + index + "," + code);
            etlJsonConfigService.updateEtlJsonConfig(config);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/showEtlLogs")
    public String showEtlLogs(HttpSession session) {
        String logs = (String) session.getAttribute(SSHCommand.SESSIONID_ETL_JSON);
        if (logs != null) {
            session.setAttribute(SSHCommand.SESSIONID_ETL_JSON, null);
            return logs;
        } else {
            return this.outJson("");
        }
    }

    @ResponseBody
    @RequestMapping("/initTable")
    public Object initTable(@RequestParam(defaultValue = "@")String configId) {
        List<EtlJsonTableConfig> list = etlJsonTableConfigService.getEtlJsonTableConfigByConfigId(configId);
        Map<String,Object> res = new HashMap<>();
        res.put("total",list.size());
        res.put("rows",list);
        return res;
    }

    @ResponseBody
    @RequestMapping("/initSecondary")
    public Object initSecondary(String id) {
        if (StringUtils.isEmpty(id)) {
            return this.outJson("{\"total\":0,\"rows\":[]}");
        }
        EtlJsonTableConfig config = etlJsonTableConfigService.getEtlJsonTableConfigById(id);
        if (config == null) {
            return this.outJson("{\"total\":0,\"rows\":[]}");
        }
        if (StringUtils.isEmpty(config.getProperties())) {
            return this.outJson("{\"total\":0,\"rows\":[]}");
        }
        String[] properties = config.getProperties().split(Constant.DATA_SPLIT);
        JSONArray json = new JSONArray();
        for (int i = 0; i < properties.length; i++) {
            String[] data = properties[i].split(",");
            JSONObject object = new JSONObject();
            object.put("index", data[0]);
            object.put("code", data[1]);
            object.put("name", ConstantTag.elementMap.get(data[1]));
            json.add(object);
        }
        return json;
    }

    @ResponseBody
    @RequestMapping("/id")
    public String deleteTable(String id) {
        if (StringUtils.isEmpty(id)) {
            return this.outFailJson("传入的ETL从表配置ID为空");
        }
        etlJsonTableConfigService.deleteEtlJsonTableConfigById(id);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/saveTable")
    public String saveTable(String id, String keyName, String configId,String fileName,
                            @RequestParam(defaultValue = "-1")int foreignKeyIndex,@RequestParam(defaultValue = "-1")int mappingType) {
        if (StringUtils.isEmpty(keyName)) {
            return this.outFailJson("对应主表属性编码为空");
        }
        if (StringUtils.isEmpty(configId)) {
            return this.outFailJson("所属ETL配置ID为空");
        }
        if (StringUtils.isEmpty(fileName)) {
            return this.outFailJson("从表文件名为空");
        }
        if (foreignKeyIndex < 0) {
            return this.outFailJson("从表外键下标不正确");
        }
        if (mappingType != 0 && mappingType != 1) {
            return this.outFailJson("主从映射类型错误");
        }
        EtlJsonConfig etlJsonConfig = etlJsonConfigService.getEtlJsonConfigById(configId);
        if (etlJsonConfig == null) {
            return this.outFailJson("所属ETL配置ID错误");
        }
        Map<String, Object> map = new HashMap<>();
        map.put("belongExtTypeCode", etlJsonConfig.getTypeName());
        map.put("dataTypeElementCode", keyName);
        Page<TagExtTypeField> sr = tagExtTypeFieldService.getExtTypeFieldByBelongTypeCodeandDataCode(etlJsonConfig.getTypeName(),keyName);
        if (sr.getTotal() == 0) {
            return this.outFailJson("传入的所属ETL配置ID或对应主表属性编码错误");
        }
        TagExtTypeField tagExtTypeField = sr.getRecords().get(0);
        String typeName = tagExtTypeField.getSelfExtType().getCode();
        if (StringUtils.isEmpty(id)) {
            EtlJsonTableConfig config = new EtlJsonTableConfig();
            config.setId(KeyUtil.getKey());
            config.setKeyName(keyName);
            config.setFileName(fileName);
            config.setTypeName(typeName);
            config.setMappingType(mappingType);
            config.setForeignKeyIndex(foreignKeyIndex);
            config.setConfigId(etlJsonConfig.getId());
            etlJsonTableConfigService.saveEtlJsonTableConfig(config);
        } else {
            EtlJsonTableConfig config = etlJsonTableConfigService.getEtlJsonTableConfigById(id);
            if (config == null) {
                return this.outFailJson("传入的ETL从表配置ID错误！");
            }
            config.setKeyName(keyName);
            config.setFileName(fileName);
            config.setTypeName(typeName);
            config.setMappingType(mappingType);
            config.setForeignKeyIndex(foreignKeyIndex);
            config.setConfigId(etlJsonConfig.getId());
            etlJsonTableConfigService.updateEtlJsonTableConfig(config);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/deleteSecondary")
    public String deleteSecondary(String code, String configId) {
        if (StringUtils.isEmpty(code)) {
            return this.outFailJson("传入的数据模型类型属性编码为空");
        }
        if (StringUtils.isEmpty(configId)) {
            return this.outFailJson("传入的ETL从表配置ID为空");
        }
        EtlJsonTableConfig config = etlJsonTableConfigService.getEtlJsonTableConfigById(configId);
        if (config == null) {
            return this.outFailJson("传入的ETL从表配置ID错误");
        }
        String[] properties = config.getProperties().split(Constant.DATA_SPLIT);
        StringBuffer sb = new StringBuffer();
        for (String property : properties) {
            String[] data = property.split(",");
            if (!data[1].equals(code)) {
                if (sb.length() != 0) {
                    sb.append(Constant.DATA_SPLIT);
                }
                sb.append(property);
            }
        }
        config.setProperties(sb.toString());
        etlJsonTableConfigService.updateEtlJsonTableConfig(config);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/saveSecondary")
    public String saveSecondary(String code ,String configId,@RequestParam(defaultValue = "-1")int index) {
        if (StringUtils.isEmpty(code)) {
            return this.outFailJson("传入的数据模型类型属性编码为空");
        }
        if (index < 0) {
            return this.outFailJson("传入的数据列下标不正确");
        }
        if (ConstantTag.elementMap.get(code) == null) {
            return this.outFailJson("传入的数据模型类型属性编码错误");
        }
        if (StringUtils.isEmpty(configId)) {
            return this.outFailJson("传入的ETL从表配置ID为空");
        }
        EtlJsonTableConfig config = etlJsonTableConfigService.getEtlJsonTableConfigById(configId);
        if (config == null) {
            return this.outFailJson("传入的ETL从表配置ID错误");
        }
        if (StringUtils.isEmpty(config.getProperties())) {
            config.setProperties(index + "," + code);
            etlJsonTableConfigService.updateEtlJsonTableConfig(config);
        } else {
            String[] properties = config.getProperties().split(Constant.DATA_SPLIT);
            for (String property : properties) {
                String[] data = property.split(",");
                if (data[1].equals(code)) {
                    return this.outFailJson("该数据模型类型属性已经存在映射");
                }
            }
            config.setProperties(config.getProperties() + Constant.DATA_SPLIT + index + "," + code);
            etlJsonTableConfigService.updateEtlJsonTableConfig(config);
        }
        return this.outSuccessJson();
    }
}
