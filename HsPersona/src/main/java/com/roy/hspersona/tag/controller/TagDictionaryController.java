package com.roy.hspersona.tag.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.tag.entity.TagDictionary;
import com.roy.hspersona.tag.service.TagDictionaryService;
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
@RequestMapping("/tag/tagDictionary")
public class TagDictionaryController extends MngBaseController {

    @Resource
    private TagDictionaryService tagDictionaryService;

    @RequestMapping("/to")
    public String to(){
        return "tag/initDictionary";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(@RequestParam(defaultValue = "1") long page,@RequestParam(defaultValue = ""+Constant.PAGE_SIZE) long rows,
                       String type) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("type", type);
        Page<TagDictionary> sr = tagDictionaryService.getTagDictionary(map, page, rows);
        Map<String ,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",sr.getRecords());
        return res;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String dictionaryId) {
        if (StringUtils.isNotEmpty(dictionaryId)) {
            TagDictionary tagDictionary = tagDictionaryService.getTagDictionaryById(dictionaryId);
            String type = tagDictionary.getType();
            String key = tagDictionary.getItemValue();
            String info = tagDictionaryService.deleteTagDictionaryById(dictionaryId);
            if ("".equals(info)) {
                Map<String, String> map = ConstantDict.tagDictMap.get(type);
                if (map != null) {
                    map.remove(key);
                    ConstantDict.tagDictMap.put(type, map);
                }
                return this.outSuccessJson();
            } else {
                return this.outFailJson(info);
            }
        } else {
            return this.outFailJson("传入的字典数据ID为空,不能删除");
        }
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object edit(String id) {
        if (StringUtils.isNotEmpty(id)) {
            return tagDictionaryService.getTagDictionaryById(id);
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(@RequestParam(value = "id") String dictionaryId, int orders, String type,
                       @RequestParam(value = "itemName") String name,String itemValue,String memo) {
        if (StringUtils.isEmpty(type)) {
            return this.outFailJson("所属项类型为空！");
        }
        if (StringUtils.isEmpty(name)) {
            return this.outFailJson("所属项显示名称为空！");
        }
        if (StringUtils.isEmpty(itemValue)) {
            return this.outFailJson("所属项关键值为空！");
        }
        TagDictionary dictionaryNameType = tagDictionaryService.getTagDictionaryNameType(name, type);
        TagDictionary dictionaryitemValueType = tagDictionaryService.getTagDictionaryitemValueType(itemValue, type);
        if (StringUtils.isEmpty(dictionaryId)) {
            if (dictionaryNameType != null) {
                return this.outFailJson("项显示名称已存在！");
            }
            if (dictionaryitemValueType != null) {
                return this.outFailJson("项关键值已存在！");
            }
            TagDictionary dictionary = new TagDictionary();
            dictionary.setId(KeyUtil.getKey());
            dictionary.setItemName(name);
            dictionary.setItemValue(itemValue);
            dictionary.setMemo(memo);
            dictionary.setOrders(orders);
            dictionary.setType(type);
            tagDictionaryService.saveTagDictionary(dictionary);
            Map<String, String> map = ConstantDict.tagDictMap.get(type);
            if (map == null) {
                map = new HashMap<>();
            }
            map.put(itemValue, name);
            ConstantDict.tagDictMap.put(type, map);
        } else {
            if (dictionaryNameType != null && !dictionaryNameType.getId().equals(dictionaryId)) {
                return this.outFailJson("项显示名称已存在！");
            }
            if (dictionaryitemValueType != null && !dictionaryitemValueType.getId().equals(dictionaryId)) {
                return this.outFailJson("项关键值已存在！");
            }
            TagDictionary dictionary = tagDictionaryService.getTagDictionaryById(dictionaryId);
            if (dictionary == null) {
                return this.outFailJson("传入的字典ID错误！");
            }
            dictionary.setItemName(name);
            dictionary.setItemValue(itemValue);
            dictionary.setMemo(memo);
            dictionary.setOrders(orders);
            dictionary.setType(type);
            tagDictionaryService.updateTagDictionary(dictionary);
            Map<String, String> map = ConstantDict.tagDictMap.get(type);
            if (map != null) {
                map.put(itemValue, name);
                ConstantDict.tagDictMap.put(type, map);
            }

        }
        return this.outSuccessJson();
    }
}
