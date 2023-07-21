package com.roy.hspersona.tag.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.system.entity.SysDictionary;
import com.roy.hspersona.system.service.SysDictionaryService;
import com.roy.hspersona.tag.entity.TagBaseType;
import com.roy.hspersona.tag.entity.TagBaseTypeField;
import com.roy.hspersona.tag.entity.TagBaseTypeFieldExpress;
import com.roy.hspersona.tag.entity.TagDataTypeElement;
import com.roy.hspersona.tag.mapper.TagBaseTypeMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/6
 * @desc
 */
@Service
public class TagBaseTypeService {

    @Resource
    private TagBaseTypeMapper tagBaseTypeMapper;

    @Resource
    private TagBaseTypeFieldService tagBaseTypeFieldService;

    @Resource
    private SysDictionaryService sysDictionaryService;

    @Resource
    private TagDataTypeElementService tagDataTypeElementService;

    @Resource
    private TagBaseTypeFieldExpressService tagBaseTypeFieldExpressService;

    public Page<TagBaseType> getTagBaseType(Map<String, Object> map, long page, long rows) {

        Page<TagBaseType> pager = new Page<>(page,rows);
        QueryWrapper<TagBaseType> queryWrapper = new QueryWrapper<>();

        if (StringUtils.isNotEmpty((String) map.get("code"))) {
            queryWrapper.like("code","%" + map.get("code") + "%");
        }
        if (StringUtils.isNotEmpty((String) map.get("name"))) {
            queryWrapper.like("name","%" + map.get("name") + "%");
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
        queryWrapper.orderByAsc("treeCode");
        return tagBaseTypeMapper.selectPage(pager,queryWrapper);
    }

    public TagBaseType getTagBaseTypeById(String typeId) {
        return tagBaseTypeMapper.selectById(typeId);
    }

    public void removeBaseTypeById(String id) throws MyException {
        List<TagBaseType> childList = this.getTagBaseTypeByParentId(id);
        if (childList.size() > 0) {
            throw new MyException("该类型存在子类型");
        }
        List<TagBaseTypeFieldExpress> expressList = tagBaseTypeFieldExpressService.getTagBaseTypeFieldExpressByBaseTypeId(id);
        tagBaseTypeFieldExpressService.deleteTagBaseTypeFieldExpresses(expressList);
        tagBaseTypeFieldService.deleteTagBaseTypeFieldByBelongBaseTypeId(id);
        this.deleteTagBaseTypeById(id);
    }

    private int deleteTagBaseTypeById(String id) {
        return tagBaseTypeMapper.deleteById(id);
    }

    public List<TagBaseType> getTagBaseTypeByParentId(String parentTypeId) {
        QueryWrapper<TagBaseType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("parentTypeId",parentTypeId);
        queryWrapper.orderByAsc("treeCode");
        return tagBaseTypeMapper.selectList(queryWrapper);
    }

    public TagBaseType getTagBaseTypeByCode(String code) {
        QueryWrapper<TagBaseType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("code",code);
        return tagBaseTypeMapper.selectOne(queryWrapper);
    }

    public String getMaxTreeCode(String parentTypeId) {
        QueryWrapper<TagBaseType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("parentTypeId",parentTypeId);
        queryWrapper.orderByDesc("treeCode");
        List<TagBaseType> list = tagBaseTypeMapper.selectList(queryWrapper);
        return (list.size() == 0) ? null : list.get(0).getTreeCode();
    }

    public void createTagBaseType(TagBaseType tagBaseType) throws MyException {
        if (tagBaseType == null || StringUtils.isEmpty(tagBaseType.getId())) {
            return;
        }
        // 如果父类型是顶级类型，则必须检查父类型，并作相应处理
        if (TreeNode.TOP_NODE_ID.equals(tagBaseType.getParentTypeId())) {
            TagBaseType topTagBaseType = this.getTagBaseTypeById(TreeNode.TOP_NODE_ID);
            // 如果付类型不存在，则必须新建，新建顶级类型是，有些必要的参数和字典数据必须要存在
            if (topTagBaseType == null) {

                // new一个实体
                topTagBaseType = new TagBaseType();
                topTagBaseType.setId("-1");
                topTagBaseType.setIsFirstShow(0);
                topTagBaseType.setName("顶级类型");
                topTagBaseType.setMemo("顶级类型");
                // 检查参数并设置
                String baseModelTopClass = ConstantParam.paramMap.get(ConstantParam.MODEL_TOP_CLASS);
                if (baseModelTopClass == null) {
                    throw new MyException("请联系系统管理员设置模型顶级类名参数（" + ConstantParam.MODEL_TOP_CLASS + "）");
                }
                topTagBaseType.setCode(baseModelTopClass);

                if (tagBaseType.getCode().equals(topTagBaseType.getCode())) {
                    throw new MyException("设置的类型编码与顶级类型编码相同");
                }

                // 检查字典数据并设置
                List<SysDictionary> dictList = sysDictionaryService.getDictionaryByType(ConstantDict.DATA_TYPE);
                if (dictList.size() == 0) {
                    throw new MyException("请先在字典表中建立字典类型为（" + ConstantDict.DATA_TYPE + "）的字典数据");
                }
                try {
                    topTagBaseType.setType(Integer.parseInt(dictList.get(0).getItemValue()));
                } catch (Exception e) {
                    throw new MyException("字典类型为（" + ConstantDict.DATA_TYPE + "）的字典值必须为数字");
                }
                // 保存
                tagBaseTypeMapper.insert(topTagBaseType);
            }
        }
        // 保存本次需要保存的数据
        tagBaseTypeMapper.insert(tagBaseType);
    }

    public void modifyTagBaseType(TagBaseType tagBaseType) throws MyException {
        if (tagBaseType == null || StringUtils.isEmpty(tagBaseType.getId())) {
            return;
        }
        // 如果类型是顶级类型，则编码和基本类型不管用户怎么改都设置为默认数据
        if (TreeNode.TOP_NODE_ID.equals(tagBaseType.getId())) {
            // 检查参数并设置
            String baseModelTopClass = ConstantParam.paramMap.get(ConstantParam.MODEL_TOP_CLASS);
            if (baseModelTopClass == null) {
                throw new MyException("请联系系统管理员设置模型顶级类名参数（" + ConstantParam.MODEL_TOP_CLASS + "）");
            }
            tagBaseType.setCode(baseModelTopClass);

            // 检查字典数据并设置
            List<SysDictionary> dictList = sysDictionaryService.getDictionaryByType(ConstantDict.DATA_TYPE);
            if (dictList.size() == 0) {
                throw new MyException("请先在字典表中建立字典类型为（" + ConstantDict.DATA_TYPE + "）的字典数据");
            }
            try {
                tagBaseType.setType(Integer.parseInt(dictList.get(0).getItemValue()));
            } catch (Exception e) {
                throw new MyException("字典类型为（" + ConstantDict.DATA_TYPE + "）的字典值必须为数字");
            }
        }
        tagBaseTypeMapper.updateById(tagBaseType);
    }

    public void saveBaseType(TagBaseType belongBaseType) {
        tagBaseTypeMapper.insert(belongBaseType);
    }

    public void updateTagBaseType(TagBaseType selfBaseType) {
        tagBaseTypeMapper.updateById(selfBaseType);
    }

    public List<TagBaseType> getTagBaseTypeByType(int type) {
        QueryWrapper<TagBaseType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("type",type);
        queryWrapper.orderByAsc("treeCode");
        return tagBaseTypeMapper.selectList(queryWrapper);
    }

    public List<TagBaseType> getFirstShow() {
        QueryWrapper<TagBaseType> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("isFirstShow",1);
        queryWrapper.orderByAsc("treeCode");
        return tagBaseTypeMapper.selectList(queryWrapper);
    }

    public Page<Map<String,Object>> getUnSelectType(int industryType, String typeCode, long page, long rows) {
        Page<Map<String,Object>> pager = new Page<>(page,rows);
        return tagBaseTypeMapper.getUnSelectType(pager,industryType,typeCode);
    }

    public JSONArray getSelectTagBaseType() {
        JSONArray jsonArray = new JSONArray();
        // 获取首要显示的
        List<TagBaseType> firstTagBaseTypeList = this.getFirstShow();
        for (int i = 0; i < firstTagBaseTypeList.size(); i++) {
            // 找到首先显示的id
            String belongBaseTypeId = firstTagBaseTypeList.get(i).getId();

            List<TagBaseTypeField> tagBaseTypeFields = tagBaseTypeFieldService.getFTagBaseTypeFieldByBelongBaseTypeIdAndIsQuery(belongBaseTypeId, 1);
            for (int j = 0; j < tagBaseTypeFields.size(); j++) {
                TagBaseTypeField tagBaseTypeField = tagBaseTypeFields.get(j);
                TagBaseType type = this.getTagBaseTypeById(tagBaseTypeField.getSelfTypeId());
                if (type.getType() != 3) {
                    // 如果数据类型是基础数据类型或者是扩展数据类型
                    // 本属性参数不需要父节点，所以路径直接返回
                    JSONObject jsonObject = new JSONObject();
                    TagDataTypeElement dataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(tagBaseTypeField.getTypeElementId());
                    jsonObject.put("typeENPath", dataTypeElement.getCode());
                    jsonObject.put("typeCNPath", dataTypeElement.getName());
                    jsonObject.put("elementType", type.getCode());
                    jsonArray.add(jsonObject);
                } else if ((type.getType() == 3) && (tagBaseTypeField.getIsArray() == 0)) {
                    // 如果数据类型为复合数据类型，且不是数组的类型，深入查询
                    String sonLoginTypeId = type.getId();
                    List<TagBaseTypeField> sonTagBaseTypeFields = tagBaseTypeFieldService.getFTagBaseTypeFieldByBelongBaseTypeId(sonLoginTypeId);
                    for (int k = 0; k < sonTagBaseTypeFields.size(); k++) {
                        TagBaseTypeField sonTagBaseTypeField = sonTagBaseTypeFields.get(k);
                        TagBaseType sonTagBaseType = this.getTagBaseTypeById(sonTagBaseTypeField.getSelfTypeId());

//                        TagBaseType sonTagBaseType = sonTagBaseTypeField.getSelfBaseType();
                        if ((sonTagBaseType.getType() == 1) && (sonTagBaseTypeField.getIsQuery() == 1)) {
                            JSONObject jsonObject = new JSONObject();
                            StringBuffer typeENPathBuffer = new StringBuffer();
                            StringBuffer typeCNPathBuffer = new StringBuffer();
                            TagDataTypeElement dataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(tagBaseTypeField.getTypeElementId());
                            TagDataTypeElement sonDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(sonTagBaseTypeField.getTypeElementId());
                            typeENPathBuffer.append(dataTypeElement.getCode()).append(".");
                            typeCNPathBuffer.append(dataTypeElement.getName()).append(".");
                            typeENPathBuffer.append(sonDataTypeElement.getCode());
                            typeCNPathBuffer.append(sonDataTypeElement.getName());
                            jsonObject.put("typeENPath", typeENPathBuffer.toString());
                            jsonObject.put("typeCNPath", typeCNPathBuffer.toString());
                            jsonObject.put("elementType", sonTagBaseType.getCode());
                            jsonArray.add(jsonObject);
                        }
                    }
                }
            }
        }
        return jsonArray;
    }
}
