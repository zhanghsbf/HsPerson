package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagBaseTypeField;
import com.roy.hspersona.tag.entity.TagBaseTypeFieldExpress;
import com.roy.hspersona.tag.mapper.TagBaseTypeFieldExpressMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/6
 * @desc
 */
@Service
public class TagBaseTypeFieldExpressService {

    @Resource
    private TagBaseTypeFieldExpressMapper tagBaseTypeFieldExpressMapper;

    public List<TagBaseTypeFieldExpress> getTagBaseTypeFieldExpressByBaseTypeId(String baseTypeId) {

        QueryWrapper<TagBaseTypeFieldExpress> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("baseTypeFieldId",baseTypeId);
        return tagBaseTypeFieldExpressMapper.selectList(queryWrapper);
    }

    public void deleteTagBaseTypeFieldExpresses(List<TagBaseTypeFieldExpress> expressList) {
        for (TagBaseTypeFieldExpress tagBaseTypeFieldExpress : expressList) {
            tagBaseTypeFieldExpressMapper.deleteById(tagBaseTypeFieldExpress);
        }
    }

    public void deleteTagBaseTypeFieldExpressByBaseTypeFieldId(String baseTypeId) {
        UpdateWrapper<TagBaseTypeFieldExpress> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("baseTypeFieldId",baseTypeId);
        tagBaseTypeFieldExpressMapper.delete(updateWrapper);
    }

    public Page<TagBaseTypeFieldExpress> getTagBaseTypeFieldExpress(String fieldId, long page, long rows) {
        Page<TagBaseTypeFieldExpress> pager = new Page<>(page,rows);
        QueryWrapper<TagBaseTypeFieldExpress> queryWrapper = new QueryWrapper<>();
        if (StringUtils.isNotEmpty(fieldId)) {
            queryWrapper.eq("baseTypeFieldId",fieldId);
        }
        return tagBaseTypeFieldExpressMapper.selectPage(pager,queryWrapper);
    }

    public void deleteTagBaseTypeFieldExpressById(String id) {
        tagBaseTypeFieldExpressMapper.deleteById(id);
    }

    public void saveTagBaseTypeFieldExpress(TagBaseTypeFieldExpress tagBaseTypeFieldExpress, TagBaseTypeField tagBaseTypeField) {
        tagBaseTypeFieldExpressMapper.insert(tagBaseTypeFieldExpress);
    }

    public TagBaseTypeFieldExpress getTagBaseTypeFieldExpressById(String id) {
        return tagBaseTypeFieldExpressMapper.selectById(id);
    }

    public void updateTagBaseTypeFieldExpress(TagBaseTypeFieldExpress tagBaseTypeFieldExpress) {
        tagBaseTypeFieldExpressMapper.updateById(tagBaseTypeFieldExpress);
    }

    public List<TagBaseTypeFieldExpress> getTagBaseTypeFieldExpressByFieldId(String fieldId) {
        QueryWrapper<TagBaseTypeFieldExpress> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("baseTypeFieldId",fieldId);
        return tagBaseTypeFieldExpressMapper.selectList(queryWrapper);
    }
}
