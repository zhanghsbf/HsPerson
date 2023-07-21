package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagCalculate;
import com.roy.hspersona.tag.mapper.TagCalculateMapper;
import com.roy.hspersona.util.DateUtil;
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
public class TagCalculateService {

    @Resource
    private TagCalculateMapper tagCalculateMapper;

    public TagCalculate getTagCalculateById(String id){
        return tagCalculateMapper.selectById(id);
    }

    public Page<TagCalculate> getTagCalculate(Map<String, Object> map, long page, long rows) {
        Page<TagCalculate> pager = new Page<>(page,rows);
        QueryWrapper<TagCalculate> queryWrapper = new QueryWrapper<>();

        if (StringUtils.isNotEmpty((String) map.get("name"))) {
            queryWrapper.like("name","%" + map.get("name") + "%");
        }
        if (StringUtils.isNotEmpty((String) map.get("userId"))) {
            queryWrapper.eq("userId",map.get("userId"));
        }
        if (StringUtils.isNotEmpty((String) map.get("enable"))) {
            queryWrapper.eq("enable",map.get("enable"));
        }
        if (StringUtils.isNotEmpty((String) map.get("userName"))) {
            queryWrapper.like("userName","%"+map.get("userName")+"%");
        }
        if (StringUtils.isNotEmpty((String) map.get("startTime"))) {
            queryWrapper.ge("createDate",DateUtil.toDate((String)map.get("startTime"), "yyyy-MM-dd HH:mm:ss"));
        }
        if (StringUtils.isNotEmpty((String) map.get("endTime"))) {
            queryWrapper.le("endTime",DateUtil.toDate((String)map.get("endTime"), "yyyy-MM-dd HH:mm:ss"));
        }
        queryWrapper.orderByDesc("createDate");
        return tagCalculateMapper.selectPage(pager,queryWrapper);
    }

    public void saveTagCalculate(TagCalculate tagCalculate) {
        tagCalculateMapper.insert(tagCalculate);
    }

    public void updateTagCalculate(TagCalculate tagCalculate) {
        tagCalculateMapper.updateById(tagCalculate);
    }
}
