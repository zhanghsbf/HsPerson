package com.roy.hspersona.tag.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.*;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.system.entity.SysDictionary;
import com.roy.hspersona.system.service.SysDictionaryService;
import com.roy.hspersona.system.service.SysPermissionService;
import com.roy.hspersona.tag.entity.*;
import com.roy.hspersona.tag.service.*;
import com.roy.hspersona.util.Download;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/8
 * @desc
 */
@Controller
@RequestMapping("/tag/tagExtModel")
public class TagExtModelController extends MngBaseController {

    @Resource
    private SysPermissionService sysPermissionService;
    @Resource
    private SysDictionaryService sysDictionaryService;
    @Resource
    private TagExtTypeService tagExtTypeService;
    @Resource
    private TagExtTypeFieldService tagExtTypeFieldService;
    @Resource
    private TagDictionaryService tagDictionaryService;
    @Resource
    private TagDataTypeElementService tagDataTypeElementService;
    @Resource
    private TagExtTypeFieldExpressService tagExtTypeFieldExpressService;
    @Resource
    private TagBaseTypeService tagBaseTypeService;
    @Resource
    private TagBaseTypeFieldService tagBaseTypeFieldService;
    @Resource
    private TagBaseTypeFieldExpressService tagBaseTypeFieldExpressService;
    @Resource
    private TagVertexService tagVertexService;


    @RequestMapping("/toEdit")
    public String toEdit() {
        return "tag/initExtModelMng";
    }

    @RequestMapping("/toView")
    public String toView(){
        return "tag/viewExtModelIndustryList";
    }

    @ResponseBody
    @RequestMapping("/initList")
    public Object initList(HttpSession session) {
        // 没有任何行业则返回空
        String industryTypes = this.getUserSession(session).getIndustryTypes();
        if (StringUtils.isEmpty(industryTypes)) {
            return this.outJson("{\"total\":0,\"rows\":[]}");
        }
        String[] industryTypeArray = industryTypes.split(",");
        JSONArray array = new JSONArray();
        if (sysPermissionService.havePermisssion(this.getUserSession(session).getUserId(), "viewAllExtModelMng")) {
            List<SysDictionary> industryList = sysDictionaryService.getDictionaryByType(ConstantDict.INDUSTRY_TYPE);
            for (int i = 0; i < industryList.size(); i++) {
                SysDictionary industry = industryList.get(i);
                JSONObject json = new JSONObject();
                json.put("itemValue", industry.getItemValue());
                json.put("itemName", industry.getItemName());
                try {
                    int industryType = Integer.parseInt(industry.getItemValue());
                    int num = tagExtTypeService.getIndustryTypeNum(industryType);
                    json.put("num", num);
                } catch (Exception e) {
                }
                array.add(json);
            }
        } else {
            Map<String, String> industryTypeMap = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
            for (int i = 0; i < industryTypeArray.length; i++) {
                String name = industryTypeMap.get(industryTypeArray[i]);
                if (StringUtils.isNotEmpty(name)) {
                    JSONObject json = new JSONObject();
                    json.put("itemValue", industryTypeArray[i]);
                    json.put("itemName", name);
                    try {
                        int industryType = Integer.parseInt(industryTypeArray[i]);
                        int num = tagExtTypeService.getIndustryTypeNum(industryType);
                        json.put("num", num);
                    } catch (Exception e) {
                    }
                    array.add(json);
                }
            }
        }
        Map<String, Object> res = new HashMap<>();
        res.put("total", array.size());
        res.put("rows", array);
        return res;
    }

    @RequestMapping("/toDetail")
    public String toDetail(@RequestParam(defaultValue = "-1") int id, @RequestParam(defaultValue = "0") int type, Model model) {
        Map<String, String> map = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        String industryName = map.get("" + id);
        model.addAttribute("industryName", industryName);
        model.addAttribute("industryValue",id);
        if (type == 1) {
            return "tag/editExtModelPage";
        } else if (type == 2) {
            return "tag/initialExtModelPage";
        } else {
            return "tag/viewExtModelPage";
        }
    }

    @ResponseBody
    @RequestMapping("/clear")
    public String clear(@RequestParam(defaultValue = "-1") int industryValue) {
        Map<String, String> map = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        if (map.get(Integer.toString(industryValue)) == null) {
            return this.outFailJson("传入的行业编号错误");
        } else {
            tagExtTypeService.removeAllExtTypeByIndustryValue(industryValue);
            return this.outSuccessJson();
        }
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
        String typeCode, @RequestParam(defaultValue = "-1") int type,@RequestParam(defaultValue = "-1")int industryType,Model model) {

        Map<String, Object> map = new HashMap<>();
        map.put("code", typeCode);
        if (type > 0) {
            map.put("type", type);
        }
        map.put("industryType", industryType);
        Page<TagExtType> sr = tagExtTypeService.getTagExtType(map, page, rows);
        JSONArray jsonArray = new JSONArray();
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.DATA_TYPE);
        for (int i = 0; i < sr.getRecords().size(); i++) {
            TagExtType extType = sr.getRecords().get(i);
            JSONObject json = JSON.parseObject(JSON.toJSONString(extType));
            if (StringUtils.isNotEmpty(extType.getParentTypeId())) {
                TagExtType parentType = tagExtTypeService.getTagExtTypeById(extType.getParentTypeId());
                json.put("parentTypeCode", parentType.getCode());
            }
            if (dictMap.get(Integer.toString(extType.getType())) != null) {
                json.put("typeName", dictMap.get(Integer.toString(extType.getType())));
            }
            jsonArray.add(json);
        }
        model.addAttribute("type",type);
        Map<String ,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/initField")
    public Object initField(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                            @RequestParam(defaultValue = "@")String belongExtTypeId) {
        Page<TagExtTypeField> sr = tagExtTypeFieldService.getTagExtTypeFieldByBelongExtTypeId(belongExtTypeId, page, rows);
        List<TagExtTypeField> list = sr.getRecords();
        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < list.size(); i++) {
            TagExtTypeField field = list.get(i);
            TagExtType selfExtType = tagExtTypeService.getTagExtTypeById(field.getSelfTypeId());
            field.setSelfExtType(selfExtType);
            TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(field.getTypeElementId());
            field.setDataTypeElement(tagDataTypeElement);
            final TagExtType belongTagTxtType = tagExtTypeService.getTagExtTypeById(field.getBelongTypeId());
            field.setBelongExtType(belongTagTxtType);
            final JSONObject json = JSON.parseObject(JSON.toJSONString(field));

            String typeCode = selfExtType.getCode();
            int typeType = selfExtType.getType();
            String typeId = selfExtType.getId();
            if (StringUtils.isNotEmpty(ConstantDataType.ENUMERATION)) {
                String code = tagDataTypeElement.getCode();
                if (ConstantDataType.ENUMERATION.equals(typeCode)) {
                    String enumMemo = tagDictionaryService.getStringMemo(tagDataTypeElement.getCode());
                    if (StringUtils.isNotEmpty(enumMemo)) {
                        json.put("memo", enumMemo);
                    } else {
                        json.put("memo", "<font color=red>请先配置项类型为【<b>" + code + "</b>】标签字典");
                    }
                }
            }
            if (field.getIsArray() == 1) {
                if (typeType == 3) {
                    json.put("typeCode",
                            "Array&lt;<a href='#' onclick=\"doDetail('" + typeId + "','" + typeCode + "')\">" + typeCode + "</a>&gt;");
                } else {
                    json.put("typeCode", "Array&lt;" + typeCode + "&gt;");
                }
            } else {
                if (typeType == 3) {
                    json.put("typeCode",
                            "<a href='#' onclick=\"doDetail('" + typeId + "','" + typeCode + "')\">" + typeCode + "</a>");
                } else {
                    json.put("typeCode", typeCode);
                }
            }
            jsonArray.add(json);
        }
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(@RequestParam(defaultValue = "")String id) {
        if (StringUtils.isNotEmpty(id)) {
            try {
                tagExtTypeService.removeExtTypeById(id);
                return this.outSuccessJson();
            } catch (MyException e) {
                return this.outFailJson(e.getMessage());
            }
        } else {
            return this.outFailJson("传入的类型属性ID为空");
        }
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(String id, String parentTypeId,@RequestParam(defaultValue = "-1")int industryType,
                       String code ,String name ,@RequestParam(defaultValue = "-1") int type,
                       @RequestParam(defaultValue = "0") int isFirstShow , String memo) {
        if (StringUtils.isEmpty(code)) {
            return this.outFailJson("传入的类型编码为空");
        }
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.DATA_TYPE);
        if (dictMap.get(Integer.toString(type)) == null) {
            return this.outFailJson("传入的类类型错误");
        }
        dictMap = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        if (dictMap.get(Integer.toString(industryType)) == null) {
            return this.outFailJson("传入的行业类型错误");
        }
        TagExtType extType = tagExtTypeService.getTagExtTypeByCode(code, industryType);
        if (StringUtils.isEmpty(id) && extType != null) {
            return this.outFailJson("该类型编码已经存在");
        }
        if (StringUtils.isNotEmpty(id) && extType != null && !extType.getId().equals(id)) {
            return this.outFailJson("该类型编码已经存在");
        }

        if (StringUtils.isEmpty(id)) {
            TagExtType newExtType = new TagExtType();
            newExtType.setId(KeyUtil.getKey());
            newExtType.setParentTypeId(parentTypeId);
            newExtType.setIndustryType(industryType);
            newExtType.setCode(code);
            newExtType.setName(name);
            newExtType.setMemo(memo);
            newExtType.setType(type);
            newExtType.setIsFirstShow(isFirstShow);
            String brotherCode = tagExtTypeService.getMaxTreeCode(parentTypeId);
            int index = 0;
            String parentTreeCode = "";
            if (brotherCode != null) {
                parentTreeCode = brotherCode.substring(0, brotherCode.length() - TreeNode.CODE_LEN);
                String subCode = brotherCode.substring(brotherCode.length() - TreeNode.CODE_LEN);
                index = Integer.parseInt(subCode) + 1;
            }
            newExtType.setTreeCode(parentTreeCode + TreeNode.genTreeCode(index));
            try {
                tagExtTypeService.createTagExtType(newExtType);
            } catch (MyException e) {
                return this.outFailJson(e.getMessage());
            }
        } else {
            TagExtType newExtType = tagExtTypeService.getTagExtTypeById(id);
            if (newExtType == null) {
                return this.outFailJson("传入的数据类型ID不正确");
            }
            List<TagExtTypeField> list = tagExtTypeFieldService.getMTagExtTypeFieldByBelongExtTypeId(newExtType.getId());
            if (list.size() > 0) {
                if (newExtType.getType() != type) {
                    return this.outFailJson("该类类型下存在属性，不允许改成其他类类型");
                }
                if (newExtType.getIndustryType() != industryType) {
                    return this.outFailJson("该类类型的行业类型与原数据的行业类型不同");
                }
            }
            newExtType.setType(type);
            newExtType.setIndustryType(industryType);
            newExtType.setCode(code);
            newExtType.setMemo(memo);
            newExtType.setName(name);
            newExtType.setIsFirstShow(isFirstShow);
            try {
                tagExtTypeService.modifyTagExtType(newExtType);
            } catch (MyException e) {
                return this.outFailJson(e.getMessage());
            }
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/deleteField")
    public String deleteField(@RequestParam(defaultValue = "")String id) {
        if (StringUtils.isNotEmpty(id)) {
            tagExtTypeFieldService.removeExtTypeFieldById(id);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的类型属性ID为空");
        }
    }

    @ResponseBody
    @RequestMapping("/saveField")
    public String saveField(String id, String belongExtTypeId,String selfExtTypeId,String dataTypeElementId,
                            @RequestParam(defaultValue = "0")int typeLength,@RequestParam(defaultValue = "0")int typePrecision,
                            @RequestParam(defaultValue = "0")int isArray, @RequestParam(defaultValue = "0")int isQuery,String memo) {
        if (StringUtils.isEmpty(dataTypeElementId)) {
            return this.outFailJson("传入的属性要素ID为空");
        }
        if (StringUtils.isEmpty(belongExtTypeId)) {
            return this.outFailJson("传入的所属类型ID为空");
        }
        if (StringUtils.isEmpty(selfExtTypeId)) {
            return this.outFailJson("传入的属性数据类型ID为空");
        }
        TagExtTypeField extTypeField = tagExtTypeFieldService.getTagExtTypeFieldByElement(dataTypeElementId, belongExtTypeId);
        if (StringUtils.isEmpty(id) && extTypeField != null) {
            return this.outFailJson("传入的数据属性要素已经存在");
        }
        if (StringUtils.isNotEmpty(id) && extTypeField != null && !extTypeField.getId().equals(id)) {
            return this.outFailJson("传入的数据属性要素已经存在");
        }
        TagExtType belongExtType = tagExtTypeService.getTagExtTypeById(belongExtTypeId);
        if (belongExtType == null) {
            return this.outFailJson("该属性的所属类不存在");
        }
        TagExtType selfExtType = tagExtTypeService.getTagExtTypeById(selfExtTypeId);
        if (selfExtType == null) {
            return this.outFailJson("该属性的数据类型不存在");
        }
        // 如果节点不是顶级节点的话就需要判断祖先节点是否存在该属性
        if (!TreeNode.TOP_NODE_ID.equals(belongExtTypeId)) {
            TagExtType tdt = tagExtTypeService.getTagExtTypeById(belongExtTypeId);
            while (!TreeNode.TOP_NODE_ID.equals(tdt.getParentTypeId())) {
                extTypeField = tagExtTypeFieldService.getTagExtTypeFieldByElement(dataTypeElementId, tdt.getParentTypeId());
                if (extTypeField != null) {
                    return this.outFailJson("传入的数据属性要素在祖先类中已经存在");
                }
                tdt = tagExtTypeService.getTagExtTypeById(tdt.getParentTypeId());
            }
        }
        if (StringUtils.isEmpty(id)) {
            TagExtTypeField tagExtTypeField = new TagExtTypeField();
            tagExtTypeField.setId(KeyUtil.getKey());
            tagExtTypeField.setTypeElementId(dataTypeElementId);
            tagExtTypeField.setTypeLength(typeLength);
            tagExtTypeField.setTypePrecision(typePrecision);
            tagExtTypeField.setMemo(memo);
            tagExtTypeField.setBelongTypeId(belongExtType.getId());
            tagExtTypeField.setSelfTypeId(selfExtTypeId);
            tagExtTypeField.setIsArray(isArray);
            tagExtTypeField.setIsQuery(isQuery);
            tagExtTypeField.setIndustryType(belongExtType.getIndustryType());
            tagExtTypeFieldService.saveTagExtTypeField(tagExtTypeField);
        } else {
            TagExtTypeField tagExtTypeField = tagExtTypeFieldService.getTagExtTypeFieldById(id);
            if (tagExtTypeField == null) {
                return this.outFailJson("传入的数据类型属性ID不正确");
            }
            tagExtTypeField.setTypeElementId(dataTypeElementId);
            tagExtTypeField.setTypeLength(typeLength);
            tagExtTypeField.setTypePrecision(typePrecision);
            tagExtTypeField.setMemo(memo);
            tagExtTypeField.setSelfTypeId(selfExtTypeId);
            tagExtTypeField.setIsArray(isArray);
            tagExtTypeField.setIsQuery(isQuery);
            tagExtTypeFieldService.updateTagExtTypeField(tagExtTypeField);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/export")
    public void export(String id,HttpServletResponse response) {
        String fileName = KeyUtil.getKey() + ".jsonld";
        String cType = "text/plain";
        if (StringUtils.isEmpty(id)) {
            Download.downloadText(response, fileName, cType, "传入的行业扩展模型类型ID为空");
        }
        TagExtType extType = tagExtTypeService.getTagExtTypeById(id);
        if (extType == null) {
            Download.downloadText(response, fileName, cType, "传入的行业扩展模型类型ID错误，无法找到对应的数据");
        }
        fileName = extType.getCode() + ".jsonld";
        if (extType.getType() != 3) {
            Download.downloadText(response, fileName, cType, "需要导出的行业扩展模型类型不是复合类型");
        }
        String jsonldContext = ConstantParam.paramMap.get(ConstantParam.JSONLD_CONTEXT);
        if (jsonldContext == null) {
            Download.downloadText(response, fileName, cType, "系统未配置JSONLD的CONTEXT参数");
        }
        StringBuffer jsonSb = new StringBuffer("<script type=\"application/ld+json\">\r\n");
        jsonSb.append("{\r\n");
        jsonSb.append("\t\"@context\":\"").append(jsonldContext).append("\",\r\n");
        jsonSb.append("\t\"@type\":\"").append(extType.getCode()).append("\",\r\n");
        List<TagExtTypeField> list = tagExtTypeFieldService.getFTagExtTypeFieldByBelongExtTypeId(id);
        for (int i = 0; i < list.size(); i++) {
            TagExtTypeField field = list.get(i);
            TagExtType selfExtType = tagExtTypeService.getTagExtTypeById(field.getSelfTypeId());
            TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(field.getTypeElementId());

            if (selfExtType.getType() == 3) {
                jsonSb.append("\t\"").append(tagDataTypeElement.getCode()).append("\":");
                jsonSb.append(field.getIsArray() == 1 ? "[{\r\n" : "{\r\n");
                List<TagExtTypeField> childList = tagExtTypeFieldService.getFTagExtTypeFieldByBelongExtTypeId(selfExtType.getId());
                jsonSb.append("\t\t\"@type\":\"").append(selfExtType.getCode()).append("\",\r\n");
                for (int j = 0; j < childList.size(); j++) {
                    TagExtTypeField childField = childList.get(j);
                    TagExtType childSelfExtType = tagExtTypeService.getTagExtTypeById(field.getSelfTypeId());
                    TagDataTypeElement childTagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(field.getTypeElementId());

                    jsonSb.append("\t\t\"").append(childTagDataTypeElement.getCode()).append("\":");
                    if (childSelfExtType.getType() == 3) {
                        jsonSb.append(childField.getIsArray() == 1 ? "[{" : "{");
                        jsonSb.append("\r\n\t\t\t\"@type\":\"").append(childSelfExtType.getCode()).append("\"\r\n\t\t");
                        jsonSb.append(childField.getIsArray() == 1 ? "}]" : "}");
                    } else {
                        jsonSb.append(childField.getIsArray() == 1 ? "[]" : "");
                    }
                    jsonSb.append((j != childList.size() - 1) ? "," : "");
                    jsonSb.append("\r\n");
                }
                jsonSb.append(field.getIsArray() == 1 ? "\t}]" : "\t}");
            } else {
                jsonSb.append("\t\"").append(tagDataTypeElement.getCode()).append("\": ");
                jsonSb.append(field.getIsArray() == 1 ? "[]" : "");
            }
            jsonSb.append((i != list.size() - 1) ? "," : "");
            jsonSb.append("\r\n");
        }
        jsonSb.append("}\r\n");
        jsonSb.append("</script>");
        Download.downloadText(response, fileName, cType, jsonSb.toString());
    }

    @ResponseBody
    @RequestMapping("/initExpress")
    public Object initExpress(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                              @RequestParam(defaultValue = "@")String fieldId) {
        Map<String, Object> map = new HashMap<>();
        map.put("fieldId", fieldId);
        Page<TagExtTypeFieldExpress> sr = tagExtTypeFieldExpressService.getPageTagExtTypeFieldExpressByFieldId(fieldId,page,rows);
        JSONArray jsonArray = new JSONArray();
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.EXPRESS_TYPE);
        for (int i = 0; i < sr.getRecords().size(); i++) {
            TagExtTypeFieldExpress tagExtTypeFieldExpress = sr.getRecords().get(i);
            final JSONObject json = JSON.parseObject(JSON.toJSONString(tagExtTypeFieldExpress));
            if (dictMap.get(Integer.toString(tagExtTypeFieldExpress.getType())) != null) {
                json.put("typeName", dictMap.get(Integer.toString(tagExtTypeFieldExpress.getType())));
                jsonArray.add(json);
            }
        }
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/deleteExpress")
    public String deleteExpress(String id) {
        if (StringUtils.isEmpty(id)) {
            return this.outFailJson("传入的行业扩展模型属性表述ID为空");
        } else {
            tagExtTypeFieldExpressService.deleteTagExtTypeFieldExpressById(id);
            return this.outSuccessJson();
        }
    }

    @ResponseBody
    @RequestMapping("/saveExpress")
    public String saveExpress(String id, String fieldId, @RequestParam(defaultValue = "-1")int type,String express) {
        if (StringUtils.isEmpty(fieldId)) {
            return this.outFailJson("传入的所属数据类型属性ID不正确");
        }
        TagExtTypeField tagExtTypeField = tagExtTypeFieldService.getTagExtTypeFieldById(fieldId);
        if (tagExtTypeField == null) {
            return this.outFailJson("传入的所属数据类型属性不存在");
        }
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.EXPRESS_TYPE);
        if (!dictMap.containsKey(Integer.toString(type))) {
            return this.outFailJson("传入的表述类型不正确");
        }
        if (StringUtils.isEmpty(express)) {
            return this.outFailJson("行业扩展模型类型属性表述为空");
        }
        if (StringUtils.isEmpty(id)) {
            TagExtTypeFieldExpress tagExtTypeFieldExpress = new TagExtTypeFieldExpress();
            tagExtTypeFieldExpress.setId(KeyUtil.getKey());
            tagExtTypeFieldExpress.setExtTypeFieldId(tagExtTypeField.getId());
            tagExtTypeFieldExpress.setType(type);
            tagExtTypeFieldExpress.setExpress(express);
            tagExtTypeFieldExpress.setIndustryType(tagExtTypeField.getIndustryType());
            tagExtTypeFieldExpressService.saveTagExtTypeFieldExpress(tagExtTypeFieldExpress);
        } else {
            TagExtTypeFieldExpress tagExtTypeFieldExpress = tagExtTypeFieldExpressService.getTagExtTypeFieldExpressById(id);
            if (tagExtTypeFieldExpress == null) {
                return this.outFailJson("传入的行业扩展模型类型属性表述ID错误！");
            }
            // 所属基础模型属性不能修改，所以可以不设置
            tagExtTypeFieldExpress.setType(type);
            tagExtTypeFieldExpress.setExpress(express);
            tagExtTypeFieldExpressService.updateTagExtTypeFieldExpress(tagExtTypeFieldExpress);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/unSelectType")
    public Object unSelectType(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = "10")long rows,
                               String typeCode, @RequestParam(defaultValue = "-1")int industryType) {
        Map<String, String> industryMap = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        if (industryMap.get(Integer.toString(industryType)) == null) {
            return this.outJson("{\"total\":0,\"rows\":[]}");
        }
        // 查询返回的数据包括：类IDid，类编码code，类名称name，父类编码parentTypeCode，类类型type
        Page<Map<String,Object>> sr = tagBaseTypeService.getUnSelectType(industryType, typeCode, page, rows);
        JSONArray jsonArray = new JSONArray();
//        JSONArray json = JSONArray.fromObject(sr.getResultList(), this.getJsonConfig());
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.DATA_TYPE);
        for (int i = 0; i < sr.getRecords().size(); i++) {
            Map<String,Object> typeBean = sr.getRecords().get(i);
            JSONObject json = JSON.parseObject(JSON.toJSONString(typeBean));

            int type = (int) typeBean.get("type");
            String typeId = (String) typeBean.get("id");
            json.put("typeName", dictMap.get(Integer.toString(type)));
            if (type == 3) {
                json.put("state", "closed");
                // 查询返回的数据包括：属性IDid，属性编码code，属性名称name
                List<Map<String,Object>> fieldList = tagBaseTypeFieldService.getUnSelectField(typeId, industryType);
                for (int j = 0; j < fieldList.size(); j++) {
                    fieldList.get(j).put("typeName", "属性");
                    fieldList.get(j).put("parentTypeCode", typeBean.get("code"));
                    fieldList.get(j).put("type", -1);
                    fieldList.get(j).put("belongTypeId", typeId);
                }
                json.put("children", fieldList);
            } else {
                json.put("state", "open");
            }
            jsonArray.add(json);
        }
        // 类中包括：类IDid，类编码code，类名称name，父类编码parentTypeCode，类类型type，类类型名称typeName，节点状态state，孩子children
        // 属性中包括：属性IDid，属性编码code，属性名称name，父类（所属类）编码parentTypeCode，类类型type=-1，类类型名称typeName=属性，所属类ID=parentTypeId
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/saveImport")
    public String saveImport(String typeIds,String fieldIds,@RequestParam(defaultValue = "-1") int industryType) {
        Map<String, String> industryMap = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        if (industryMap.get(""+industryType) == null) {
            return this.outFailJson("行业类型错误");
        }
        if (StringUtils.isEmpty(fieldIds) && StringUtils.isEmpty(typeIds)) {
            return this.outFailJson("没有选择任何数据");
        }
        // 类型包括所选的基础类1，扩展类2，属性所属的复合类3，以及属性自己的类型(1,2,3)
        String[] typeIdArray = typeIds.split(",");
        String[] fieldIdArray = fieldIds.split(",");
        List<String> typeIdList = new ArrayList<String>();
        for (int i = 0; i < typeIdArray.length; i++) {
            typeIdList.add(typeIdArray[i]);
        }
        Map<String, TagExtType> extTypeMap = new HashMap<>();// key是baseType的ID,value是他对应的extType
        List<TagExtType> extTypeList = new ArrayList<>();
        List<TagExtTypeField> extFieldList = new ArrayList<>();
        List<TagExtTypeFieldExpress> extExpressList = new ArrayList<>();

        /*
         * 先对每个类处理
         */
        Map<String, Integer> treeCodeMap = new HashMap<>();
        for (int i = 0; i < typeIdList.size(); i++) {
            TagBaseType tagBaseType = tagBaseTypeService.getTagBaseTypeById(typeIdList.get(i));
            // 无法找到的类型丢弃不处理
            if (tagBaseType == null) {
                typeIdList.remove(i--);// typeIdList移除废弃的，保证与extTypeList一致
                continue;
            }
            // 如果该类已经存在数据库中，则丢弃不处理
            TagExtType extType = tagExtTypeService.getTagExtTypeByCode(tagBaseType.getCode(), industryType);
            if (extType != null) {
                extTypeMap.put(tagBaseType.getId(), extType);// 放在map中，后面处理属性时需要用得到
                typeIdList.remove(i--);// typeIdList移除丢弃的，保证与extTypeList一致
                continue;
            }
            // 如果是顶级类就不需要判断父类，直接处理
            if (StringUtils.isEmpty(tagBaseType.getParentTypeId())) {
                extType = new TagExtType();
                extType.setId(TreeNode.TOP_NODE_ID);
                extType.setCode(tagBaseType.getCode());
                extType.setIndustryType(industryType);
                extType.setIsFirstShow(tagBaseType.getIsFirstShow());
                extType.setMemo(tagBaseType.getMemo());
                extType.setName(tagBaseType.getName());
                extType.setType(tagBaseType.getType());
                extType.setTreeCode("");
                extTypeList.add(extType);
                extTypeMap.put(tagBaseType.getId(), extType);// 放在map中，后面处理属性时需要用得到
                continue;
            }
            // 如果父类不为空，且父类已经存在数据库中，则增加
            TagBaseType parentBaseType = tagBaseTypeService.getTagBaseTypeById(tagBaseType.getParentTypeId());
            TagExtType parentExtType = tagExtTypeService.getTagExtTypeByCode(parentBaseType.getCode(), industryType);
            if (parentExtType != null) {
                extType = new TagExtType();
                extType.setId(KeyUtil.getKey());
                extType.setCode(tagBaseType.getCode());
                extType.setIndustryType(industryType);
                extType.setIsFirstShow(tagBaseType.getIsFirstShow());
                extType.setMemo(tagBaseType.getMemo());
                extType.setName(tagBaseType.getName());
                extType.setParentTypeId(parentExtType.getId());
                extType.setType(tagBaseType.getType());
                int treeCodeIndex = this.genTreeCodeIndex(treeCodeMap, parentExtType.getId());
                extType.setTreeCode(parentExtType.getTreeCode() + TreeNode.genTreeCode(treeCodeIndex));
                treeCodeMap.put(parentExtType.getId(), treeCodeIndex);
                extTypeList.add(extType);
                extTypeMap.put(tagBaseType.getId(), extType);// 放在map中，后面处理属性时需要用得到
                continue;
            }
            // 如果父类数据库中没有，则在typeIdList找此记录前面的记录中是否存在，如果存在，则从extTypeList中取出数据处理
            int parentIndex = -1;
            for (int j = 0; j < i; j++) {
                if (parentBaseType.getId().equals(typeIdList.get(j))) {
                    parentIndex = j;
                    break;
                }
            }
            if (parentIndex >= 0) {
                parentExtType = extTypeList.get(parentIndex);
                extType = new TagExtType();
                extType.setId(KeyUtil.getKey());
                extType.setCode(tagBaseType.getCode());
                extType.setIndustryType(industryType);
                extType.setIsFirstShow(tagBaseType.getIsFirstShow());
                extType.setMemo(tagBaseType.getMemo());
                extType.setName(tagBaseType.getName());
                extType.setParentTypeId(parentExtType.getId());
                extType.setType(tagBaseType.getType());
                int treeCodeIndex = this.genTreeCodeIndex(treeCodeMap, parentExtType.getId());
                extType.setTreeCode(parentExtType.getTreeCode() + TreeNode.genTreeCode(treeCodeIndex));
                treeCodeMap.put(parentExtType.getId(), treeCodeIndex);
                extTypeList.add(extType);
                extTypeMap.put(tagBaseType.getId(), extType);// 放在map中，后面处理属性时需要用得到
                continue;
            }
            // 如果数据库中没有，前面也没有处理，那就看后面有没有该父类ID将要处理
            // 如果有，则将此处的ID移到列尾稍后处理
            // 如果没有，则将父节点ID和此处的ID都放到列尾稍后处理
            for (int j = i + 1; j < typeIdList.size(); j++) {
                if (parentBaseType.getId().equals(typeIdList.get(j))) {
                    parentIndex = j;
                    break;
                }
            }
            typeIdList.remove(i--);
            if (parentIndex > i) {
                typeIdList.add(tagBaseType.getId());
            } else {
                typeIdList.add(tagBaseType.getParentTypeId());
                typeIdList.add(tagBaseType.getId());
            }
        }

        /*
         * 再对每个属性处理，属性所属类，属性自己的类型都已经在前端处理，并加入到了typeIdArray中
         */
        for (int i = 0; i < fieldIdArray.length; i++) {
            // 如果属性不存在，则忽略
            TagBaseTypeField tagBaseTypeField = tagBaseTypeFieldService.getTagBaseTypeFieldById(fieldIdArray[i]);
            TagExtType selfExtType = tagExtTypeService.getTagExtTypeById(tagBaseTypeField.getSelfTypeId());
            TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(tagBaseTypeField.getTypeElementId());
            TagBaseType belongTagBaseType = tagBaseTypeService.getTagBaseTypeById(tagBaseTypeField.getBelongTypeId());
            if (tagBaseTypeField == null) {
                continue;
            }
            // 如果该属性已经存在了，则忽略
            String dataTypeElementId = tagDataTypeElement.getId();
            String belongBaseTypeId = belongTagBaseType.getId();
            String selfBaseTypeId = selfExtType.getId();
            String belongExtTypeId = extTypeMap.get(belongBaseTypeId).getId();
            TagExtTypeField tagExtTypeField = tagExtTypeFieldService.getTagExtTypeFieldByElement(dataTypeElementId, belongExtTypeId);
            if (tagExtTypeField != null) {
                continue;
            }
            // 否则将其添加到保存列表中，不需要再考虑他的所属类是否存在和他自己的类型是否存在，因为在前面类型处理里已处理
            tagExtTypeField = new TagExtTypeField();
            tagExtTypeField.setId(KeyUtil.getKey());
            tagExtTypeField.setBelongTypeId(belongBaseTypeId);
            tagExtTypeField.setTypeElementId(tagBaseTypeField.getId());
            tagExtTypeField.setIndustryType(industryType);
            tagExtTypeField.setIsArray(tagBaseTypeField.getIsArray());
            tagExtTypeField.setIsQuery(tagBaseTypeField.getIsQuery());
            tagExtTypeField.setMemo(tagBaseTypeField.getMemo());
            tagExtTypeField.setSelfTypeId(selfBaseTypeId);
            tagExtTypeField.setTypeLength(tagBaseTypeField.getTypeLength());
            tagExtTypeField.setTypePrecision(tagBaseTypeField.getTypePrecision());
            extFieldList.add(tagExtTypeField);
            List<TagBaseTypeFieldExpress> btfeList = tagBaseTypeFieldExpressService.getTagBaseTypeFieldExpressByFieldId(tagBaseTypeField.getId());
            for (int j = 0; j < btfeList.size(); j++) {
                TagBaseTypeFieldExpress btfe = btfeList.get(j);
                TagExtTypeFieldExpress etfe = new TagExtTypeFieldExpress();
                etfe.setId(KeyUtil.getKey());
                etfe.setExpress(btfe.getExpress());
                etfe.setIndustryType(industryType);
                etfe.setExtTypeFieldId(tagExtTypeField.getId());
                etfe.setType(btfe.getType());
                extExpressList.add(etfe);
            }
        }
        tagExtTypeService.saveImportData(extTypeList, extFieldList, extExpressList);
        return this.outSuccessJson();
    }

    private int genTreeCodeIndex(Map<String, Integer> treeCodeMap, String parentExtTypeId) {
        if (treeCodeMap.get(parentExtTypeId) == null) {
            String maxTreeCode = tagExtTypeService.getMaxTreeCode(parentExtTypeId);
            if (maxTreeCode == null) {
                return 1;
            } else {
                String lastTreeCode = maxTreeCode.substring(maxTreeCode.length() - TreeNode.CODE_LEN, maxTreeCode.length());
                return Integer.parseInt(lastTreeCode) + 1;
            }
        } else {
            return treeCodeMap.get(parentExtTypeId) + 1;
        }
    }

    @RequestMapping("/modelWeb")
    public String modelWeb(String action, @RequestParam(defaultValue = "-1") String industryValue, String key,
                           @RequestParam(defaultValue = "-1")int type, Model model) {
        Map<String, String> industryMap = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        String industryName = industryMap.get(industryValue);
        TagExtType tagExtType;
        List<TagExtType> tagExtTypeList = new ArrayList<>();
        List<TagExtTypeField> tagExtTypeFieldList = new ArrayList<>();
        int levels = 0 ;
        /*
         * action为查看类型详情，把该类型的属性和他所有祖辈类属性递归出来
         */
        if ("detail".equals(action)) {
            tagExtType = tagExtTypeService.getTagExtTypeByCode(key, Integer.parseInt(industryValue));
            if (tagExtType != null) {
                tagExtTypeFieldList = tagExtTypeFieldService.getFTagExtTypeFieldByBelongExtTypeId(tagExtType.getId());
                if (StringUtils.isNotEmpty(ConstantDataType.ENUMERATION)) {
                    for (TagExtTypeField field : tagExtTypeFieldList) {
                        TagExtType selfExtType = tagExtTypeService.getTagExtTypeById(field.getSelfTypeId());
                        field.setSelfExtType(selfExtType);
                        TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(field.getTypeElementId());
                        field.setDataTypeElement(tagDataTypeElement);
                        TagExtType belongBaseType = tagExtTypeService.getTagExtTypeById(field.getBelongTypeId());
                        field.setBelongExtType(belongBaseType);

                        String typeCode = selfExtType.getCode();
                        if (ConstantDataType.ENUMERATION.equals(typeCode)) {
                            String enumMemo = tagDictionaryService.getStringMemo(tagDataTypeElement.getCode());
                            field.setTmp(enumMemo);
                        }
                    }
                }
            }
            model.addAttribute("type",type);
            model.addAttribute("levels",levels);
            model.addAttribute("tagExtTypeList",tagExtTypeList);
            model.addAttribute("industryValue",industryValue);
            model.addAttribute("industryName",industryName);
            model.addAttribute("tagExtTypeFieldList",tagExtTypeFieldList);
            model.addAttribute("tagExtType",tagExtType);
            return "tag/viewExtModelDetail";
        }
        /*
         * action为列表，把系统中符合条件的数据类型列出来，复合数据类型需要按级别设置好深度，便于页面层级显示
         */
        else if ("list".equals(action)) {
            // type>0表示只取基础数据类型或扩展数据类型，否则是复合数据类型
            if (type > 0) {
                tagExtTypeList = tagExtTypeService.getTagExtTypeByType(type);
            } else {
                // 获取顶级节点
                TagExtType topExtType = tagExtTypeService.getTagExtTypeById(TreeNode.TOP_NODE_ID);
                if (topExtType != null) {
                    // 添加顶级节点到list中
                    tagExtTypeList.add(topExtType);
                    // 将顶级节点的父节点深度0加入到深度Map中
                    Map<String, Integer> levelMap = new HashMap<String, Integer>();
                    // 对列表循环并动态增长（增长的是子节点）
                    for (int i = 0; i < tagExtTypeList.size(); i++) {
                        TagExtType tdt = tagExtTypeList.get(i);
                        if (TreeNode.TOP_NODE_ID.equals(tdt.getId())) {
                            tdt.setLevel(1);// 设置深度
                            levelMap.put(TreeNode.TOP_NODE_ID, 1);
                        } else {
                            tdt.setLevel(levelMap.get(tdt.getParentTypeId()) + 1);
                            levelMap.put(tdt.getId(), levelMap.get(tdt.getParentTypeId()) + 1);
                        }
                        // 如果不是顶级节点且不是复合节点的节点则移除
                        if (tdt.getType() != 3 && !TreeNode.TOP_NODE_ID.equals(tdt.getId())) {// 写死类型3，臭味代码
                            tagExtTypeList.remove(i--);
                            continue;
                        }
                        // 设置最深的深度
                        if (levels < tdt.getLevel()) {
                            levels = tdt.getLevel();
                        }
                        List<TagExtTypeField> fieldList = tagExtTypeFieldService.getFTagExtTypeFieldByBelongExtTypeId(tdt.getId());
                        StringBuffer sb = new StringBuffer();
                        for (TagExtTypeField field : fieldList) {
                            TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(field.getTypeElementId());
                            sb.append(", ").append(tagDataTypeElement.getCode());
                        }
                        if (sb.length() > 0) {
                            tdt.setAttrString(sb.toString().substring(1));
                        }
                        // 获取自己点加入到该节点后面
                        List<TagExtType> list = tagExtTypeService.getTagExtTypeByParentId(tdt.getId());
                        if (list.size() > 0) {
                            tagExtTypeList.addAll(i + 1, list);
                            levelMap.put(tdt.getId(), tdt.getLevel());
                        }
                    }
                }
            }
            model.addAttribute("type",type);
            model.addAttribute("levels",levels);
            model.addAttribute("tagExtTypeList",tagExtTypeList);
            model.addAttribute("industryValue",industryValue);
            model.addAttribute("industryName",industryName);
            return "tag/viewExtModelList";
        }else{
            /*
             * 如果action为空表示跳到web浏览主页
             */
            tagExtType = tagExtTypeService.getTagExtTypeById(TreeNode.TOP_NODE_ID);
            tagExtTypeList = tagExtTypeService.getFirstShow(Integer.parseInt(industryValue));
            model.addAttribute("tagExtTypeList",tagExtTypeList);
            model.addAttribute("industryValue",industryValue);
            model.addAttribute("industryName",industryName);
            model.addAttribute("tagExtType",tagExtType);
            return "tag/viewExtModel";
        }
    }

    @ResponseBody
    @RequestMapping("/initFieldByType")
    public Object initFieldByType(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                                  String fieldType,String code, @RequestParam(defaultValue = "-1")int industryType) {
        if (StringUtils.isEmpty(code) || StringUtils.isEmpty(fieldType)) {
            return this.outJson("{\"total\":0,\"rows\":[]}");
        }
        String[] typeArray = fieldType.split("@");
        List<Integer> types = new ArrayList<Integer>();
        Map<String, String> industryTypeMap = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        if (industryTypeMap.get(Integer.toString(industryType)) == null) {
            return this.outJson("{\"total\":0,\"rows\":[]}");
        }
        Map<String, String> dataTypeMap = sysDictionaryService.getMapByCode(ConstantDict.DATA_TYPE);
        for (String t : typeArray) {
            if (dataTypeMap.get(t) == null) {
                return this.outJson("{\"total\":0,\"rows\":[]}");
            }
            types.add(Integer.parseInt(t));
        }
        TagExtType tagExtType = tagExtTypeService.getTagExtTypeByCode(code, industryType);

        Page<TagExtTypeField> sr = tagExtTypeFieldService.getTagExtTypeFieldByBelongExtTypeIdAndType(tagExtType.getId(), types, page, rows);
        Map<String,Object> res= new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",sr.getRecords());
        return res;
    }

    @ResponseBody
    @RequestMapping("/modelTree")
    public Object modelTree(String id ,String tagId,Model model) {
        TagVertex tagVertex = tagVertexService.getTagVertexById(tagId);
        if (tagVertex == null) {
            return new JSONArray();
        }
        List<TagExtType> tagExtTypeList = new ArrayList<>();
        List<TagExtTypeField> tagExtTypeFieldList = new ArrayList<>();

        List<TreeNode> nodeList = new ArrayList<TreeNode>();
        // 如果传入的ID是空，则显示isFirstShow=1的所有入口类型节点，否则显示某个属性对应类型下的所有属性
        if (StringUtils.isEmpty(id)) {
            tagExtTypeList = tagExtTypeService.getFirstShow(tagVertex.getIndustryType());
            for (TagExtType extType : tagExtTypeList) {
                TreeNode treeNode = new TreeNode();
                treeNode.setId(extType.getId());
                treeNode.setState("closed");
                treeNode.setText(extType.getName() + "(" + extType.getCode() + ")");
                treeNode.setTmp(extType.getId());
                nodeList.add(treeNode);
            }
        } else {
            tagExtTypeFieldList = tagExtTypeFieldService.getFTagExtTypeFieldByBelongExtTypeId(id);
            StringBuffer sb = new StringBuffer();
            for (TagExtTypeField extTypeField : tagExtTypeFieldList) {
                TreeNode treeNode = new TreeNode();
                TagDataTypeElement element = extTypeField.getDataTypeElement();
                // 如果type=3复合类类型，是节点关闭以便一步加载，id为该属性的类型ID，否则就是该属性的ID
                if (extTypeField.getSelfExtType().getType() == 3) {
                    treeNode.setState("closed");
                    treeNode.setId(extTypeField.getSelfExtType().getId());
                } else {
                    treeNode.setId(extTypeField.getId());
                }
                sb.setLength(0);
                sb.append("<font color='#C80000'>");
                sb.append(element.getName()).append("(");
                sb.append(element.getCode()).append(")");
                sb.append("</font>");
                sb.append("：").append(extTypeField.getSelfExtType().getCode());
                treeNode.setText(sb.toString());
                treeNode.setTmp(extTypeField.getId());
                nodeList.add(treeNode);
            }
        }
        model.addAttribute("tagExtTypeList",tagExtTypeList);
        model.addAttribute("tagExtTypeFieldList",tagExtTypeFieldList);
        return nodeList;
    }
}
