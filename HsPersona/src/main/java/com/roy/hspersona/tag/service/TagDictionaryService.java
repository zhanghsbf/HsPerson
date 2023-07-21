package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagDictionary;
import com.roy.hspersona.tag.mapper.TagDictionaryMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/5
 * @desc
 */
@Service
public class TagDictionaryService {

    @Resource
    private TagDictionaryMapper tagDictionaryMapper;

    public Page<TagDictionary> getTagDictionary(Map<String, Object> map, long page, long rows) {
        Page<TagDictionary> pager = new Page<>(page,rows);
        QueryWrapper<TagDictionary> queryWrapper = new QueryWrapper<>();
        if (StringUtils.isNotEmpty((String) map.get("type"))) {
            queryWrapper.like("type","%" + map.get("type") + "%");
        }
        if (StringUtils.isNotEmpty((String) map.get("itemName"))) {
            queryWrapper.eq(("itemName"),map.get("itemName"));
        }
        if (StringUtils.isNotEmpty((String) map.get("itemValue"))) {
            queryWrapper.eq(("itemValue"),map.get("itemValue"));
        }
        queryWrapper.orderByAsc("type","orders");
        return tagDictionaryMapper.selectPage(pager,queryWrapper);
    }

    public TagDictionary getTagDictionaryById(String dictionaryId) {
        return tagDictionaryMapper.selectById(dictionaryId);
    }

    public String deleteTagDictionaryById(String dictionaryId) {
        tagDictionaryMapper.deleteById(dictionaryId);
        return "";
    }

    public TagDictionary getTagDictionaryNameType(String name, String type) {
        QueryWrapper<TagDictionary> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("itemName",name);
        queryWrapper.eq("type",type);
        final List<TagDictionary> list = tagDictionaryMapper.selectList(queryWrapper);
        return list.size()==0 ? null : list.get(0);
    }

    public TagDictionary getTagDictionaryitemValueType(String itemValue, String type) {
        QueryWrapper<TagDictionary> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("itemValue",itemValue);
        queryWrapper.eq("type",type);
        final List<TagDictionary> list = tagDictionaryMapper.selectList(queryWrapper);
        return list.size()==0 ? null : list.get(0);
    }

    public void saveTagDictionary(TagDictionary dictionary) {
        tagDictionaryMapper.insert(dictionary);
    }

    public void updateTagDictionary(TagDictionary dictionary) {
        tagDictionaryMapper.updateById(dictionary);
    }

    public String getStringMemo(String code) {
        QueryWrapper<TagDictionary> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("type",code);
        queryWrapper.orderByDesc("orders");
        final List<TagDictionary> dictList = tagDictionaryMapper.selectList(queryWrapper);
        StringBuffer sb = new StringBuffer();
        for (TagDictionary dict : dictList) {
            sb.append(",").append(dict.getItemValue()).append(":").append(dict.getItemName());
        }
        return sb.length() > 0 ? sb.toString().substring(1) : "";
    }

    public List<TagDictionary> getAllTagDictionary() {
        return tagDictionaryMapper.selectList(null);
    }
}
