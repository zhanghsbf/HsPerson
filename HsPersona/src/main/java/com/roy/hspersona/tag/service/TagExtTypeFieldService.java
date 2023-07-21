package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagDataTypeElement;
import com.roy.hspersona.tag.entity.TagExtType;
import com.roy.hspersona.tag.entity.TagExtTypeField;
import com.roy.hspersona.tag.mapper.TagExtTypeFieldMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/8
 * @desc
 */
@Service
public class TagExtTypeFieldService {

    @Resource
    private TagExtTypeFieldMapper tagExtTypeFieldMapper;
    @Resource
    private TagExtTypeService tagExtTypeService;
    @Resource
    private TagDataTypeElementService tagDataTypeElementService;


    public void deleteTagExtTypeFieldByIndustryValue(int industryValue) {
        UpdateWrapper<TagExtTypeField> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("industryType",industryValue);
        tagExtTypeFieldMapper.delete(updateWrapper);
    }

    public Page<TagExtTypeField> getTagExtTypeFieldByBelongExtTypeId(String belongExtTypeId, long page, long rows) {
        String parentId = belongExtTypeId;
        List<String> ids = new ArrayList<>();
        while (StringUtils.isNotEmpty(parentId)) {
            ids.add(parentId);
            TagExtType tagExtType = tagExtTypeService.getTagExtTypeById(parentId);
            if (tagExtType == null) {
                parentId = "";
            } else {
                parentId = tagExtType.getParentTypeId();
            }
        }

        return this.getTagExtTypeFieldByBelongExtTypeIds(ids,page,rows);
    }

    private Page<TagExtTypeField> getTagExtTypeFieldByBelongExtTypeIds(List<String> ids,long page, long rows){
        if(ids.size()>0){
            Page<TagExtTypeField> pager = new Page<>(page,rows);
            QueryWrapper<TagExtTypeField> queryWrapper = new QueryWrapper<>();
            queryWrapper.in("belongTypeId",ids);
            return tagExtTypeFieldMapper.selectPage(pager,queryWrapper);
        }else{
            return new Page<TagExtTypeField>();
        }
    }

    public void deleteTagExtTypeFieldByBelongExtTypeId(String id) {
        UpdateWrapper<TagExtTypeField> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("belongTypeId",id);
        tagExtTypeFieldMapper.delete(updateWrapper);
    }

    public List<TagExtTypeField> getMTagExtTypeFieldByBelongExtTypeId(String id) {
        QueryWrapper<TagExtTypeField> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("belongTypeId",id);
        return tagExtTypeFieldMapper.selectList(queryWrapper);
    }

    public void removeExtTypeFieldById(String id) {
        tagExtTypeFieldMapper.deleteById(id);
    }

    public TagExtTypeField getTagExtTypeFieldByElement(String dataTypeElementId, String belongExtTypeId) {
        QueryWrapper<TagExtTypeField> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("belongTypeId",belongExtTypeId);
        queryWrapper.eq("typeElementId",dataTypeElementId);
        final List<TagExtTypeField> list = tagExtTypeFieldMapper.selectList(queryWrapper);
        return list.size() > 0 ? list.get(0) : null;
    }

    public void saveTagExtTypeField(TagExtTypeField tagExtTypeField) {
        tagExtTypeFieldMapper.insert(tagExtTypeField);
    }

    public TagExtTypeField getTagExtTypeFieldById(String id) {
        TagExtTypeField tagExtTypeField =  tagExtTypeFieldMapper.selectById(id);
        this.addRelateTypes(tagExtTypeField);
        return tagExtTypeField;
    }

    public void updateTagExtTypeField(TagExtTypeField tagExtTypeField) {
        tagExtTypeFieldMapper.updateById(tagExtTypeField);
    }

    public List<TagExtTypeField> getFTagExtTypeFieldByBelongExtTypeId(String belongExtTypeId) {
        String parentId = belongExtTypeId;
        List<String> ids = new ArrayList<>();
        while (StringUtils.isNotEmpty(parentId)) {
            ids.add(parentId);
            TagExtType tagExtType = tagExtTypeService.getTagExtTypeById(parentId);
            if (tagExtType == null) {
                parentId = "";
            } else {
                parentId = tagExtType.getParentTypeId();
            }
        }
        QueryWrapper<TagExtTypeField> queryWrapper = new QueryWrapper<>();
        if(ids.size()>0){
            queryWrapper.in("belongTypeId",ids);
        }
        List<TagExtTypeField> tagExtTypeFields = tagExtTypeFieldMapper.selectList(queryWrapper);
        for (TagExtTypeField tagExtTypeField : tagExtTypeFields) {
            this.addRelateTypes(tagExtTypeField);
        }
        return tagExtTypeFields;
    }

    public void saveTagExtTypeFields(List<TagExtTypeField> fieldList) {
        for (TagExtTypeField tagExtTypeField : fieldList) {
            tagExtTypeFieldMapper.insert(tagExtTypeField);
        }
    }

    public Page<TagExtTypeField> getTagExtTypeFieldByBelongExtTypeIdAndType(String belongExtTypeId, List<Integer> types, long page, long rows) {
        Page<TagExtTypeField> pager = new Page<>(page,rows);

        String parentId = belongExtTypeId;
        List<String> ids = new ArrayList<>();
        while (StringUtils.isNotEmpty(parentId)) {
            ids.add(parentId);
            TagExtType tagExtType = tagExtTypeService.getTagExtTypeById(parentId);
            if (tagExtType == null) {
                parentId = "";
            } else {
                parentId = tagExtType.getParentTypeId();
            }
        }
        Page<TagExtTypeField> res =  tagExtTypeFieldMapper.selectByBelongExtTypeIdAndTypes(pager,ids,types);
        for (TagExtTypeField tagExtTypeField : res.getRecords()) {
            final TagExtType selfExtType = tagExtTypeService.getTagExtTypeById(tagExtTypeField.getSelfTypeId());
            tagExtTypeField.setSelfExtType(selfExtType);
            final TagExtType belongExtType = tagExtTypeService.getTagExtTypeById(tagExtTypeField.getBelongTypeId());
            tagExtTypeField.setBelongExtType(belongExtType);
            final TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(tagExtTypeField.getTypeElementId());
            tagExtTypeField.setDataTypeElement(tagDataTypeElement);
        }
        return res;
    }

    public Page<TagExtTypeField> getExtTypeFieldByBelongTypeCodeandDataCode(String belongTypeCode, String dataTypeElementCode) {
        return tagExtTypeFieldMapper.getExtTypeFieldByBelongTypeCodeandDataCode(belongTypeCode,dataTypeElementCode);
    }

    private void addRelateTypes(TagExtTypeField tagExtTypeField){
        final TagExtType belongType = tagExtTypeService.getTagExtTypeById(tagExtTypeField.getBelongTypeId());
        tagExtTypeField.setBelongExtType(belongType);

        final TagExtType selfType = tagExtTypeService.getTagExtTypeById(tagExtTypeField.getSelfTypeId());
        tagExtTypeField.setSelfExtType(selfType);

        final TagDataTypeElement tagDataTypeElement = tagDataTypeElementService.getTagDataTypeElementById(tagExtTypeField.getTypeElementId());
        tagExtTypeField.setDataTypeElement(tagDataTypeElement);
    }
}
