package com.roy.hspersona.system.controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.entity.SysDictionary;
import com.roy.hspersona.system.service.SysDictionaryService;
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
@RequestMapping("/system/dictionary")
public class SysDictionaryController extends MngBaseController {

    @Resource
    private SysDictionaryService sysDictionaryService;

    @RequestMapping("/to")
    public String to(){
        return "system/initDictionary";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(@RequestParam(defaultValue = "1")long page,
                       @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                       String type,String wwtype) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("type", type);
        map.put("ww_type", wwtype);
        Page<SysDictionary> sr = sysDictionaryService.getDictionary(map, page, rows);
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",sr.getRecords());
        return res;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String dictionaryId) {
        if (StringUtils.isNotEmpty(dictionaryId)) {
            sysDictionaryService.deleteDictionaryById(dictionaryId);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的字典数据ID为空,不能删除");
        }
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object edit(String id) {
        if (StringUtils.isNotEmpty(id)) {
            return sysDictionaryService.getDictionaryById(id);
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(String id, int orders , String type, String itemName, String itemValue, String memo) {
        String dictionaryId = id;
        String name = itemName;
        if (StringUtils.isEmpty(type)) {
            return this.outFailJson("所属项类型为空！");
        }
        if (StringUtils.isEmpty(name)) {
            return this.outFailJson("所属项显示名称为空！");
        }
        if (StringUtils.isEmpty(itemValue)) {
            return this.outFailJson("所属项关键值为空！");
        }
        SysDictionary dictionaryNameType = sysDictionaryService.getDictionaryNameType(name, type);
        SysDictionary dictionaryitemValueType = sysDictionaryService.getDictionaryitemValueType(itemValue, type);
        if (StringUtils.isEmpty(dictionaryId)) {
            if (dictionaryNameType != null) {
                return this.outFailJson("项显示名称已存在！");
            }
            if (dictionaryitemValueType != null) {
                return this.outFailJson("项关键值已存在！");
            }
            SysDictionary dictionary = new SysDictionary();
            dictionary.setId(KeyUtil.getKey());
            dictionary.setItemName(name);
            dictionary.setItemValue(itemValue);
            dictionary.setMemo(memo);
            dictionary.setOrders(orders);
            dictionary.setType(type);
            sysDictionaryService.saveDictionary(dictionary);
            return this.outSuccessJson();
        } else {
            if (dictionaryNameType != null && !dictionaryNameType.getId().equals(dictionaryId)) {
                return this.outFailJson("项显示名称已存在！");
            }
            if (dictionaryitemValueType != null && !dictionaryitemValueType.getId().equals(dictionaryId)) {
                return this.outFailJson("项关键值已存在！");
            }
            SysDictionary dictionary = sysDictionaryService.getDictionaryById(dictionaryId);
            if (dictionary == null) {
                return this.outFailJson("传入的字典ID错误");
            }
            dictionary.setItemName(name);
            dictionary.setItemValue(itemValue);
            dictionary.setMemo(memo);
            dictionary.setOrders(orders);
            dictionary.setType(type);
            sysDictionaryService.updateDictionary(dictionary);
            return this.outSuccessJson();
        }
    }
}
