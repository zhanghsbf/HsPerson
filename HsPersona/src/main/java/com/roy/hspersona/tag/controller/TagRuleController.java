package com.roy.hspersona.tag.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.system.service.SysDictionaryService;
import com.roy.hspersona.tag.entity.TagEdge;
import com.roy.hspersona.tag.entity.TagRule;
import com.roy.hspersona.tag.entity.TagVertex;
import com.roy.hspersona.tag.service.TagEdgeService;
import com.roy.hspersona.tag.service.TagRuleService;
import com.roy.hspersona.tag.service.TagVertexService;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/10
 * @desc
 */
@Controller
@RequestMapping("/tag/tagRule")
public class TagRuleController extends MngBaseController {
    @Resource
    private TagVertexService tagVertexService;
    @Resource
    private TagEdgeService tagEdgeService;
    @Resource
    private TagRuleService tagRuleService;
    @Resource
    private SysDictionaryService sysDictionaryService;

    @RequestMapping("/to")
    public String to(){
        return "tag/initCalculateRule";
    }

    @ResponseBody
    @RequestMapping("/load")
    public Object load(String tagId, HttpSession session) {
        Map<String,Object> res = new HashMap<>();
        res.put("total",0);
        res.put("rows",new JSONArray());
        if (StringUtils.isEmpty(tagId)) {
            return res;
        }
        TagVertex vertex = tagVertexService.getTagVertexById(tagId);
        if (vertex == null) {
            return res;
        }
        if (vertex.getType() == TagVertex.CATAGORY || vertex.getType() == TagVertex.CONCEPT) {
            return res;
        }
        // 因为只有规则节点(type=3)才有规则，当点击标签节点(type=4)时显示上级规则节点的规则
        String value = "";
        if (vertex.getType() == TagVertex.TAG) {
            value = vertex.getValue();
            List<TagEdge> edgeList = tagEdgeService.getTagEdgeByVertexId(vertex.getId(), 2, TagEdge.DADSON);
            if (edgeList.size() == 0) {
                return res;
            } else {
                vertex = tagVertexService.getTagVertexById(edgeList.get(0).getVertexAid());
            }
        }
        // 获取规则节点对应的规则
        TagRule tagRule = tagRuleService.getTagRuleByTagId(vertex.getId(), this.getUserSession(session).getUserId());
        if (tagRule == null) {
            return res;
        }
        // 获取该规则节点的所有子节点，放入到Map中，在JSON解析返回时使用
        List<TagEdge> childList = tagEdgeService.getTagEdgeByParentId(vertex.getId());
        Map<String, String> childMap = new HashMap<String, String>();
        childMap.put("0", "<font color=red>[过滤规则]</font>");
        for (TagEdge child : childList) {
            final TagVertex childVertexB = tagVertexService.getTagVertexById(child.getVertexBid());
            childMap.put(childVertexB.getValue(), childVertexB.getName());
        }

        JSONArray json = JSON.parseArray(tagRule.getRule());
        for (int i = 0, j = 0; i < json.size(); i++, j++) {
            // 当点击的是标签节点(type=4)时，只显示属于该标签节点的规则
            if (!"".equals(value) && !value.equals(json.getJSONObject(i).get("result"))) {
                json.remove(i--);
                continue;
            }
            json.getJSONObject(i).put("index", j);// 索引用于标识该条规则在JSON中的位置，方便删除时使用
            json.getJSONObject(i).put("tag", childMap.get(json.getJSONObject(i).get("result")));
        }
        res.put("total",json.size());
        res.put("rows",json);
        return res;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(@RequestParam(defaultValue = "-1")int index,String tagId,HttpSession session) {
        if (StringUtils.isEmpty(tagId)) {
            return this.outFailJson("被删除规则的所属标签为空！");
        }
        if (index < 0) {
            return this.outFailJson("被删除规则的数据索引参数不正确！");
        }
        TagVertex vertex = tagVertexService.getTagVertexById(tagId);
        if (vertex == null) {
            return this.outFailJson("被删除规则的所属标签ID不正确！");
        }
        // 因为只有规则节点(type=3)才有规则，当点击标签节点(type=4)时显示上级规则节点的规则
        if (vertex.getType() == TagVertex.TAG) {
            List<TagEdge> edgeList = tagEdgeService.getTagEdgeByVertexId(vertex.getId(), 2, TagEdge.DADSON);
            if (edgeList.size() == 0) {
                return this.outFailJson("被删除规则的所属标签ID不正确！");
            } else {
                vertex = tagVertexService.getTagVertexById(edgeList.get(0).getVertexAid());
            }
        }
        TagRule tagRule = tagRuleService.getTagRuleByTagId(vertex.getId(), this.getUserSession(session).getUserId());
        if (tagRule == null) {
            this.outFailJson("被删除规则的所属标签ID不正确！");
            return null;
        }
        JSONArray json = JSONArray.parseArray(tagRule.getRule());
        json.remove(index);
        tagRule.setRule(json.toString());
        if ("[]".equals(json.toString())) {
            tagRuleService.removeTagRule(tagRule);
        } else {
            tagRuleService.modifyTagRule(tagRule);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/deleteAll")
    public String deleteAll(String tagId,HttpSession session) {
        if (StringUtils.isEmpty(tagId)) {
            return this.outFailJson("被删除规则的所属标签为空！");
        }
        TagVertex vertex = tagVertexService.getTagVertexById(tagId);
        if (vertex == null) {
            return this.outFailJson("被删除规则的所属标签ID不正确！");
        }
        String result = "";
        // 因为只有规则节点(type=3)才有规则，当点击标签节点(type=4)时显示上级规则节点的规则
        if (vertex.getType() == TagVertex.TAG) {
            result = vertex.getValue();
            List<TagEdge> edgeList = tagEdgeService.getTagEdgeByVertexId(vertex.getId(), 2, TagEdge.DADSON);
            if (edgeList.size() == 0) {
                return this.outFailJson("被删除规则的所属标签ID不正确！");
            } else {
                vertex = tagVertexService.getTagVertexById(edgeList.get(0).getVertexAid());
            }
        }
        TagRule tagRule = tagRuleService.getTagRuleByTagId(vertex.getId(), this.getUserSession(session).getUserId());
        if (tagRule == null) {
            return this.outFailJson("被删除规则的所属标签ID不正确！");
        }
        JSONArray json = JSONArray.parseArray(tagRule.getRule());
        if(StringUtils.isEmpty(result)){
            json = new JSONArray();
        }else{
            for(int i=0;i<json.size();i++){
                if(json.getJSONObject(i).getString("result").equals(result)){
                    json.remove(i);
                    break;
                }
            }
        }
        tagRule.setRule(json.toString());
        if ("[]".equals(json.toString())) {
            tagRuleService.removeTagRule(tagRule);
        } else {
            tagRuleService.modifyTagRule(tagRule);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/add")
    public String add(String tagId, @RequestParam(defaultValue = "-1")int type,String sql,HttpSession session) {
        if (StringUtils.isEmpty(tagId)) {
            return this.outFailJson("所属标签为空！");
        }
        if (StringUtils.isEmpty(sql)) {
            return this.outFailJson("规则内容为空！");
        }
        Map<String, String> dictMap = sysDictionaryService.getMapByCode(ConstantDict.RULE_TYPE);
        if (dictMap.get(Integer.toString(type)) == null) {
            return this.outFailJson("规则类型不正确！");
        }
        TagVertex tagVertex = tagVertexService.getTagVertexById(tagId);
        if (tagVertex == null) {
            return this.outFailJson("传入的节点ID不正确！");
        }
        // result为规则返回结果，如果是对规则节点(type=3)添加，则返回0(过滤规则)
        // 如果是对标签节点(type=4)添加，则返回该标签节点对应的值
        String result = "";
        if (tagVertex.getType() == TagVertex.TAG) {
            result = tagVertex.getValue();
            List<TagEdge> edgeList = tagEdgeService.getTagEdgeByVertexId(tagVertex.getId(), 2, TagEdge.DADSON);
            if (edgeList.size() == 0) {
                return this.outFailJson("传入的节点ID不正确！");
            } else {
                tagVertex = tagVertexService.getTagVertexById(edgeList.get(0).getVertexAid());
            }
        } else {
            result = "0";
        }
        if (tagVertex.getType() == TagVertex.CATAGORY || tagVertex.getType() == TagVertex.CONCEPT) {
            return this.outFailJson("分类节点与概念节点不可以设置计算规则！");
        }
        SysUser user = new SysUser();
        user.setId(this.getUserSession(session).getUserId());
        TagRule tagRule = tagRuleService.getTagRuleByTagId(tagVertex.getId(), user.getId());
        sql = sql.replace("&gt;", ">").replace("&lt;", "<");
        if (tagRule == null) {
            tagRule = new TagRule();
            tagRule.setId(KeyUtil.getKey());
            tagRule.setRule("[{\"sql\":\"" + sql + "\",\"result\":\"" + result + "\"}]");
            tagRule.setTagId(tagVertex.getId());
            tagRule.setType(type);
            tagRule.setUserId(user.getId());
            tagRuleService.createTagRule(tagRule);
        } else {
            String content = "{\"sql\":\"" + sql + "\",\"result\":\"" + result + "\"}";
            JSONArray json = JSONArray.parseArray(tagRule.getRule());
            int intResult = Integer.parseInt(result);
            for (int i = 0; i < json.size(); i++) {
                String thisResult = json.getJSONObject(i).getString("result");
                int intThisResult = Integer.parseInt(thisResult);
                if (intThisResult == intResult) {// 如果是等于，则替换该位置并跳出
                    json.remove(i);
                    json.add(i, JSONObject.parseObject(content));
                    break;
                } else if (intThisResult > intResult) {// 如果大于，则放到该位置并将后面的挤后一位，然后跳出
                    json.add(i, JSONObject.parseObject(content));
                    break;
                }
                if (i == json.size() - 1) {// 如果能到最后说明一直还没找到比他大的或相等的。则添加到队尾
                    json.add(JSONObject.parseObject(content));
                }
            }
            tagRule.setRule(json.toString());
            tagRuleService.modifyTagRule(tagRule);
        }
        return this.outSuccessJson();
    }
}
