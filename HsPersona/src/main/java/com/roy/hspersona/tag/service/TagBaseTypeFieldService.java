package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.tag.entity.TagBaseType;
import com.roy.hspersona.tag.entity.TagBaseTypeField;
import com.roy.hspersona.tag.entity.TagDataTypeElement;
import com.roy.hspersona.tag.mapper.TagBaseTypeFieldMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/6
 * @desc
 */
@Service
public class TagBaseTypeFieldService {

    @Resource
    private TagBaseTypeService tagBaseTypeService;

    @Resource
    private TagDataTypeElementService tagDataTypeElementService;

    @Resource
    private TagBaseTypeFieldMapper tagBaseTypeFieldMapper;
    @Resource
    private TagBaseTypeFieldExpressService tagBaseTypeFieldExpressService;

    public Page<TagBaseTypeField> getTagBaseTypeFieldByBelongBaseTypeId(String belongBaseTypeId, List<Integer> types, long page, long rows) {
        Page<TagBaseTypeField> pager = new Page<>(page,rows);
        QueryWrapper<TagBaseTypeField> queryWrapper = new QueryWrapper<>();
        List<String> ids = new ArrayList<String>();
        String parentId = belongBaseTypeId;
        while (StringUtils.isNotBlank(parentId)){
            ids.add(parentId);
            TagBaseType tagBaseType = tagBaseTypeService.getTagBaseTypeById(parentId);
            if (null != tagBaseType ) {
                parentId = tagBaseType.getParentTypeId();
            }else{
                parentId = "";
            }
        }
        if(ids.size()>0){
            queryWrapper.in("belongTypeId",ids);
        }
        if((null != types) && types.size()>0){
            queryWrapper.in("selfBaseTypeId",types);
        }

        return tagBaseTypeFieldMapper.selectPage(pager,queryWrapper);
    }

    public List<TagBaseTypeField> getFTagBaseTypeFieldByBelongBaseTypeId(String belongBaseTypeId) {
        QueryWrapper<TagBaseTypeField> queryWrapper = new QueryWrapper<>();
        List<String> ids = new ArrayList<>();
        String parentId = belongBaseTypeId;
        while (StringUtils.isNotBlank(parentId)){
            ids.add(parentId);
            TagBaseType tagBaseType = tagBaseTypeService.getTagBaseTypeById(parentId);
            if (null != tagBaseType ) {
                parentId = tagBaseType.getParentTypeId();
            }else{
                parentId = "";
            }
        }
        if(ids.size()>0){
            queryWrapper.in("belongTypeId",ids);
        }
        return tagBaseTypeFieldMapper.selectList(queryWrapper);
    }

    public void deleteTagBaseTypeFieldByBelongBaseTypeId(String belongTypeId) {
        UpdateWrapper<TagBaseTypeField> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("belongTypeId",belongTypeId);
        tagBaseTypeFieldMapper.delete(updateWrapper);
    }

    public List<TagBaseTypeField> getMTagBaseTypeFieldByBelongBaseTypeId(String belongTypeId) {
        QueryWrapper<TagBaseTypeField> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("belongTypeId",belongTypeId);
        return tagBaseTypeFieldMapper.selectList(queryWrapper);
    }

    public void removeBaseTypeFieldById(String id) {

        tagBaseTypeFieldExpressService.deleteTagBaseTypeFieldExpressByBaseTypeFieldId(id);
        tagBaseTypeFieldMapper.deleteById(id);
    }

    public TagBaseTypeField getTagBaseTypeFieldByElement(String dataTypeElementId, String belongBaseTypeId) {
        QueryWrapper<TagBaseTypeField> queryWrapper = new QueryWrapper<>();
        if (StringUtils.isNotEmpty(belongBaseTypeId)) {
            queryWrapper.eq("belongTypeId",belongBaseTypeId);
        }
        if (StringUtils.isNotEmpty(dataTypeElementId)) {
            queryWrapper.eq("typeElementId",dataTypeElementId);
        }
        List<TagBaseTypeField> list = tagBaseTypeFieldMapper.selectList(queryWrapper);
        return list.size() > 0 ? list.get(0) : null;
    }

    public void saveTagBaseTypeField(TagBaseTypeField tagBaseTypeField, TagDataTypeElement dataTypeElement, TagBaseType belongBaseType, TagBaseType selfBaseType) {
        tagBaseTypeFieldMapper.insert(tagBaseTypeField);
    }

    public TagBaseTypeField getTagBaseTypeFieldById(String id) {
        return tagBaseTypeFieldMapper.selectById(id);
    }

    public void updateTagBaseTypeField(TagBaseTypeField tagBaseTypeField, TagDataTypeElement dataTypeElement, TagBaseType selfBaseType) {
        tagBaseTypeFieldMapper.updateById(tagBaseTypeField);
    }

    public void saveTagBaseTypeFieldOnly(TagBaseTypeField tagBaseTypeField) {
        tagBaseTypeFieldMapper.insert(tagBaseTypeField);
    }

    public List<Map<String,Object>> getUnSelectField(String typeId, int industryType) {
        return tagBaseTypeFieldMapper.getUnSelectField(typeId,industryType);
    }

    public List<TagBaseTypeField> getFTagBaseTypeFieldByBelongBaseTypeIdAndIsQuery(String belongBaseTypeId, int isQuery) {
        QueryWrapper<TagBaseTypeField> queryWrapper = new QueryWrapper<>();
        String parentId = belongBaseTypeId;
        List<String> ids = new ArrayList<>();
        while (StringUtils.isNotEmpty(parentId)) {
            ids.add(parentId);
            TagBaseType tagBaseType = tagBaseTypeService.getTagBaseTypeById(parentId);
            if (tagBaseType == null) {
                parentId = "";
            } else {
                parentId = tagBaseType.getParentTypeId();
            }
        }

        if(ids.size()>0){
            queryWrapper.in("belongTypeId",ids);
        }
        queryWrapper.eq("isQuery",isQuery);
        return tagBaseTypeFieldMapper.selectList(queryWrapper);
    }
}
