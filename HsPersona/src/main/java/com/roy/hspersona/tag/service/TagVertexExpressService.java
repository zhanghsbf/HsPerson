package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagVertexExpress;
import com.roy.hspersona.tag.mapper.TagVertexExpressMapper;
import com.roy.hspersona.tag.mapper.TagVertexMapper;
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
public class TagVertexExpressService {
    @Resource
    private TagVertexExpressMapper tagVertexExpressMapper;

    public Page<TagVertexExpress> getTagVertexExpress(String vertexId, long page, long rows) {
        Page<TagVertexExpress> pager = new Page<>(page,rows);
        QueryWrapper<TagVertexExpress> queryWrapper = new QueryWrapper<>();

        if(StringUtils.isNotEmpty(vertexId)){
            queryWrapper.eq("vertexId",vertexId);
        }
        return tagVertexExpressMapper.selectPage(pager, queryWrapper);
    }

    public void deleteTagVertexExpressById(String id) {
        tagVertexExpressMapper.deleteById(id);
    }

    public void saveTagVertexExpress(TagVertexExpress tagVertexExpress) {
        tagVertexExpressMapper.insert(tagVertexExpress);
    }

    public TagVertexExpress getTagVertexExpressById(String id) {
        return tagVertexExpressMapper.selectById(id);
    }

    public void updateTagVertexExpress(TagVertexExpress tagVertexExpress) {
        tagVertexExpressMapper.updateById(tagVertexExpress);
    }
}
