package com.roy.hspersona.tag.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.ConstantTag;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.tag.entity.TagDataTypeElement;
import com.roy.hspersona.tag.service.TagDataTypeElementService;
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
 * @date 2021/12/6
 * @desc
 */
@Controller
@RequestMapping("/tag/tagElement")
public class TagElementController extends MngBaseController {

    @Resource
    private TagDataTypeElementService tagDataTypeElementService;

    @RequestMapping("/to")
    public String to() {
        return "tag/initModelElement";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(@RequestParam(defaultValue = "1") long page, @RequestParam(defaultValue = "" + Constant.PAGE_SIZE) long rows,
                       String code, String name, String ww_code,
                       @RequestParam(defaultValue = "-1") int enable) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", code);
        map.put("name", name);
        map.put("ww_code", ww_code);
        if (enable >= 0) {
            map.put("enable", enable);
        }
        Page<TagDataTypeElement> sr = tagDataTypeElementService.getTagDataTypeElement(map, page, rows);
        Map<String, Object> res = new HashMap<>();
        res.put("total", sr.getTotal());
        res.put("rows", sr.getRecords());
        return res;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String id) {
        if (StringUtils.isNotEmpty(id)) {
            TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(id);
            String code = tagDataTypeElement.getCode();
            tagDataTypeElementService.deleteTagDataTypeElementById(id);
            ConstantTag.elementMap.remove(code);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的数据类型要素数据ID为空,不能删除");
        }
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object edit(String id) {
        if (StringUtils.isNotEmpty(id)) {
            return tagDataTypeElementService.getTagDataTypeElementById(id);
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(String id, @RequestParam(defaultValue = "1") int enable, String code, String name, String memo) {
        if (StringUtils.isEmpty(name)) {
            return this.outFailJson("数据类型要素名称不能为空！");
        }
        if (StringUtils.isEmpty(code)) {
            return this.outFailJson("数据类型要素编码不能为空！");
        }
        TagDataTypeElement tdte = tagDataTypeElementService.getTagDataTypeElementByCode(code);
        if (StringUtils.isEmpty(id) && tdte != null) {
            return this.outFailJson("传入的数据类型要素编码已经存在");
        }
        if (StringUtils.isNotEmpty(id) && tdte != null && !tdte.getId().equals(id)) {
            return this.outFailJson("传入的数据类型要素编码已经存在");
        }
        if (StringUtils.isEmpty(id)) {
            TagDataTypeElement element = new TagDataTypeElement();
            element.setId(KeyUtil.getKey());
            element.setCode(code);
            element.setName(name);
            element.setMemo(memo);
            element.setEnable(enable);
            tagDataTypeElementService.saveTagDataTypeElement(element);
            ConstantTag.elementMap.put(element.getCode(), element.getName());
            return this.outSuccessJson();
        } else {
            TagDataTypeElement element = tagDataTypeElementService.getTagDataTypeElementById(id);
            if (element == null) {
                return this.outFailJson("传入的数据类型要素ID错误！");
            }
            element.setCode(code);
            element.setName(name);
            element.setMemo(memo);
            tagDataTypeElementService.updateTagDataTypeElement(element);
            ConstantTag.elementMap.put(element.getCode(), element.getName());
            return this.outSuccessJson();
        }
    }

    @ResponseBody
    @RequestMapping("/ban")
    public String ban(String id) {
        if (StringUtils.isNotEmpty(id)) {
            TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(id);
            tagDataTypeElement.setEnable((tagDataTypeElement.getEnable() + 1) % 2);
            tagDataTypeElementService.updateTagDataTypeElement(tagDataTypeElement);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的启禁数据类型要素ID为空");
        }
    }
}
