package com.roy.hspersona.system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.system.entity.SysDictionary;
import com.roy.hspersona.system.mapper.SysDictionaryMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/3
 * @desc
 */
@Service
public class SysDictionaryService {

    @Resource
    private SysDictionaryMapper sysDictionaryMapper;


    public Map<String, String> getMapByCode(String code) {

        List<SysDictionary> list = this.getDictionaryByType(code);
        Map<String, String> map = new HashMap<>();
        for (SysDictionary dict : list) {
            map.put(dict.getItemValue(), dict.getItemName());
        }
        return map;
    }

    public List<SysDictionary> getDictionaryByType(String code) {
        QueryWrapper<SysDictionary> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("orders");
        queryWrapper.eq("type",code);
        return sysDictionaryMapper.selectList(queryWrapper);
    }

    public Page<SysDictionary> getDictionary(Map<String, Object> map, long page, long rows) {
        Page<SysDictionary> pager = new Page<>(page,rows);
        QueryWrapper<SysDictionary> queryWrapper = new QueryWrapper<>();
        if (StringUtils.isNotEmpty((String) map.get("type"))) {
            queryWrapper.like("type","%" + map.get("type") + "%");
        }
        if (StringUtils.isNotEmpty((String) map.get("ww_type"))) {
            queryWrapper.eq("type",map.get("ww_type"));
        }
        if (StringUtils.isNotEmpty((String) map.get("itemName"))) {
            queryWrapper.eq("itemName",map.get("itemName"));
        }
        if (StringUtils.isNotEmpty((String) map.get("itemValue"))) {
            queryWrapper.eq("itemValue",map.get("itemValue"));
        }

        return sysDictionaryMapper.selectPage(pager,queryWrapper);
    }

    public String deleteDictionaryById(String dictionaryId) {
        return ""+sysDictionaryMapper.deleteById(dictionaryId);
    }

    public SysDictionary getDictionaryById(String id) {
        return sysDictionaryMapper.selectById(id);
    }

    public SysDictionary getDictionaryNameType(String name, String type) {
        QueryWrapper<SysDictionary> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("itemName",name);
        queryWrapper.eq("type",type);

        final List<SysDictionary> list = sysDictionaryMapper.selectList(queryWrapper);
        return (list.size() == 0) ? null : list.get(0);
    }

    public SysDictionary getDictionaryitemValueType(String itemValue, String type) {
        QueryWrapper<SysDictionary> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("itemValue",itemValue);
        queryWrapper.eq("type",type);

        final List<SysDictionary> list = sysDictionaryMapper.selectList(queryWrapper);
        return (list.size() == 0) ? null : list.get(0);
    }

    public void saveDictionary(SysDictionary dictionary) {
        sysDictionaryMapper.insert(dictionary);
    }

    public void updateDictionary(SysDictionary dictionary) {
        sysDictionaryMapper.updateById(dictionary);
    }
}
