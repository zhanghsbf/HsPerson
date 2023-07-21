package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagCalculateSelect;
import com.roy.hspersona.tag.entity.TagRule;
import com.roy.hspersona.tag.mapper.TagRuleMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/10
 * @desc
 */
@Service
public class TagRuleService {

    @Resource
    private TagRuleMapper tagRuleMapper;
    @Resource
    private TagCalculateSelectService tagCalculateSelectService;

    public TagRule getTagRuleByTagId(String tagId, String userId) {
        Map<String, Object> map = new HashMap<>();
        map.put("tagId", tagId);
        map.put("userId", userId);
        List<TagRule> list = this.getTagRule(map, 1).getRecords();
        return list.size() > 0 ? list.get(0) : null;
    }

    private Page<TagRule> getTagRule(Map<String, Object> map, long limit) {
        Page<TagRule> pager = new Page<>(1,limit);
        QueryWrapper<TagRule> queryWrapper = new QueryWrapper<>();

        if (StringUtils.isNotEmpty((String) map.get("tagId"))) {
            queryWrapper.eq("tagId",map.get("tagId"));
        }
        if (StringUtils.isNotEmpty((String) map.get("userId"))) {
            queryWrapper.eq("userId",map.get("userId"));
        }
        return tagRuleMapper.selectPage(pager,queryWrapper);
    }

    public void removeTagRule(TagRule tagRule) {
        tagCalculateSelectService.deleteRuleByTagId(tagRule.getTagId(), tagRule.getUserId());
        Map<String,Object> map = new HashMap<>();
        map.put("tagId", tagRule.getTagId());
        map.put("userId", tagRule.getUserId());
        List<TagCalculateSelect> searchResult = tagCalculateSelectService.getTagCalculateSelect(map, 1, 9999);
        for(TagCalculateSelect tagCalculateSelect:searchResult){
            tagCalculateSelectService.deleteTagCalculateSelect(tagCalculateSelect);
        }
        this.deleteTagRule(tagRule);
    }

    private void deleteTagRule(TagRule tagRule) {
        tagRuleMapper.deleteById(tagRule);
    }

    public void modifyTagRule(TagRule tagRule) {
        this.updateTagRule(tagRule);
        Map<String,Object> map = new HashMap<>();
        map.put("tagId", tagRule.getTagId());
        map.put("userId",  tagRule.getUserId());
        List<TagCalculateSelect> searchResult = tagCalculateSelectService.getTagCalculateSelect(map, 1, 9999);
        for(TagCalculateSelect tagCalculateSelect : searchResult){
            tagCalculateSelect.setRule(tagRule.getRule());
            tagCalculateSelectService.updateTagCalculateSelect(tagCalculateSelect);
        }
    }

    private void updateTagRule(TagRule tagRule) {
        tagRuleMapper.updateById(tagRule);
    }

    public void createTagRule(TagRule tagRule) {
        this.saveTagRule(tagRule);
        Map<String,Object> map = new HashMap<>();
        map.put("tagId", tagRule.getTagId());
        map.put("userId",  tagRule.getUserId());
        List<TagCalculateSelect> searchResult = tagCalculateSelectService.getTagCalculateSelect(map, 1, 9999);
        for(TagCalculateSelect tagCalculateSelect : searchResult){
            tagCalculateSelect.setRule(tagRule.getRule());
            tagCalculateSelectService.updateTagCalculateSelect(tagCalculateSelect);
        }
    }

    private void saveTagRule(TagRule tagRule) {
        tagRuleMapper.insert(tagRule);
    }
}
