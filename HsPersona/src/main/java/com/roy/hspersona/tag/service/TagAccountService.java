package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagAccount;
import com.roy.hspersona.tag.mapper.TagAccountMapper;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/2
 * @desc
 */
@Service
public class TagAccountService {

    @Resource
    private TagAccountMapper tagAccountMapper;

    public TagAccount getTagAccountByAccount(String account) {
        QueryWrapper<TagAccount> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("account",account);
        final List<TagAccount> tagAccounts = tagAccountMapper.selectList(queryWrapper);
        if(null != tagAccounts && tagAccounts.size()>0){
            return tagAccounts.get(0);
        }
        return null;
    }

    public Page<TagAccount> getTagAccount(Map<String, Object> map, long page, long rows) {
        final Page<TagAccount> pager = new Page<>(page,rows);
        final QueryWrapper<TagAccount> queryWrapper = new QueryWrapper<>();

        if (StringUtils.isNotEmpty((String) map.get("account"))) {
            queryWrapper.like("account","%" + map.get("account") + "%");
        }
        if (StringUtils.isNotEmpty((String) map.get("ww_account"))) {
            queryWrapper.eq("account",map.get("ww_account"));
        }
        if (StringUtils.isNotEmpty((String) map.get("password"))) {
            queryWrapper.eq("password",map.get("password"));
        }
        if (StringUtils.isNotEmpty((String) map.get("userId"))) {
            queryWrapper.eq("userId",map.get("userId"));
        }
        return tagAccountMapper.selectPage(pager,queryWrapper);
    }

    public int deleteTagAccount(TagAccount tagAccount) {
        return tagAccountMapper.deleteById(tagAccount);
    }

    public void saveTagAccount(TagAccount tagAccount) {
        tagAccountMapper.insert(tagAccount);
    }

    public void updateTagAccount(TagAccount tagAccount) {
        tagAccountMapper.updateById(tagAccount);
    }
}
