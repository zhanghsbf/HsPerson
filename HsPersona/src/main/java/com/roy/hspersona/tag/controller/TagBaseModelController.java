package com.roy.hspersona.tag.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.*;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.system.service.SysDictionaryService;
import com.roy.hspersona.tag.entity.TagBaseType;
import com.roy.hspersona.tag.entity.TagBaseTypeField;
import com.roy.hspersona.tag.entity.TagBaseTypeFieldExpress;
import com.roy.hspersona.tag.entity.TagDataTypeElement;
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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/6
 * @desc
 */
@Controller
@RequestMapping("/tag/tagBaseModel")
public class TagBaseModelController extends MngBaseController {

    private int levels = 0;
    @Resource
    private TagBaseTypeService tagBaseTypeService;
    @Resource
    private TagBaseTypeFieldService tagBaseTypeFieldService;

    @Resource
    private TagDataTypeElementService tagDataTypeElementService;

    @Resource
    private SysDictionaryService sysDictionaryService;

    @Resource
    private TagDictionaryService tagDictionaryService;

    @Resource
    private TagBaseTypeFieldExpressService tagBaseTypeFieldExpressService;

    @RequestMapping("/to")
    public String to(){
        return "tag/initBaseModel";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(@RequestParam(defaultValue = "1") long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE) long rows,
                       String typeCode, String typeName, @RequestParam(defaultValue = "-1") int type) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", typeCode);
        map.put("name", typeName);
        if (type > 0) {
            map.put("type", type);
        }
        Page<TagBaseType> sr = tagBaseTypeService.getTagBaseType(map, page, rows);
        final JSONArray jsonArray = new JSONArray();
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.DATA_TYPE);
        for (int i = 0; i < sr.getRecords().size(); i++) {
            TagBaseType tagBaseType = sr.getRecords().get(i);;
            final JSONObject json = JSON.parseObject(JSON.toJSONString(tagBaseType));
            if (StringUtils.isNotEmpty(tagBaseType.getParentTypeId())) {
                TagBaseType parentType = tagBaseTypeService.getTagBaseTypeById(tagBaseType.getParentTypeId());
                json.put("parentTypeCode", parentType.getCode());
            }
            if (dictMap.get(Integer.toString(tagBaseType.getType())) != null) {
                json.put("typeName", dictMap.get(Integer.toString(tagBaseType.getType())));
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
    public String delete(String id) {
        if (StringUtils.isNotEmpty(id)) {
            try {
                tagBaseTypeService.removeBaseTypeById(id);
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
    public String save(String id, String parentTypeId,String code, String name ,
                       @RequestParam(defaultValue = "-1") int type,
                       @RequestParam(defaultValue = "0") int isFirstShow, String memo) {
        if (StringUtils.isEmpty(code)) {
            return this.outFailJson("传入的类型编码为空");
        }
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.DATA_TYPE);
        if (dictMap.get(Integer.toString(type)) == null) {
            return this.outFailJson("传入的类类型错误");
        }
        TagBaseType baseType = tagBaseTypeService.getTagBaseTypeByCode(code);
        if (StringUtils.isEmpty(id) && baseType != null) {
            return this.outFailJson("该类型编码已经存在");
        }
        if (StringUtils.isNotEmpty(id) && baseType != null && !baseType.getId().equals(id)) {
            return this.outFailJson("该类型编码已经存在");
        }

        if (StringUtils.isEmpty(id)) {
            TagBaseType tagBaseType = new TagBaseType();
            tagBaseType.setId(KeyUtil.getKey());
            tagBaseType.setParentTypeId(parentTypeId);
            tagBaseType.setCode(code);
            tagBaseType.setName(name);
            tagBaseType.setMemo(memo);
            tagBaseType.setType(type);
            tagBaseType.setIsFirstShow(isFirstShow);
            String brotherCode = tagBaseTypeService.getMaxTreeCode(parentTypeId);
            int index = 0;
            String parentTreeCode = "";
            if (brotherCode != null) {
                parentTreeCode = brotherCode.substring(0, brotherCode.length() - TreeNode.CODE_LEN);
                String subCode = brotherCode.substring(brotherCode.length() - TreeNode.CODE_LEN);
                index = Integer.parseInt(subCode) + 1;
            }
            tagBaseType.setTreeCode(parentTreeCode + TreeNode.genTreeCode(index));
            try {
                tagBaseTypeService.createTagBaseType(tagBaseType);
            } catch (MyException e) {
                return this.outFailJson(e.getMessage());
            }
        } else {
            TagBaseType tagBaseType = tagBaseTypeService.getTagBaseTypeById(id);
            if (tagBaseType == null) {
                return this.outFailJson("传入的数据类型ID不正确");
            }
            List<TagBaseTypeField> list = tagBaseTypeFieldService.getMTagBaseTypeFieldByBelongBaseTypeId(tagBaseType.getId());
            if (list.size() > 0) {
                if (tagBaseType.getType() != type) {
                    return this.outFailJson("该类类型下存在属性，不允许改成其他类类型");
                }
            }
            tagBaseType.setType(type);
            tagBaseType.setCode(code);
            tagBaseType.setMemo(memo);
            tagBaseType.setName(name);
            tagBaseType.setIsFirstShow(isFirstShow);
            try {
                tagBaseTypeService.modifyTagBaseType(tagBaseType);
            } catch (MyException e) {
                return this.outFailJson(e.getMessage());
            }
        }
        return this.outSuccessJson();
    }

    /**
     * 进入模型构建时，数据类型属性的分页显示
     */
    @ResponseBody
    @RequestMapping("/initField")
    public Object initField(@RequestParam(defaultValue = "1") long page, @RequestParam(defaultValue = "" + Constant.PAGE_SIZE) long rows,
                            @RequestParam(defaultValue = "@") String belongBaseTypeId) {
        Page<TagBaseTypeField> sr = tagBaseTypeFieldService.getTagBaseTypeFieldByBelongBaseTypeId(belongBaseTypeId, null, page, rows);
        List<TagBaseTypeField> list = sr.getRecords();
        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < list.size(); i++) {
            TagBaseTypeField tagBaseTypeField = list.get(i);
            final JSONObject json = JSON.parseObject(JSON.toJSONString(tagBaseTypeField));

            final TagBaseType selfBaseType = tagBaseTypeService.getTagBaseTypeById(tagBaseTypeField.getSelfTypeId());
            String typeCode = selfBaseType.getCode();
            int typeType = selfBaseType.getType();
            String typeId = selfBaseType.getId();
            json.put("selfBaseTypeCode",typeCode);

            final TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(tagBaseTypeField.getTypeElementId());
            json.put("dataTypeElementCode",tagDataTypeElement.getCode());
            json.put("dataTypeElementName",tagDataTypeElement.getName());
            json.put("dataTypeElementId",tagDataTypeElement.getId());
            String code = tagDataTypeElement.getCode();
            if (ConstantDataType.ENUMERATION.equals(typeCode)) {
                String enumMemo = tagDictionaryService.getStringMemo(code);
                if (StringUtils.isNotEmpty(enumMemo)) {
                    json.put("memo", enumMemo);
                } else {
                    json.put("memo", "<font color=red>请先配置项类型为【<b>" + code + "</b>】标签字典");
                }
            }
            if (tagBaseTypeField.getIsArray() == 1) {
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
        Map<String, Object> res = new HashMap<>();
        res.put("total", sr.getTotal());
        res.put("rows", jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/deleteField")
    public String deleteField(String id) {
        if (StringUtils.isNotEmpty(id)) {
            tagBaseTypeFieldService.removeBaseTypeFieldById(id);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的类型属性ID为空");
        }
    }

    /**
     * 保存属性类型数据
     */
    @ResponseBody
    @RequestMapping("/saveField")
    public String saveField(String id, String belongBaseTypeId, String selfBaseTypeId,String dataTypeElementId,
                            int typeLength, int typePrecision, int isArray, int isQuery,String memo) {
        if (StringUtils.isEmpty(dataTypeElementId)) {
            return this.outFailJson("传入的属性要素ID为空");
        }
        if (StringUtils.isEmpty(belongBaseTypeId)) {
            return this.outFailJson("传入的所属类型ID为空");
        }
        if (StringUtils.isEmpty(selfBaseTypeId)) {
            return this.outFailJson("传入的属性数据类型ID为空");
        }
        TagBaseTypeField baseTypeField = tagBaseTypeFieldService.getTagBaseTypeFieldByElement(dataTypeElementId, belongBaseTypeId);
        if (StringUtils.isEmpty(id) && baseTypeField != null) {
            return this.outFailJson("传入的数据属性要素已经存在");
        }
        if (StringUtils.isNotEmpty(id) && baseTypeField != null && !baseTypeField.getId().equals(id)) {
            return this.outFailJson("传入的数据属性要素已经存在");
        }
        TagBaseType belongBaseType = tagBaseTypeService.getTagBaseTypeById(belongBaseTypeId);
        if (belongBaseType == null) {
            return this.outFailJson("该属性的所属类不存在");
        }
        TagBaseType selfBaseType = tagBaseTypeService.getTagBaseTypeById(selfBaseTypeId);
        if (selfBaseType == null) {
            return this.outFailJson("该属性的数据类型不存在");
        }
        // 如果节点不是顶级节点的话就需要判断祖先节点是否存在该属性
        if (!TreeNode.TOP_NODE_ID.equals(belongBaseTypeId)) {
            TagBaseType tdt = tagBaseTypeService.getTagBaseTypeById(belongBaseTypeId);
            while (!TreeNode.TOP_NODE_ID.equals(tdt.getParentTypeId())) {
                baseTypeField = tagBaseTypeFieldService.getTagBaseTypeFieldByElement(dataTypeElementId, tdt.getParentTypeId());
                if (baseTypeField != null) {
                    return this.outFailJson("传入的数据属性要素在祖先类中已经存在");
                }
                tdt = tagBaseTypeService.getTagBaseTypeById(tdt.getParentTypeId());
            }
        }
        if (StringUtils.isEmpty(id)) {
            TagBaseTypeField tagBaseTypeField = new TagBaseTypeField();
            tagBaseTypeField.setId(KeyUtil.getKey());
            TagDataTypeElement dataTypeElement = new TagDataTypeElement();
            dataTypeElement.setId(dataTypeElementId);
            tagBaseTypeField.setTypeElementId(dataTypeElementId);
            tagBaseTypeField.setTypeLength(typeLength);
            tagBaseTypeField.setTypePrecision(typePrecision);
            tagBaseTypeField.setMemo(memo);
            tagBaseTypeField.setBelongTypeId(belongBaseTypeId);
            tagBaseTypeField.setSelfTypeId(selfBaseTypeId);
            tagBaseTypeField.setIsArray(isArray);
            tagBaseTypeField.setIsQuery(isQuery);
            tagBaseTypeFieldService.saveTagBaseTypeField(tagBaseTypeField,dataTypeElement,belongBaseType,selfBaseType);
        } else {
            TagBaseTypeField tagBaseTypeField = tagBaseTypeFieldService.getTagBaseTypeFieldById(id);
            if (tagBaseTypeField == null) {
                this.outFailJson("传入的数据类型属性ID不正确");
                return null;
            }
            TagDataTypeElement dataTypeElement = new TagDataTypeElement();
            dataTypeElement.setId(dataTypeElementId);
            tagBaseTypeField.setTypeElementId(dataTypeElementId);
            tagBaseTypeField.setTypeLength(typeLength);
            tagBaseTypeField.setTypePrecision(typePrecision);
            tagBaseTypeField.setMemo(memo);
            tagBaseTypeField.setSelfTypeId(selfBaseTypeId);
            tagBaseTypeField.setIsArray(isArray);
            tagBaseTypeField.setIsQuery(isQuery);
            tagBaseTypeFieldService.updateTagBaseTypeField(tagBaseTypeField,dataTypeElement,selfBaseType);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/initExpress")
    public Object initExpress(@RequestParam(defaultValue = "1") long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE) long rows,
                              @RequestParam(defaultValue = "@")String fieldId) {
        Page<TagBaseTypeFieldExpress> sr = tagBaseTypeFieldExpressService.getTagBaseTypeFieldExpress(fieldId, page, rows);
        JSONArray jsonArray = new JSONArray();
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.EXPRESS_TYPE);
        for (int i = 0; i < sr.getRecords().size(); i++) {
            TagBaseTypeFieldExpress tagBaseTypeFieldExpress = sr.getRecords().get(i);
            final JSONObject json = JSON.parseObject(JSON.toJSONString(tagBaseTypeFieldExpress));
            if (dictMap.get(Integer.toString(tagBaseTypeFieldExpress.getType())) != null) {
                json.put("typeName", dictMap.get(Integer.toString(tagBaseTypeFieldExpress.getType())));
            }
            jsonArray.add(json);
        }
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/saveExpress")
    public String saveExpress(String id, String fieldId, @RequestParam(defaultValue = "-1")int type,String express) {
        if (StringUtils.isEmpty(fieldId)) {
            return this.outFailJson("传入的所属数据类型属性ID不正确");
        }
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.EXPRESS_TYPE);
        if (!dictMap.containsKey(Integer.toString(type))) {
            return this.outFailJson("传入的表述类型不正确");
        }
        if (StringUtils.isEmpty(express)) {
            return this.outFailJson("基础模型类型属性表述为空");
        }
        if (StringUtils.isEmpty(id)) {
            TagBaseTypeFieldExpress tagBaseTypeFieldExpress = new TagBaseTypeFieldExpress();
            tagBaseTypeFieldExpress.setId(KeyUtil.getKey());
            TagBaseTypeField tagBaseTypeField = new TagBaseTypeField();
            tagBaseTypeField.setId(fieldId);
            tagBaseTypeFieldExpress.setBaseTypeFieldId(fieldId);
            tagBaseTypeFieldExpress.setType(type);
            tagBaseTypeFieldExpress.setExpress(express);
            tagBaseTypeFieldExpressService.saveTagBaseTypeFieldExpress(tagBaseTypeFieldExpress,tagBaseTypeField);
        } else {
            TagBaseTypeFieldExpress tagBaseTypeFieldExpress = tagBaseTypeFieldExpressService.getTagBaseTypeFieldExpressById(id);
            if (tagBaseTypeFieldExpress == null) {
                return this.outFailJson("传入的基础模型类型属性表述ID错误！");
            }
            // 所属基础模型属性不能修改，所以可以不设置
            tagBaseTypeFieldExpress.setType(type);
            tagBaseTypeFieldExpress.setExpress(express);
            tagBaseTypeFieldExpressService.updateTagBaseTypeFieldExpress(tagBaseTypeFieldExpress);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/deleteExpress")
    public String deleteExpress(String id) {
        if (StringUtils.isEmpty(id)) {
            return this.outFailJson("传入的基础模型属性表述ID为空");
        } else {
            tagBaseTypeFieldExpressService.deleteTagBaseTypeFieldExpressById(id);
            return this.outSuccessJson();
        }
    }
    @RequestMapping("/export")
    public void export(String id,HttpServletResponse response) {
        String fileName = KeyUtil.getKey() + ".jsonld";
        String cType = "text/plain";
        if (StringUtils.isEmpty(id)) {
            Download.downloadText(response, fileName, cType, "传入的基础模型类型ID为空");
        }
        TagBaseType tagBaseType = tagBaseTypeService.getTagBaseTypeById(id);
        if (tagBaseType == null) {
            Download.downloadText(response, fileName, cType, "传入的基础模型类型ID错误，无法找到对应的数据");
        }
        fileName = tagBaseType.getCode() + ".jsonld";
        if (tagBaseType.getType() != 3) {
            Download.downloadText(response, fileName, cType, "需要导出的基础模型类型不是复合类型");
        }
        String jsonldContext = ConstantParam.paramMap.get(ConstantParam.JSONLD_CONTEXT);
        if (jsonldContext == null) {
            Download.downloadText(response, fileName, cType, "系统未配置JSONLD的CONTEXT参数");
        }
        StringBuffer jsonSb = new StringBuffer("<script type=\"application/ld+json\">\r\n");
        jsonSb.append("{\r\n");
        jsonSb.append("\t\"@context\":\"").append(jsonldContext).append("\",\r\n");
        jsonSb.append("\t\"@type\":\"").append(tagBaseType.getCode()).append("\",\r\n");
        List<TagBaseTypeField> list = tagBaseTypeFieldService.getFTagBaseTypeFieldByBelongBaseTypeId(id);
        for (int i = 0; i < list.size(); i++) {
            TagBaseTypeField field = list.get(i);
            TagBaseType selfTagBaseType = tagBaseTypeService.getTagBaseTypeById(field.getSelfTypeId());
            TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(field.getTypeElementId());

            if (selfTagBaseType.getType() == 3) {
                jsonSb.append("\t\"").append(tagDataTypeElement.getCode()).append("\":");
                jsonSb.append(field.getIsArray() == 1 ? "[{\r\n" : "{\r\n");
                List<TagBaseTypeField> childList = tagBaseTypeFieldService.getFTagBaseTypeFieldByBelongBaseTypeId(field.getSelfTypeId());
                jsonSb.append("\t\t\"@type\":\"").append(selfTagBaseType.getCode()).append("\",\r\n");
                for (int j = 0; j < childList.size(); j++) {
                    TagBaseTypeField childField = childList.get(j);
                    TagBaseType childFieldselfTagBaseType = tagBaseTypeService.getTagBaseTypeById(childField.getSelfTypeId());
                    TagDataTypeElement childFieldtagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(childField.getTypeElementId());

                    jsonSb.append("\t\t\"").append(childFieldtagDataTypeElement.getCode()).append("\":");
                    if (childFieldselfTagBaseType.getType() == 3) {
                        jsonSb.append(childField.getIsArray() == 1 ? "[{" : "{");
                        jsonSb.append("\r\n\t\t\t\"@type\":\"").append(childFieldselfTagBaseType.getCode()).append("\"\r\n\t\t");
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


    @RequestMapping("/modelWeb")
    public String modelWeb(String action, String key, @RequestParam(defaultValue = "-1")int type, Model model) {
        TagBaseType tagBaseType;
        List<TagBaseTypeField> baseTypeFieldList;
        List<TagBaseType> baseTypeList = new ArrayList<>();
        /*
         * action为查看类型详情，把该类型的属性和他所有祖辈类属性递归出来
         */
        if ("detail".equals(action)) {
            JSONArray jsonArray = new JSONArray();
            tagBaseType = tagBaseTypeService.getTagBaseTypeByCode(key);
            if (tagBaseType != null) {
                baseTypeFieldList = tagBaseTypeFieldService.getFTagBaseTypeFieldByBelongBaseTypeId(tagBaseType.getId());
                if (StringUtils.isNotEmpty(ConstantDataType.ENUMERATION)) {
                    for (TagBaseTypeField field : baseTypeFieldList) {
                        field.setTmp("");
                        TagBaseType baseType = tagBaseTypeService.getTagBaseTypeById(field.getSelfTypeId());
                        final TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(field.getTypeElementId());
                        String typeCode = baseType.getCode();
                        if (ConstantDataType.ENUMERATION.equals(typeCode)) {
                            String enumMemo = tagDictionaryService.getStringMemo(tagDataTypeElement.getCode());
                            field.setTmp(enumMemo);
                        }
                        JSONObject jsonObject = JSON.parseObject(JSON.toJSONString(field));
                        jsonObject.put("dataTypeElement",tagDataTypeElement);
                        jsonObject.put("selfBaseType",baseType);
                        TagBaseType belongBaseType = tagBaseTypeService.getTagBaseTypeById(field.getBelongTypeId());
                        jsonObject.put("belongBaseType",belongBaseType);
                        jsonArray.add(jsonObject);
                    }
                }
            }
            model.addAttribute("tagBaseType",tagBaseType);
            model.addAttribute("baseTypeFieldList",jsonArray);
            return "tag/viewBaseModelDetail";
        }
        /*
         * action为列表，把系统中符合条件的数据类型列出来，复合数据类型需要按级别设置好深度，便于页面层级显示
         */
        else if ("list".equals(action)) {
            // type>0表示只取基础数据类型或扩展数据类型，否则是复合数据类型
            if (type > 0) {
                baseTypeList = tagBaseTypeService.getTagBaseTypeByType(type);
            } else {
                // 获取顶级节点
                TagBaseType topBaseType = tagBaseTypeService.getTagBaseTypeById(TreeNode.TOP_NODE_ID);
                if (topBaseType != null) {
                    // 添加顶级节点到list中
                    baseTypeList.add(topBaseType);
                    // 将顶级节点的父节点深度0加入到深度Map中
                    Map<String, Integer> levelMap = new HashMap<String, Integer>();
                    // 对列表循环并动态增长（增长的是子节点）
                    for (int i = 0; i < baseTypeList.size(); i++) {
                        TagBaseType tdt = baseTypeList.get(i);
                        if (TreeNode.TOP_NODE_ID.equals(tdt.getId())) {
                            tdt.setLevel(1);// 设置深度
                            levelMap.put(TreeNode.TOP_NODE_ID, 1);
                        } else {
                            tdt.setLevel(levelMap.get(tdt.getParentTypeId()) + 1);
                            levelMap.put(tdt.getId(), levelMap.get(tdt.getParentTypeId()) + 1);
                        }
                        // 如果不是顶级节点且不是复合节点的节点则移除
                        if (tdt.getType() != 3 && !TreeNode.TOP_NODE_ID.equals(tdt.getId())) {// 写死类型3，臭味代码
                            baseTypeList.remove(i--);
                            continue;
                        }
                        // 设置最深的深度
                        if (levels < tdt.getLevel()) {
                            levels = tdt.getLevel();
                        }
                        List<TagBaseTypeField> fieldList = tagBaseTypeFieldService.getFTagBaseTypeFieldByBelongBaseTypeId(tdt.getId());
                        StringBuffer sb = new StringBuffer();
                        for (TagBaseTypeField field : fieldList) {
                            final TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(field.getTypeElementId());
                            sb.append(", ").append(tagDataTypeElement.getCode());
                        }
                        if (sb.length() > 0) {
                            tdt.setAttrString(sb.toString().substring(1));
                        }
                        // 获取自己点加入到该节点后面
                        List<TagBaseType> list = tagBaseTypeService.getTagBaseTypeByParentId(tdt.getId());
                        if (list.size() > 0) {
                            baseTypeList.addAll(i + 1, list);
                            levelMap.put(tdt.getId(), tdt.getLevel());
                        }
                    }
                }
            }
            model.addAttribute("levels",levels);
            model.addAttribute("type",type);
            model.addAttribute("baseTypeList",baseTypeList);
            return "tag/viewBaseModelList";
        }else {
            /*
             * 如果action为空表示跳到web浏览主页
             */
            tagBaseType = tagBaseTypeService.getTagBaseTypeById(TreeNode.TOP_NODE_ID);
            baseTypeList = tagBaseTypeService.getFirstShow();
            model.addAttribute("tagBaseType",tagBaseType);
            model.addAttribute("baseTypeList",baseTypeList);
            model.addAttribute("type",type);
            return "tag/viewBaseModel";
        }
    }
}
