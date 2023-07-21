package com.roy.hspersona.system.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.entity.SysParam;
import com.roy.hspersona.system.service.SysParamService;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/5
 * @desc
 */
@Controller
@RequestMapping("/system/param")
public class SysParamController extends MngBaseController {

    @Resource
    private SysParamService sysParamService;

    @RequestMapping("/to")
    public String to(){
        return "system/initParam";
    }


    @ResponseBody
    @RequestMapping("/init")
    public Object init(@RequestParam(defaultValue = "1") long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                       String code, String value, String memo) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", code);
        map.put("memo", memo);
        map.put("value", value);
        Page<SysParam> sr = sysParamService.getParam(map, page, rows);

        Map<String ,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",sr.getRecords());
        return res;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String id) {
        if (StringUtils.isNotEmpty(id)) {
            SysParam sysParam = sysParamService.getSysParamById(id);
            if(null == sysParam){
                return this.outFailJson("参数不存在");
            }
            String code = sysParam.getCode();
            String info = sysParamService.deleteSysParamById(id);
            if ("".equals(info)) {
                ConstantParam.paramMap.remove(code);
                return this.outSuccessJson();
            } else {
                return this.outFailJson(info);
            }
        } else {
            return this.outFailJson("传入的参数数据ID为空,不能删除");
        }
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object edit(String id) {
        if (StringUtils.isNotEmpty(id)) {
            return sysParamService.getSysParamById(id);
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(String id, @RequestParam(defaultValue = "1") int enable,String code, String value ,String memo) {
        if (StringUtils.isEmpty(code)) {
            return this.outFailJson("参数编码不能为空！");
        }
        if (StringUtils.isEmpty(value)) {
            return this.outFailJson("参数值不能为空！");
        }
        SysParam param = sysParamService.getParamByCode(code);
        if (StringUtils.isEmpty(id)) {
            if (param != null) {
                this.outFailJson("传入的参数编码已经存在！");
                return null;
            }
            param = new SysParam();
            param.setId(KeyUtil.getKey());
            param.setCode(code);
            param.setValue(value);
            param.setMemo(memo);
            param.setEnable(enable);
            sysParamService.saveSysParam(param);
            ConstantParam.paramMap.put(param.getCode(), param.getValue());
        } else {
            if (param != null && !param.getId().equals(id)) {
                return null;
            }
            param = sysParamService.getSysParamById(id);
            if (param == null) {
                return this.outFailJson("传入的参数ID错误！");
            }
            param.setCode(code);
            param.setValue(value);
            param.setMemo(memo);
            param.setEnable(enable);
            sysParamService.updateSysParam(param);
            ConstantParam.paramMap.put(param.getCode(), param.getValue());
        }
        ConstantParam.paramMap.put(code, value);
        return this.outSuccessJson();
    }
}
