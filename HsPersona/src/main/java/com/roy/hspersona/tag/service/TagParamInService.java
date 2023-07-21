package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.tag.entity.TagParamIn;
import com.roy.hspersona.tag.mapper.TagParamInMapper;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/10
 * @desc
 */
@Service
public class TagParamInService {

    @Resource
    private TagParamInMapper tagParamInMapper;

    public Page<TagParamIn> getTagParamIn(Map<String, Object> map, long limit) {

        Page<TagParamIn> pager = new Page<>(1,limit);
        QueryWrapper<TagParamIn> queryWrapper = new QueryWrapper<>();
        if (StringUtils.isNotEmpty((String) map.get("tagId"))) {
            queryWrapper.eq("tagId",map.get("tagId"));
        }
        if (StringUtils.isNotEmpty((String) map.get("parentId"))) {
            queryWrapper.eq("parentId",map.get("parentId"));
        }
        if (StringUtils.isNotEmpty((String) map.get("fieldId"))) {
            queryWrapper.eq("fieldId",map.get("fieldId"));
        }
        if (StringUtils.isNotEmpty((String) map.get("treeCode"))) {
            queryWrapper.like("treeCOde",map.get("treeCode") + "%");
        }
        if (StringUtils.isNotEmpty((String) map.get("userId"))) {
            queryWrapper.eq("userId",map.get("userId"));
        }
        queryWrapper.orderByAsc("treeCode");
        return tagParamInMapper.selectPage(pager,queryWrapper);
    }

    public TagParamIn getTagParamInBy(String tagId, String fieldId, String parentId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("tagId", tagId);
        map.put("fieldId", fieldId);
        map.put("parentId", parentId);
        List<TagParamIn> list = this.getTagParamIn(map, 1).getRecords();
        return list.size() > 0 ? list.get(0) : null;
    }

    public Integer getMaxTreeCode(String parentId) {
        List<TagParamIn> list = this.getTagParamInByParentId(parentId);
        if (list.size() == 0) {
            return 0;
        } else {
            TagParamIn tagParamIn = list.get(list.size() - 1);
            int len = tagParamIn.getTreeCode().length();
            String thisTreeCode = tagParamIn.getTreeCode().substring(len - TreeNode.CODE_LEN, len);
            try {
                return Integer.parseInt(thisTreeCode);
            } catch (Exception e) {
                return 0;
            }
        }
    }

    private List<TagParamIn> getTagParamInByParentId(String parentId) {
        QueryWrapper<TagParamIn> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("parentId",parentId);
        queryWrapper.orderByAsc("treeCode");
        return tagParamInMapper.selectList(queryWrapper);
    }

    public void saveTagParamIns(List<TagParamIn> paramInList) {
        for (TagParamIn tagParamIn : paramInList) {
            if(tagParamInMapper.updateById(tagParamIn)<1){
                tagParamInMapper.insert(tagParamIn);
            }
        }
    }

    public TagParamIn getTagParamInById(String id) {
        return tagParamInMapper.selectById(id);
    }

    public String removeTagParamInById(String id) {
        TagParamIn tagParamIn = this.getTagParamInById(id);
        if (tagParamIn == null) {
            return "传入的需要删除的入参ID不正确";
        }
        // 删除自己及子孙节点
        this.deleteTagParamInByTreeCode(tagParamIn.getTreeCode(), tagParamIn.getUserId());
        // 检查父祖辈是否子节点个数为0，为0的删除
        TagParamIn parentTagParamIn = this.getTagParamInById(tagParamIn.getParentId());
        while (parentTagParamIn != null) {
            List<TagParamIn> inList = this.getTagParamInByParentId(parentTagParamIn.getId());
            if (inList.size() > 0) {
                break;
            } else {
                String parentId = parentTagParamIn.getParentId();
                this.deleteTagParamIn(parentTagParamIn);
                parentTagParamIn = this.getTagParamInById(parentId);
            }
        }
        return "";
    }

    private void deleteTagParamIn(TagParamIn parentTagParamIn) {
        tagParamInMapper.deleteById(parentTagParamIn.getId());
    }

    private void deleteTagParamInByTreeCode(String treeCode, String userId) {
        UpdateWrapper<TagParamIn> updateWrapper = new UpdateWrapper<>();
        updateWrapper.like("treeCode",treeCode+"%");
        updateWrapper.eq("userId",userId);
        tagParamInMapper.delete(updateWrapper);
    }

    public List<TagParamIn> getTagParamInByTagId(String tagId, String userId) {
        QueryWrapper<TagParamIn> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("tagId",tagId);
        queryWrapper.eq("userId",userId);
        return tagParamInMapper.selectList(queryWrapper);
    }

    public void deleteTagParamIns(List<TagParamIn> list) {
        for (TagParamIn tagParamIn : list) {
            tagParamInMapper.deleteById(tagParamIn);
        }
    }
}
