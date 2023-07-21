package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagDataTypeElement;
import com.roy.hspersona.tag.mapper.TagDataTypeElementMapper;
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
public class TagDataTypeElementService {

    @Resource
    private TagDataTypeElementMapper tagDataTypeElementMapper;

    public Page<TagDataTypeElement> getTagDataTypeElement(Map<String, Object> map, long page, long rows) {

        Page<TagDataTypeElement> pager = new Page<>(page,rows);
        QueryWrapper<TagDataTypeElement> queryWrapper = new QueryWrapper<>();

        if (StringUtils.isNotEmpty((String) map.get("code"))) {
            queryWrapper.like("code","%" + map.get("code") + "%");
        }
        if (StringUtils.isNotEmpty((String) map.get("name"))) {
            queryWrapper.like("name","%" + map.get("name") + "%");
        }
        if (StringUtils.isNotEmpty((String) map.get("ww_code"))) {
            queryWrapper.eq("code",map.get("ww_code"));
        }
        if (map.get("enable") != null) {
            queryWrapper.eq("enable",map.get("enable"));
        }
        return tagDataTypeElementMapper.selectPage(pager,queryWrapper);
    }

    public TagDataTypeElement getTagDataTypeElementById(String id) {
        return tagDataTypeElementMapper.selectById(id);
    }

    public int deleteTagDataTypeElementById(String id) {
        return tagDataTypeElementMapper.deleteById(id);
    }

    public TagDataTypeElement getTagDataTypeElementByCode(String code) {
        QueryWrapper<TagDataTypeElement> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("code",code);
        final List<TagDataTypeElement> list = tagDataTypeElementMapper.selectList(queryWrapper);
        return list.size() > 0 ? list.get(0) : null;
    }

    public void saveTagDataTypeElement(TagDataTypeElement element) {
        tagDataTypeElementMapper.insert(element);
    }

    public void updateTagDataTypeElement(TagDataTypeElement element) {
        tagDataTypeElementMapper.updateById(element);
    }

    public List<TagDataTypeElement> getAllTagDataTypeElements() {
        return tagDataTypeElementMapper.selectList(null);
    }
}
