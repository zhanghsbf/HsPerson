package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagExtTypeFieldExpress;
import com.roy.hspersona.tag.mapper.TagExtTypeFieldExpressMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/8
 * @desc
 */
@Service
public class TagExtTypeFieldExpressService {

    @Resource
    private TagExtTypeFieldExpressMapper tagExtTypeFieldExpressMapper;

    public void deleteTagExtTypeFieldExpressByIndustryValue(int industryValue) {
        UpdateWrapper<TagExtTypeFieldExpress> updateWrapper = new UpdateWrapper<>();
        updateWrapper.eq("industryType",industryValue);
        tagExtTypeFieldExpressMapper.delete(updateWrapper);
    }

    public List<TagExtTypeFieldExpress> getTagExtTypeFieldExpressByExttypeId(String id) {
        QueryWrapper<TagExtTypeFieldExpress> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("extTypeFieldId",id);
        return tagExtTypeFieldExpressMapper.selectList(queryWrapper);
    }

    public void deleteTagExtTypeFieldExpresses(List<TagExtTypeFieldExpress> expressList) {
        for (TagExtTypeFieldExpress tagExtTypeFieldExpress : expressList) {
            tagExtTypeFieldExpressMapper.deleteById(tagExtTypeFieldExpress);
        }
    }

    public Page<TagExtTypeFieldExpress> getPageTagExtTypeFieldExpressByFieldId(String fieldId, long page, long rows) {
        Page<TagExtTypeFieldExpress> pager = new Page<>(page,rows);
        QueryWrapper<TagExtTypeFieldExpress> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("extTypeFieldId",fieldId);
        return tagExtTypeFieldExpressMapper.selectPage(pager,queryWrapper);
    }

    public void deleteTagExtTypeFieldExpressById(String id) {
        tagExtTypeFieldExpressMapper.deleteById(id);
    }

    public void saveTagExtTypeFieldExpress(TagExtTypeFieldExpress tagExtTypeFieldExpress) {
        tagExtTypeFieldExpressMapper.insert(tagExtTypeFieldExpress);
    }

    public TagExtTypeFieldExpress getTagExtTypeFieldExpressById(String id) {
        return tagExtTypeFieldExpressMapper.selectById(id);
    }

    public void updateTagExtTypeFieldExpress(TagExtTypeFieldExpress tagExtTypeFieldExpress) {
        tagExtTypeFieldExpressMapper.updateById(tagExtTypeFieldExpress);
    }

    public void saveTagExtTypeFieldExpresses(List<TagExtTypeFieldExpress> extExpressList) {
        for (TagExtTypeFieldExpress tagExtTypeFieldExpress : extExpressList) {
            tagExtTypeFieldExpressMapper.insert(tagExtTypeFieldExpress);
        }
    }
}
