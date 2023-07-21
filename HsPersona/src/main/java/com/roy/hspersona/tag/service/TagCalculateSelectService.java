package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagCalculate;
import com.roy.hspersona.tag.entity.TagCalculateSelect;
import com.roy.hspersona.tag.mapper.TagCalculateSelectMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/10
 * @desc
 */
@Service
public class TagCalculateSelectService {

    @Resource
    private TagCalculateSelectMapper tagCalculateSelectMapper;
    @Resource
    private TagCalculateService tagCalculateService;

    public void updateContentByTagId(String tagContent, String tagId) {
        tagCalculateSelectMapper.updateTagCalSelect(tagContent,tagId);
    }

    public void deleteRuleByTagId(String tagId, String userId) {
        UpdateWrapper<TagCalculateSelect> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("tagId",tagId);
//        updateWrapper.eq("userId",userId);
        tagCalculateSelectMapper.delete(updateWrapper);
    }

    public List<TagCalculateSelect> getTagCalculateSelect(Map<String, Object> map, long page, long rows) {
        Page<TagCalculateSelect> pager = new Page<>(page,rows);
        QueryWrapper<TagCalculateSelect> queryWrapper = new QueryWrapper<>();
        
        if (StringUtils.isNotEmpty((String) map.get("calculateId"))) {
            queryWrapper.eq("calculateId",map.get("calculateId"));
        }
        if (StringUtils.isNotEmpty((String) map.get("tagId"))) {
            queryWrapper.eq("tagId",map.get("tagId"));
        }
        final List<TagCalculateSelect> records = tagCalculateSelectMapper.selectPage(pager, queryWrapper).getRecords();
        if(StringUtils.isNotEmpty((String) map.get("userId"))){
            String userId = (String) map.get("userId");
            for (TagCalculateSelect record : records) {
                final TagCalculate tagCalculate = tagCalculateService.getTagCalculateById(record.getCalculateId());
                if(!StringUtils.equals(tagCalculate.getUserId(),userId)){
                    records.remove(record);
                }
            }
        }
        return records;
    }

    public void deleteTagCalculateSelect(TagCalculateSelect tagCalculateSelect) {
        tagCalculateSelectMapper.deleteById(tagCalculateSelect);
    }

    public void updateTagCalculateSelect(TagCalculateSelect tagCalculateSelect) {
        tagCalculateSelectMapper.updateById(tagCalculateSelect);
    }

    public Page<TagCalculateSelect> getTagCalculateSelectBycalId(String calculateId, long page, long rows) {
        Page<TagCalculateSelect> pager = new Page<>(page,rows);
        QueryWrapper<TagCalculateSelect> queryWrapper = new QueryWrapper<>();

        if (StringUtils.isNotEmpty(calculateId)) {
            queryWrapper.eq("calculateId",calculateId);
        }
        return tagCalculateSelectMapper.selectPage(pager, queryWrapper);
    }

    public TagCalculateSelect getTagCalculateSelectById(String id) {
        return tagCalculateSelectMapper.selectById(id);
    }

    public void deleteTagCalculateSelectById(String id) {
        tagCalculateSelectMapper.deleteById(id);
    }

    public Page<TagCalculateSelect> getTagCalculateSelectBycalIdTagId(String tagId,String calculateId, long page, long rows) {
        Page<TagCalculateSelect> pager = new Page<>(page,rows);
        QueryWrapper<TagCalculateSelect> queryWrapper = new QueryWrapper<>();

        if (StringUtils.isNotEmpty(calculateId)) {
            queryWrapper.eq("calculateId",calculateId);
        }
        if (StringUtils.isNotEmpty(tagId)) {
            queryWrapper.eq("tagId",tagId);
        }
        return tagCalculateSelectMapper.selectPage(pager, queryWrapper);
    }

    public void saveTagCalculateSelects(List<TagCalculateSelect> list) {
        for (TagCalculateSelect tagCalculateSelect : list) {
            tagCalculateSelectMapper.insert(tagCalculateSelect);
        }
    }
}
