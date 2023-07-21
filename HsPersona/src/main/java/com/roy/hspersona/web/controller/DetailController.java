package com.roy.hspersona.web.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.tag.entity.*;
import com.roy.hspersona.tag.service.*;
import com.roy.hspersona.util.DateUtil;
import com.roy.hspersona.web.entity.*;
import com.roy.hspersona.web.service.ElasticSearchService;
import com.roy.hspersona.web.service.FormatService;
import com.roy.hspersona.web.service.PersonService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.*;

/**
 * @author roy
 * @date 2021/12/15
 * @desc
 */
@Controller
@RequestMapping("/web/detail")
public class DetailController extends WebBaseController {
    @Resource
    private ElasticSearchService elasticSearchService;
    @Resource
    private PersonService personService;
    @Resource
    private TagVertexService tagVertexService;
    @Resource
    private TagEdgeService tagEdgeService;

    @RequestMapping("/getNodeById")
    public String getNodeById(String id, HttpSession session, Model model) throws IOException {
        // 获取客户名
        String accountId = this.getAccountSession(session).getAccountId();
        if (StringUtils.isEmpty(id)) {
            return "web/tmpNodeDetail";
        }
        BigDecimal score = new BigDecimal(0.0);
        // 根据id查找节点信息
        DataVO dataVO = null;
        try {
            dataVO = elasticSearchService.getNodeById(id);
        } catch (IOException e) {
            return "web/tmpNodeDetail";
        }
        NodeDetailVO nodeDetailVO = new NodeDetailVO();
        if (dataVO != null) {
            String source = dataVO.getSource();
            JSONObject sourceJson = JSONObject.parseObject(source);
            // 个人信息
            nodeDetailVO.setId(dataVO.getId());
            PersonVO personVO = personService.getPersonVOFromDataVO(dataVO);
            nodeDetailVO.setPerson(personVO);
            //基本信息
            PanelBaseInfo baseInfo = new PanelBaseInfo();
            baseInfo.setTitle("基础信息");
            String introduce = FormatService.getDescription(personVO, sourceJson);
            baseInfo.setIntroduce(introduce);
            baseInfo.setScore(0.00);
            nodeDetailVO.setBaseInfo(baseInfo);
            //组装标签信息
            PanelTagInfo tagInfo = new PanelTagInfo();
            tagInfo.setTitle("标签信息");
            tagInfo.setPanelTagInfoItems(sourceJson);
            nodeDetailVO.setTagInfo(tagInfo);
            //组装客户关系信息 PanelGraphInfo
            model.addAttribute("nodeDetailVO", JSON.toJSON(nodeDetailVO));
        }
        return "web/tmpNodeDetail";
    }

    @ResponseBody
    @RequestMapping("/getTagByRuleId")
    public Object getTagByRuleId(String ruleTagId) {
        if (StringUtils.isNotEmpty(ruleTagId)) {
            List<TagEdge> edgeList = tagEdgeService.getTagEdgeByParentId(ruleTagId);
            List<TagVertex> list = new ArrayList<>();
            for (TagEdge edge : edgeList) {
                list.add(tagVertexService.getTagVertexById(edge.getVertexBid()));
            }
            Map<String, Object> res = new HashMap<>();
            res.put("success", 1);
            res.put("rows", list);
            return res;
        } else {
            return this.outFailJson("传入的规则节点ID为空");
        }
    }
}
