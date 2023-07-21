package com.roy.hspersona.tag.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.tag.entity.TagEdge;
import com.roy.hspersona.tag.entity.TagVertex;
import com.roy.hspersona.tag.mapper.TagEdgeMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/9
 * @desc
 */
@Service
public class TagEdgeService {

    @Resource
    private TagEdgeMapper tagEdgeMapper;
    @Resource
    private TagVertexService tagVertexService;

    public List<TagEdge> getTagEdgeByVertexId(String vertexId, int abType, int edgeType) {
        QueryWrapper<TagEdge> queryWrapper = new QueryWrapper<>();

        if (abType == 0) {
            queryWrapper.eq("vertexAid",vertexId).or().eq("vertexBid",vertexId);
        }
        if (abType == 1) {
            queryWrapper.eq("vertexAid",vertexId);
        }
        if (abType == 2) {
            queryWrapper.eq("vertexBid",vertexId);
        }
        if (edgeType != 0) {
            queryWrapper.eq("type",edgeType);
        }
        return tagEdgeMapper.selectList(queryWrapper);
    }

    public List<TreeNode> getTagNetTree(String parentId, int type) {
        List<TagEdge> list = this.getTagEdgeByParentId(parentId);
        List<TreeNode> nodeList = new ArrayList<TreeNode>();
        StringBuffer sb = new StringBuffer();
        for (TagEdge tagEdge : list) {
            TreeNode node = new TreeNode();
            TagVertex vertexB = tagVertexService.getTagVertexById(tagEdge.getVertexBid());
            node.setId(vertexB.getId());
            if (type == 0) {
                node.setText(vertexB.getNameHtml());
                if (vertexB.getType() != TagVertex.TAG) {
                    node.setState("closed");
                }
            } else if (type == 1) {
                node.setText(vertexB.getName());
                if (vertexB.getType() != TagVertex.TAG) {
                    node.setState("closed");
                }
            } else if (type == 2) {
                if (vertexB.getType() != TagVertex.RULE) {
                    node.setText(vertexB.getNameHtml());
                    node.setState("closed");
                } else {
                    sb.setLength(0);
                    sb.append(vertexB.getNameHtml()).append("：");
                    sb.append(this.getChildrenStringByParentId(vertexB.getId()));
                    node.setText(sb.toString());
                }
            } else if (type == 3) {
                if (vertexB.getType() != TagVertex.RULE) {
                    node.setText(vertexB.getName());
                    node.setState("closed");
                } else {
                    sb.setLength(0);
                    sb.append(vertexB.getName()).append("：");
                    sb.append(this.getChildrenStringByParentId(vertexB.getId()));
                    node.setText(sb.toString());
                }
            }
            node.setTmp(Integer.toString(vertexB.getType()));
            nodeList.add(node);
        }
        return nodeList;
    }

    public String getChildrenStringByParentId(String parentId) {
        List<TagEdge> list = this.getTagEdgeByParentId(parentId);
        StringBuffer sb = new StringBuffer();
        for (TagEdge tagEdge : list) {
            TagVertex vb = tagVertexService.getTagVertexById(tagEdge.getVertexBid());
            sb.append(",").append(vb.getValue()).append(":").append(vb.getName());
        }
        return sb.length() > 0 ? sb.toString().substring(1) : "";
    }

    public List<TagEdge> getTagEdgeByParentId(String parentId) {
        return this.getTagEdgeByVertexId(parentId,1,TagEdge.DADSON);
    }

    public void deleteTagEdges(List<TagEdge> edgeList) {
        for (TagEdge tagEdge : edgeList) {
            tagEdgeMapper.deleteById(tagEdge);
        }
    }

    public void saveTagEdge(TagEdge tagEdge) {
        tagEdgeMapper.insert(tagEdge);
    }

    public void saveOrUpdateTagEdges(List<TagEdge> edgeList) {
        for (TagEdge tagEdge : edgeList) {
            if(tagEdgeMapper.updateById(tagEdge)<1){
                tagEdgeMapper.insert(tagEdge);
            }
        }
    }

    public String getChildrenNodeNameByRuleTagIdAndValue(String ruleTagId, String value) {
        List<TagEdge> list = this.getTagEdgeByParentId(ruleTagId);
        for (TagEdge edge : list) {
            TagVertex vertex = tagVertexService.getTagVertexById(edge.getVertexBid());
            if (vertex != null && vertex.getValue().equals(value)) {
                return vertex.getName();
            }
        }
        return "";
    }
}
