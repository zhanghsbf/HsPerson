package com.roy.hspersona.tag.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.service.SysDictionaryService;
import com.roy.hspersona.tag.entity.*;
import com.roy.hspersona.tag.service.TagEdgeService;
import com.roy.hspersona.tag.service.TagVertexExpressService;
import com.roy.hspersona.tag.service.TagVertexService;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/9
 * @desc
 */
@Controller
@RequestMapping("/tag/tagNet")
public class TagNetController extends MngBaseController {
    @Resource
    private TagVertexService tagVertexService;
    @Resource
    private SysDictionaryService sysDictionaryService;
    @Resource
    private TagEdgeService tagEdgeService;
    @Resource
    private TagVertexExpressService tagVertexExpressService;

    @RequestMapping("/to")
    public String to(){
        return "tag/initTagTable";
    }

    @RequestMapping("/toNetTree")
    public String toNetTree(){
        return "tag/initTagGraph";
    }

    @RequestMapping("/toTagTree")
    public String toTagTree(){
        return "tag/initTagTree";
    }

    @ResponseBody
    @RequestMapping("/netTable")
    public Object netTable(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                           @RequestParam(defaultValue = "-1")int industryType, String name, @RequestParam(defaultValue = "-1")int type,
                           HttpSession session) {
        Map<String, Object> map = new HashMap<>();
        map.put("name", name);
        if (industryType > 0) {
            map.put("industryType", industryType);
        } else {
            String industryTypes = this.getUserSession(session).getIndustryTypes();
            if (StringUtils.isEmpty(industryTypes)) {
                map.put("industryTypes", "-1");
            } else {
                map.put("industryTypes", industryTypes);
            }
        }
        if (type > 0) {
            map.put("type", type);
        }
        Page<TagVertex> sr = tagVertexService.getTagVertex(map, page, rows);
        JSONArray jsonArray = new JSONArray();
        Map<String, String> industryTypeMap = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        Map<String, String> vertexTypeMap = sysDictionaryService.getMapByCode(ConstantDict.VERTEX_TYPE);

        for (TagVertex record : sr.getRecords()) {
            final JSONObject json = JSON.parseObject(JSON.toJSONString(record));
            int t = json.getInteger("type");
            int it = json.getInteger("industryType");
            String id = json.getString("id");
            json.put("typeName", vertexTypeMap.get(Integer.toString(t)));
            json.put("industryTypeName", industryTypeMap.get(Integer.toString(it)));
            List<TagEdge> list = tagEdgeService.getTagEdgeByVertexId(id, 0, 0);
            json.put("num", list.size());

            jsonArray.add(json);
        }
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/deleteVertex")
    public String deleteVertex(String id) {
        if (StringUtils.isNotEmpty(id)) {
            tagVertexService.removeVertexById(id);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的标签网系节点ID为空，不能被删除");
        }
    }

    @ResponseBody
    @RequestMapping("/netTree")
    public Object netTree(String id,@RequestParam(defaultValue = "0") int type,HttpSession session) {
        String parentId = id;
        /**
         * type==0表示带颜色显示,分类节点黑色，概念节点黑色加粗，规则节点蓝色加粗，标签节点绿色加粗<br>
         * type==1表示全部黑色显示<br>
         * type==2表示只显示到规则节点级，带颜色，并在规则节点后显示备注 type==3表示只显示到规则节点级，不带颜色，并在规则节点后显示备注
         */
        if (StringUtils.isEmpty(parentId)) {

            TagVertex topVertex = tagVertexService.takeTagVertexById(TreeNode.TOP_NODE_ID);
            TreeNode node = new TreeNode();
            node.setId(topVertex.getId());
            node.setText(topVertex.getName());
            node.setTmp(Integer.toString(TagVertex.CATAGORY));

            List<TreeNode> list = tagEdgeService.getTagNetTree(topVertex.getId(), type);
            String industrys = this.getUserSession(session).getIndustryTypes();
            String[] industryArray = {};
            if (StringUtils.isNotEmpty(industrys)) {
                industryArray = industrys.split(",");
            }
            for (int i = list.size() - 1; i >= 0; i--) {
                String nodeId = list.get(i).getId();
                TagVertex nodeVertex = tagVertexService.getTagVertexById(nodeId);
                boolean haved = false;
                for (int j = 0; j < industryArray.length; j++) {
                    if (industryArray[j].equals(Integer.toString(nodeVertex.getIndustryType()))) {
                        haved = true;
                        break;
                    }
                }
                if (!haved) {
                    list.remove(i);
                }
            }
            node.setChildren(list);
            List<TreeNode> res = new ArrayList<>();
            res.add(node);
            return res;
        } else {
            List<TreeNode> list = tagEdgeService.getTagNetTree(parentId, type);
           return list;
        }
    }

    @ResponseBody
    @RequestMapping("/getTagNetData")
    public Object getTagNetData(String id) {
        /*
         * 初始化数据
         */
        if (StringUtils.isEmpty(id)) {
            return this.outFailJson("传入的顶点ID为空");
        }
        String tagGraphDepth = ConstantParam.paramMap.get(ConstantParam.TAG_GRAPH_DEPTH);
        if (tagGraphDepth == null) {
            return this.outFailJson("请联系系统管理员设置标签图显示深度参数（" + ConstantParam.TAG_GRAPH_DEPTH + "）");
        }
        int graphDepth = 0, minDiameter = 15, maxDiameter = 30;
        /*
         * 判断数据合法性
         */
        try {
            graphDepth = Integer.parseInt(tagGraphDepth);
        } catch (Exception e) {
            return this.outFailJson("参数：标签图显示深度(" + ConstantParam.TAG_GRAPH_DEPTH + ")的值必须为整型");
        }
        if (graphDepth <= 0) {
            return this.outFailJson("参数：标签图显示深度(" + ConstantParam.TAG_GRAPH_DEPTH + ")的值必须大于等于0");
        }
        TagVertex tagVertex = tagVertexService.getTagVertexById(id);
        if (tagVertex == null) {
            return this.outFailJson("传入的顶点ID找不到对应的顶点数据");
        }
        /*
         * 构建顶点列表和边列表
         */
        List<TagGraphVertex> vertexList = new ArrayList<>();
        List<TagGraphEdge> edgeList = new ArrayList<>();
        TagGraphVertex firstVertex = new TagGraphVertex();
        firstVertex.setId(id);
        firstVertex.setName(tagVertex.getName());
        firstVertex.setGroup(tagVertex.getType());
        firstVertex.setDepth(0);
        vertexList.add(firstVertex);
        /*
         * 开始对顶点列表循环检查，循环检查过程中顶点列表也在增长
         */
        for (int i = 0; i < vertexList.size(); i++) {
            TagGraphVertex gVertex = vertexList.get(i);
            // 如果该顶点超过深度则不再寻找下去
            if (gVertex.getDepth() >= graphDepth) {
                continue;
            }
            // 没有超过深度，则寻找与之相关的所有边
            List<TagEdge> edgeTmpList = tagEdgeService.getTagEdgeByVertexId(gVertex.getId(), 0, 0);
            // 遍历所有边处理
            for (int j = 0; j < edgeTmpList.size(); j++) {
                TagEdge tagTmpEdge = edgeTmpList.get(j);
                // 从编数据中找到对方顶点
                TagVertex tagTmpVertex = tagVertexService.getTagVertexById(tagTmpEdge.getVertexAid());
                if (tagTmpVertex.getId().equals(gVertex.getId())) {
                    tagTmpVertex = tagVertexService.getTagVertexById(tagTmpEdge.getVertexBid());
                }
                // 寻找顶点列表中是否已经存在
                int vertexIndex = -1;
                for (int k = 0; k < vertexList.size(); k++) {
                    if (vertexList.get(k).getId().equals(tagTmpVertex.getId())) {
                        vertexIndex = k;
                        break;
                    }
                }
                // 如果顶点列表不存在则加入列表
                if (vertexIndex < 0) {
                    TagGraphVertex newVertex = new TagGraphVertex();
                    newVertex.setId(tagTmpVertex.getId());
                    newVertex.setName(tagTmpVertex.getName());
                    newVertex.setGroup(tagTmpVertex.getType());
                    newVertex.setDepth(gVertex.getDepth() + 1);
                    vertexList.add(newVertex);
                    vertexIndex = vertexList.size() - 1;
                }
                // 寻找边列表中是否已经存在
                int edgeIndex = -1;
                for (int k = 0; k < edgeList.size(); k++) {
                    if (edgeList.get(k).getId().equals(tagTmpEdge.getId())) {
                        edgeIndex = k;
                        break;
                    }
                }
                // 如果边列表中不存在则加入列表
                if (edgeIndex < 0) {
                    TagGraphEdge graphEdge = new TagGraphEdge();
                    graphEdge.setId(tagTmpEdge.getId());
                    graphEdge.setSource(i);
                    graphEdge.setTarget(vertexIndex);
                    graphEdge.setValue(tagTmpEdge.getType());
                    edgeList.add(graphEdge);
                }
            }
        }
        StringBuffer sb = new StringBuffer();
        sb.append("{\"nodes\":[");
        for (int i = 0; i < vertexList.size(); i++) {
            TagGraphVertex graphVertex = vertexList.get(i);
            String name = graphVertex.getName();
            int group = graphVertex.getGroup();
            int depth = graphVertex.getDepth();
            group = (maxDiameter - (maxDiameter - minDiameter) * depth / graphDepth) * 100 + group;
            sb.append("{\"name\":\"").append(name).append("\",\"group\":").append(group).append("}");
            if (i < vertexList.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("],\"links\":[");
        for (int i = 0; i < edgeList.size(); i++) {
            TagGraphEdge graphEdge = edgeList.get(i);
            int source = graphEdge.getSource();
            int target = graphEdge.getTarget();
            int value = graphEdge.getValue();
            sb.append("{\"source\":").append(source).append(",\"target\":").append(target).append(",\"value\":").append(value).append("}");
            if (i < edgeList.size() - 1) {
                sb.append(",");
            }
        }
        sb.append("]}");
//        System.out.println(sb.toString());
        return "{\"success\":1,\"data\":" + sb.toString() + "}";
    }
    @ResponseBody
    @RequestMapping("/loadVertex")
    public Object loadVertex(String id) {
        if (StringUtils.isNotEmpty(id)) {
            TagVertex tagVertex = tagVertexService.getTagVertexById(id);
            JSONObject json = JSON.parseObject(JSON.toJSONString(tagVertex));
            Map<String, String> map = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
            json.put("industryTypeStr", map.get(Integer.toString(tagVertex.getIndustryType())));
            return json;
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/saveVertex")
    public Object saveVertex(String parentId,String name ,String value,@RequestParam(defaultValue = "-1")int industryType,
                             @RequestParam(defaultValue = "-1")int type) {
        if (StringUtils.isEmpty(name)) {
            return this.outFailJson("节点名称不能为空");
        }
        if (type < 0) {
            return this.outFailJson("节点类型不正确");
        }
        if (StringUtils.isEmpty(parentId)) {
            return this.outFailJson("父节点ID不能为空");
        }
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.INDUSTRY_TYPE);
        if (dictMap.get(Integer.toString(industryType)) == null) {
            return this.outFailJson("传入的行业类型不正确");
        }
        if (TreeNode.TOP_NODE_ID.equals(parentId)) {
            Map<String, Object> map = new HashMap<>();
            map.put("industryType", industryType);
            List<TagVertex> resultList = tagVertexService.getTagVertex(map, 1, 1).getRecords();
            if (resultList.size() > 0) {
                return this.outFailJson("该行业类型标签体系已经存在，不能重复新增");
            }
        }
        Map<String,Object> params = new HashMap<>();
        params.put("name",name);
        List<TagVertex> resultList = tagVertexService.getTagVertex(params, 1, 1).getRecords();
        if (resultList.size() > 0) {
            return this.outFailJson("该名称的标签已经存在，不能重复定义");
        }
        TagVertex parentVertex = tagVertexService.getTagVertexById(parentId);
        if (parentVertex == null) {
            return this.outFailJson("父节点不存在");
        }
        if (parentVertex.getType() == TagVertex.TAG) {
            return this.outFailJson("父节点标签型节点，不允许有子节点");
        }
        if (parentVertex.getType() == TagVertex.RULE && type != TagVertex.TAG) {
            return this.outFailJson("父节点为规则型节点，子节点必须是标签型节点");
        }
        if (parentVertex.getType() == TagVertex.CONCEPT && type != TagVertex.RULE) {
            return this.outFailJson("父节点为概念型节点，子节点必须是规则型节点");
        }
        if (parentVertex.getType() == TagVertex.CATAGORY && type != TagVertex.CONCEPT && type != TagVertex.CATAGORY) {
            return this.outFailJson("父节点为类别型节点，子节点必须是类别型节点或概念型节点");
        }
        // 保存数据，并保存相关边数据
        TagVertex tagVertex = new TagVertex();
        tagVertex.setName(name);
        tagVertex.setEnable(1);
        tagVertex.setType(type);
        tagVertex.setValue(value);
        if (TreeNode.TOP_NODE_ID.equals(parentId)) {
            tagVertex.setIndustryType(industryType);
        } else {
            tagVertex.setIndustryType(parentVertex.getIndustryType());
        }
        String vertexId = tagVertexService.createDadSonVertex(tagVertex, parentId);
        Map<String ,Object> res = new HashMap<>();
        res.put("success",1);
        res.put("id",vertexId);
        return res;
    }

    @ResponseBody
    @RequestMapping("/updateVertex")
    public Object updateVertex(String id, String name ,@RequestParam(defaultValue = "-1")int type,String value) {
        if (StringUtils.isEmpty(name)) {
            return this.outFailJson("节点名称不能为空");
        }
        if (type < 0) {
            return this.outFailJson("节点类型不正确");
        }
        TagVertex thisVertex = tagVertexService.getTagVertexById(id);
        if (thisVertex == null) {
            return this.outFailJson("传入的节点ID对应的节点不存在");
        }
        List<TagEdge> tagEdgeList = tagEdgeService.getTagEdgeByVertexId(id, 2, TagEdge.DADSON);
        if (tagEdgeList.size() == 0) {
            return this.outFailJson("传入的节点ID找不到对应的父节点");
        }
        TagVertex parentVertex = tagVertexService.getTagVertexById(tagEdgeList.get(0).getVertexAid());
        if (parentVertex == null) {
            return this.outFailJson("父节点不存在");
        }
        if (parentVertex.getType() == TagVertex.TAG) {
            return this.outFailJson("父节点标签型节点，不允许有子节点");
        }
        if (parentVertex.getType() == TagVertex.RULE && type != TagVertex.TAG) {
            return this.outFailJson("父节点为规则型节点，子节点必须是标签型节点");
        }
        if (parentVertex.getType() == TagVertex.CONCEPT && type != TagVertex.RULE) {
            return this.outFailJson("父节点为概念型节点，子节点必须是规则型节点");
        }
        if (parentVertex.getType() == TagVertex.CATAGORY && type != TagVertex.CONCEPT && type != TagVertex.CATAGORY) {
            return this.outFailJson("父节点为类别型节点，子节点必须是类别型节点或概念型节点");
        }
        // 保存修改后的数据
        thisVertex.setName(name);
        thisVertex.setType(type);
        thisVertex.setValue(value);
        tagVertexService.modifyTagVertex(thisVertex);
        Map<String ,Object> res = new HashMap<>();
        res.put("success",1);
        res.put("id",id);
        return res;
    }

    @ResponseBody
    @RequestMapping("/banVertex")
    public String banVertex(String id) {
        if (StringUtils.isNotEmpty(id)) {
            TagVertex tagVertex = tagVertexService.getTagVertexById(id);
            if (tagVertex == null) {
                return this.outFailJson("传入ID对应的顶点不存在");
            } else {
                tagVertexService.completeTurnVertexEnable(id, (tagVertex.getEnable() + 1) % 2);
                return this.outSuccessJson();
            }
        } else {
            return this.outFailJson("传入的标签网系节点ID为空，不能被操作");
        }
    }

    @ResponseBody
    @RequestMapping("/initExpress")
    public Object initExpress(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                              @RequestParam(defaultValue = "@")String vertexId) {
        Page<TagVertexExpress> sr = tagVertexExpressService.getTagVertexExpress(vertexId, page, rows);
        JSONArray jsonArray = new JSONArray();
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.EXPRESS_TYPE);
        for (int i = 0; i < sr.getRecords().size(); i++) {
            TagVertexExpress tagVertexExpress = sr.getRecords().get(i);
            JSONObject json = JSON.parseObject(JSON.toJSONString(tagVertexExpress));
            if (dictMap.get(Integer.toString(tagVertexExpress.getType())) != null) {
                json.put("typeName", dictMap.get(Integer.toString(tagVertexExpress.getType())));
            }
            jsonArray.add(json);
        }
        Map<String ,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/deleteExpress")
    public String deleteExpress(String id) {
        if (StringUtils.isEmpty(id)) {
            return this.outFailJson("传入的标签表述ID为空");
        } else {
            tagVertexExpressService.deleteTagVertexExpressById(id);
            return this.outSuccessJson();
        }
    }

    @ResponseBody
    @RequestMapping("/saveExpress")
    public String saveExpress(String id, String vertexId,@RequestParam(defaultValue = "-1")int type,String express) {
        if (StringUtils.isEmpty(vertexId)) {
            return this.outFailJson("传入的所属标签ID不正确");
        }
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.EXPRESS_TYPE);
        if (!dictMap.containsKey(Integer.toString(type))) {
            return this.outFailJson("传入的表述类型不正确");
        }
        if (StringUtils.isEmpty(express)) {
            return this.outFailJson("标签表述为空");
        }
        if (StringUtils.isEmpty(id)) {
            TagVertexExpress tagVertexExpress = new TagVertexExpress();
            tagVertexExpress.setId(KeyUtil.getKey());
            tagVertexExpress.setVertexId(vertexId);
            tagVertexExpress.setType(type);
            tagVertexExpress.setExpress(express);
            tagVertexExpressService.saveTagVertexExpress(tagVertexExpress);
        } else {
            TagVertexExpress tagVertexExpress = tagVertexExpressService.getTagVertexExpressById(id);
            if (tagVertexExpress == null) {
                return this.outFailJson("传入的标签节点表述ID错误！");
            }
            // 所属标签不能修改，所以可以不设置
            tagVertexExpress.setType(type);
            tagVertexExpress.setExpress(express);
            tagVertexExpressService.updateTagVertexExpress(tagVertexExpress);
        }
        return this.outSuccessJson();
    }
}
