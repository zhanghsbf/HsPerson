package com.roy.hspersona.tag.service;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.tag.entity.TagEdge;
import com.roy.hspersona.tag.entity.TagVertex;
import com.roy.hspersona.tag.mapper.TagVertexMapper;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/9
 * @desc
 */
@Service
public class TagVertexService {

    @Resource
    private TagVertexMapper tagVertexMapper;
    @Resource
    private TagEdgeService tagEdgeService;
    @Resource
    private TagCalculateSelectService tagCalculateSelectService;

    public Page<TagVertex> getTagVertex(Map<String, Object> map, long page, long rows) {

        Page<TagVertex> pager = new Page<>(page,rows);
        QueryWrapper<TagVertex> queryWrapper = new QueryWrapper<>();

        // 第一个节点不查
        queryWrapper.ne("id","-1");
        if (StringUtils.isNotEmpty((String) map.get("id"))) {
            queryWrapper.eq("id",map.get("id"));
        }
        if (StringUtils.isNotEmpty((String) map.get("name"))) {
            queryWrapper.like("name","%" + map.get("name") + "%");
        }
        if (null != map.get("type")) {
            queryWrapper.eq("type",map.get("type"));
        }
        if (null != map.get("enable")) {
            queryWrapper.eq("enable",map.get("enable"));
        }
        if (null != map.get("industryType")) {
            queryWrapper.eq("industryType",map.get("industryType"));
        }
        if (StringUtils.isNotEmpty((String) map.get("industryTypes"))) {
            queryWrapper.in("industryType",map.get("industryTypes"));
        }
        if (StringUtils.isNotEmpty((String) map.get("value"))) {
            queryWrapper.like("value","%" + map.get("value") + "%");
        }
        return tagVertexMapper.selectPage(pager,queryWrapper);
    }

    public void removeVertexById(String id) {
        // 所有相关的边
        List<TagEdge> edgeList = tagEdgeService.getTagEdgeByVertexId(id, 0, 0);
        // 该节点为子节点的父子边
        List<TagEdge> parentEdgeList = tagEdgeService.getTagEdgeByVertexId(id, 2, TagEdge.DADSON);
        // 本节点的类型
        TagVertex thisVertex = this.getTagVertexById(id);
        int thisType = thisVertex.getType();
        // 父节点ID
        String parentId = (parentEdgeList.size() > 0) ? parentEdgeList.get(0).getVertexAid() : "";
        // 删除所有边
        tagEdgeService.deleteTagEdges(edgeList);
        // 删除该节点
        this.deleteTagVertexById(id);
        // 如果节点为标签节点，且父节点ID存在
        if (thisType == TagVertex.TAG && StringUtils.isNotEmpty(parentId)) {
            String tagContent = tagEdgeService.getChildrenStringByParentId(parentId);
            tagCalculateSelectService.updateContentByTagId(tagContent, parentId);
//            mlNaiveBayesClassifierService.updateContentByTagId(tagContent, parentId);
        }
    }

    private void deleteTagVertexById(String id) {
        tagVertexMapper.deleteById(id);
    }

    public TagVertex takeTagVertexById(String id) {
        TagVertex tagVertex = this.getTagVertexById(id);
        if (TreeNode.TOP_NODE_ID.equals(id) && tagVertex == null) {
            tagVertex = new TagVertex();
            tagVertex.setId(TreeNode.TOP_NODE_ID);
            tagVertex.setName("标签体系树");
            tagVertex.setType(TagVertex.CATAGORY);
            tagVertex.setEnable(1);
            this.saveTagVertex(tagVertex);
        }
        return tagVertex;
    }

    private void saveTagVertex(TagVertex tagVertex) {
        tagVertexMapper.insert(tagVertex);
    }

    public TagVertex getTagVertexById(String id) {
        return tagVertexMapper.selectById(id);
    }

    public String createDadSonVertex(TagVertex sonTagVertex, String parentId) {
        String id = KeyUtil.getKey();
        sonTagVertex.setId(id);
        this.saveTagVertex(sonTagVertex);
        TagEdge tagEdge = new TagEdge();
        tagEdge.setId(KeyUtil.getKey());
        tagEdge.setVertexAid(parentId);// 父节点放前面
        tagEdge.setVertexBid(sonTagVertex.getId());
        tagEdge.setType(TagEdge.DADSON);
        tagEdge.setEnable(1);
        tagEdgeService.saveTagEdge(tagEdge);
        if (sonTagVertex.getType() == TagVertex.TAG) {
            String tagContent = tagEdgeService.getChildrenStringByParentId(parentId);
            tagCalculateSelectService.updateContentByTagId(tagContent, parentId);
//            mlNaiveBayesClassifierService.updateContentByTagId(tagContent, parentId);
        }
        return id;
    }

    public void modifyTagVertex(TagVertex tagVertex) {
        this.updateTagVertex(tagVertex);
        // 获取父节点的边
        List<TagEdge> edgeList = tagEdgeService.getTagEdgeByVertexId(tagVertex.getId(), 2, TagEdge.DADSON);
        // 如果节点为标签节点，且父节点存在
        if (tagVertex.getType() == TagVertex.TAG && edgeList.size() > 0) {
            String parentId = edgeList.get(0).getVertexAid();
            String tagContent = tagEdgeService.getChildrenStringByParentId(parentId);
            tagCalculateSelectService.updateContentByTagId(tagContent, parentId);
//            mlNaiveBayesClassifierService.updateContentByTagId(tagContent, parentId);
        }
    }

    private void updateTagVertex(TagVertex tagVertex) {
        tagVertexMapper.updateById(tagVertex);
    }

    public void completeTurnVertexEnable(String id, int enable) {
        TagVertex tagVertex = this.getTagVertexById(id);
        tagVertex.setEnable(enable);
        this.updateTagVertex(tagVertex);
        List<TagEdge> edgeList = tagEdgeService.getTagEdgeByVertexId(id, 0, 0);
        for (int i = 0; i < edgeList.size(); i++) {
            TagEdge tagEdge = edgeList.get(i);
            tagEdge.setEnable(enable);
            edgeList.set(i, tagEdge);
        }
        tagEdgeService.saveOrUpdateTagEdges(edgeList);
    }

    public List<TagVertex> getTagVertexRandomByUserAndLikeTagName(String userId, String tagName) {
        return tagVertexMapper.getTagVertexRandomByUserAndLikeTagName(userId,tagName);

    }

    public JSONArray getTagVertextNameForTagTop(JSONArray tagTopAggrJsonArr) {
        // 标签top-10统计数据,不包含tagName,需要处理
        JSONArray tagNameCountJSONArr = new JSONArray();
        // 循环,通过ruleTagId 和index获取tagName
        for (int i = 0; i < tagTopAggrJsonArr.size(); i++) {
            JSONObject jsonObject = tagTopAggrJsonArr.getJSONObject(i);
            String ruleTagId = jsonObject.getString("ruleTagId");
            String tagIndex = jsonObject.getString("tagIndex");
            String docCount = jsonObject.getString("docCount");
            // 获取tagName
            String tagName = tagEdgeService.getChildrenNodeNameByRuleTagIdAndValue(ruleTagId, tagIndex);
            StringBuffer tagNameCountBuffer = new StringBuffer();
            tagNameCountBuffer.append("{\"tagName\":\"").append(tagName).append("\",\"count\":\"").append(docCount).append("\"}");
            JSONObject tagNameCountJSONObj = JSONObject.parseObject(tagNameCountBuffer.toString());
            tagNameCountJSONArr.add(tagNameCountJSONObj);
        }
        return tagNameCountJSONArr;
    }

    public List<TagVertex> getBrotherTagByTagName(String searchKey) {
        return tagVertexMapper.getBrotherTagByTagName(searchKey,TagVertex.TAG,1);
    }
}
