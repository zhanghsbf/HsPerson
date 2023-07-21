package com.roy.hspersona.tag.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.system.entity.SysDictionary;
import com.roy.hspersona.system.service.SysDictionaryService;
import com.roy.hspersona.tag.entity.TagDataTypeElement;
import com.roy.hspersona.tag.entity.TagExtType;
import com.roy.hspersona.tag.entity.TagExtTypeField;
import com.roy.hspersona.tag.entity.TagExtTypeFieldExpress;
import com.roy.hspersona.tag.mapper.TagExtTypeMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/8
 * @desc
 */
@Service
public class TagExtTypeService {
    @Resource
    private TagExtTypeMapper tagExtTypeMapper;
    @Resource
    private TagExtTypeFieldExpressService tagExtTypeFieldExpressService;
    @Resource
    private TagExtTypeFieldService tagExtTypeFieldService;
    @Resource
    private SysDictionaryService sysDictionaryService;

    public int getIndustryTypeNum(int industryType) {
        QueryWrapper<TagExtType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("industryType",industryType);
        return tagExtTypeMapper.selectCount(queryWrapper);
    }

    public void removeAllExtTypeByIndustryValue(int industryValue) {
        tagExtTypeFieldExpressService.deleteTagExtTypeFieldExpressByIndustryValue(industryValue);
        tagExtTypeFieldService.deleteTagExtTypeFieldByIndustryValue(industryValue);

        UpdateWrapper<TagExtType> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("industryType",industryValue);
        tagExtTypeMapper.delete(updateWrapper);
    }

    public Page<TagExtType> getTagExtType(Map<String, Object> map, long page, long rows) {
        Page<TagExtType> pager = new Page<>(page,rows);
        QueryWrapper<TagExtType> queryWrapper = new QueryWrapper<>();
        
        if (StringUtils.isNotEmpty((String) map.get("code"))) {
            queryWrapper.like("code","%" + map.get("code") + "%");
        }
        if (StringUtils.isNotEmpty((String) map.get("ww_code"))) {
            queryWrapper.eq("code",map.get("ww_code"));
        }
        if (map.get("isFirstShow") != null) {
            queryWrapper.eq("isFirstShow",map.get("isFirstShow"));
        }
        if (map.get("type") != null) {
            queryWrapper.eq("type",map.get("type"));
        }
        if (map.get("industryType") != null) {
            queryWrapper.eq("industryType",map.get("industryType"));
        }
        queryWrapper.orderByAsc("treeCode");
        return tagExtTypeMapper.selectPage(pager,queryWrapper);
    }

    public TagExtType getTagExtTypeById(String typeId) {
        return tagExtTypeMapper.selectById(typeId);
    }

    public void removeExtTypeById(String id) throws MyException {
        List<TagExtType> childList = this.getTagExtTypeByParentId(id);
        if (childList.size() > 0) {
            throw new MyException("该类型存在子类型");
        }
        List<TagExtTypeFieldExpress> expressList = tagExtTypeFieldExpressService.getTagExtTypeFieldExpressByExttypeId(id);
        tagExtTypeFieldExpressService.deleteTagExtTypeFieldExpresses(expressList);
        tagExtTypeFieldService.deleteTagExtTypeFieldByBelongExtTypeId(id);
        this.deleteTagExtTypeById(id);
    }

    private void deleteTagExtTypeById(String id) {
        tagExtTypeMapper.deleteById(id);
    }

    public List<TagExtType> getTagExtTypeByParentId(String id) {
        QueryWrapper<TagExtType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("parentTypeId",id);
        queryWrapper.orderByAsc("treeCode");
        return tagExtTypeMapper.selectList(queryWrapper);
    }

    public TagExtType getTagExtTypeByCode(String code, int industryType) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("ww_code", code);
        map.put("industryType", industryType);
        List<TagExtType> list = this.getTagExtType(map, 1, 1).getRecords();
        return list.size() > 0 ? list.get(0) : null;
    }

    public String getMaxTreeCode(String parentTypeId) {
        QueryWrapper<TagExtType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("parentTypeId",parentTypeId);
        queryWrapper.orderByDesc("treeCode");
        List<TagExtType> list = tagExtTypeMapper.selectList(queryWrapper);
        return (list.size() == 0) ? null : list.get(0).getTreeCode();
    }

    public void createTagExtType(TagExtType tagExtType) throws MyException {
        if (tagExtType == null || StringUtils.isEmpty(tagExtType.getId())) {
            return;
        }
        // 如果父类型是顶级类型，则必须检查父类型，并作相应处理
        if (TreeNode.TOP_NODE_ID.equals(tagExtType.getParentTypeId())) {
            TagExtType topTagExtType = this.getTagExtTypeById(TreeNode.TOP_NODE_ID);
            // 如果付类型不存在，则必须新建，新建顶级类型是，有些必要的参数和字典数据必须要存在
            if (topTagExtType == null) {

                // new一个实体
                topTagExtType = new TagExtType();
                topTagExtType.setId(TreeNode.TOP_NODE_ID);
                topTagExtType.setIsFirstShow(0);
                topTagExtType.setIndustryType(tagExtType.getIndustryType());
                topTagExtType.setName("顶级类型");
                topTagExtType.setMemo("顶级类型");
                // 检查参数并设置
                String extModelTopClass = ConstantParam.paramMap.get(ConstantParam.MODEL_TOP_CLASS);
                if (extModelTopClass == null) {
                    throw new MyException("请联系系统管理员设置模型顶级类名参数（" + ConstantParam.MODEL_TOP_CLASS + "）");
                }
                topTagExtType.setCode(extModelTopClass);

                if (tagExtType.getCode().equals(topTagExtType.getCode())) {
                    throw new MyException("设置的类型编码与顶级类型编码相同");
                }

                // 检查字典数据并设置
                List<SysDictionary> dictList = sysDictionaryService.getDictionaryByType(ConstantDict.DATA_TYPE);
                if (dictList.size() == 0) {
                    throw new MyException("请先在字典表中建立字典类型为（" + ConstantDict.DATA_TYPE + "）的字典数据");
                }
                try {
                    topTagExtType.setType(Integer.parseInt(dictList.get(0).getItemValue()));
                } catch (Exception e) {
                    throw new MyException("字典类型为（" + ConstantDict.DATA_TYPE + "）的字典值必须为数字");
                }
                // 保存
                tagExtTypeMapper.insert(topTagExtType);
            }
        }
        // 保存本次需要保存的数据
        tagExtTypeMapper.insert(tagExtType);
    }

    public void modifyTagExtType(TagExtType tagExtType) throws MyException {
        if (tagExtType == null || StringUtils.isEmpty(tagExtType.getId())) {
            return;
        }
        // 如果类型是顶级类型，则编码和基本类型不管用户怎么改都设置为默认数据
        if (TreeNode.TOP_NODE_ID.equals(tagExtType.getId())) {
            // 检查参数并设置
            String extModelTopClass = ConstantParam.paramMap.get(ConstantParam.MODEL_TOP_CLASS);
            if (extModelTopClass == null) {
                throw new MyException("请联系系统管理员设置模型顶级类名参数（" + ConstantParam.MODEL_TOP_CLASS + "）");
            }
            tagExtType.setCode(extModelTopClass);

            // 检查字典数据并设置
            List<SysDictionary> dictList = sysDictionaryService.getDictionaryByType(ConstantDict.DATA_TYPE);
            if (dictList.size() == 0) {
                throw new MyException("请先在字典表中建立字典类型为（" + ConstantDict.DATA_TYPE + "）的字典数据");
            }
            try {
                tagExtType.setType(Integer.parseInt(dictList.get(0).getItemValue()));
            } catch (Exception e) {
                throw new MyException("字典类型为（" + ConstantDict.DATA_TYPE + "）的字典值必须为数字");
            }
        }
        tagExtTypeMapper.updateById(tagExtType);
    }

    public void saveImportData(List<TagExtType> typeList, List<TagExtTypeField> fieldList, List<TagExtTypeFieldExpress> extExpressList) {
        for (TagExtType tagExtType : typeList) {
            tagExtTypeMapper.insert(tagExtType);
        }
        tagExtTypeFieldService.saveTagExtTypeFields(fieldList);
        tagExtTypeFieldExpressService.saveTagExtTypeFieldExpresses(extExpressList);
    }

    public List<TagExtType> getTagExtTypeByType(int type) {
        QueryWrapper<TagExtType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("type",type);
        queryWrapper.orderByDesc("treeCode");
        return tagExtTypeMapper.selectList(queryWrapper);
    }

    public List<TagExtType> getFirstShow(int industryType) {
        QueryWrapper<TagExtType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("isFirstShow",1);
        if(industryType!=0){
            queryWrapper.eq("industryType",industryType);
        }
        queryWrapper.orderByDesc("treeCode");
        return tagExtTypeMapper.selectList(queryWrapper);
    }

    public JSONArray getSelectTagExtType() {
        List<TagExtType> tagExtTypes = this.getFirstShow(0);
        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < tagExtTypes.size(); i++) {
            // 找到首先显示的id
            String extTypeId = tagExtTypes.get(i).getId();
            List<TagExtTypeField> tagExtTypeFields = tagExtTypeFieldService.getFTagExtTypeFieldByBelongExtTypeId(extTypeId);
            for (int j = 0; j < tagExtTypeFields.size(); j++) {
                TagExtTypeField tagExtTypeField = tagExtTypeFields.get(j);
                TagExtType type = tagExtTypeField.getSelfExtType();
                if (type.getType() != 3) {
                    // 如果数据类型是基础数据类型或者是扩展数据类型
                    // 本属性参数不需要父节点，所以路径直接返回
                    JSONObject jsonObject = new JSONObject();
                    TagDataTypeElement dataTypeElement = tagExtTypeField.getDataTypeElement();
                    jsonObject.put("typeENPath", dataTypeElement.getCode());
                    jsonObject.put("typeCNPath", dataTypeElement.getName());
                    jsonObject.put("elementType", type.getCode());
                    jsonArray.add(jsonObject);
                } else if ((tagExtTypeField.getSelfExtType().getType() == 3) && (tagExtTypeField.getIsArray() == 0)) {
                    // 如果数据类型为复合数据类型，且不是数组的类型，深入查询
                    String sonLoginTypeId = tagExtTypeField.getSelfExtType().getId();
                    List<TagExtTypeField> sonTagExtTypeFields = tagExtTypeFieldService.getFTagExtTypeFieldByBelongExtTypeId(sonLoginTypeId);
                    for (int k = 0; k < sonTagExtTypeFields.size(); k++) {
                        TagExtTypeField sonTagExtTypeField = sonTagExtTypeFields.get(k);
                        TagExtType sonTagExtType = sonTagExtTypeField.getSelfExtType();
                        if ((sonTagExtType.getType() == 1) && (sonTagExtTypeField.getIsQuery() == 1)) {
                            JSONObject jsonObject = new JSONObject();
                            StringBuffer typeENPathBuffer = new StringBuffer();
                            StringBuffer typeCNPathBuffer = new StringBuffer();
                            TagDataTypeElement dataTypeElement = tagExtTypeField.getDataTypeElement();
                            TagDataTypeElement sonDataTypeElement = sonTagExtTypeField.getDataTypeElement();
                            typeENPathBuffer.append(dataTypeElement.getCode()).append(".");
                            typeCNPathBuffer.append(dataTypeElement.getName()).append(".");
                            typeENPathBuffer.append(sonDataTypeElement.getCode());
                            typeCNPathBuffer.append(sonDataTypeElement.getName());
                            jsonObject.put("typeENPath", typeENPathBuffer.toString());
                            jsonObject.put("typeCNPath", typeCNPathBuffer.toString());
                            jsonObject.put("elementType", sonTagExtType.getCode());
                            jsonArray.add(jsonObject);
                        }
                    }
                }
            }
        }
        return jsonArray;
    }
}
