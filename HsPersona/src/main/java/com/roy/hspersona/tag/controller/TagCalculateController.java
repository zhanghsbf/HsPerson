package com.roy.hspersona.tag.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.system.service.SysPermissionService;
import com.roy.hspersona.system.service.SysUserService;
import com.roy.hspersona.tag.entity.*;
import com.roy.hspersona.tag.service.*;
import com.roy.hspersona.util.KeyUtil;
import com.roy.hspersona.util.SSHCommand;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/12
 * @desc
 */
@Controller
@RequestMapping("/tag/tagCalculate")
public class TagCalculateController extends MngBaseController {
    @Resource
    private SysPermissionService sysPermissionService;
    @Resource
    private TagCalculateService tagCalculateService;
    @Resource
    private SysUserService sysUserService;
    @Resource
    private TagCalculateSelectService tagCalculateSelectService;
    @Resource
    private TagEdgeService tagEdgeService;
    @Resource
    private TagVertexService tagVertexService;
    @Resource
    private TagRuleService tagRuleService;

    @RequestMapping("/to")
    public String to(){
        return "tag/initCalculate";
    }

    @RequestMapping("/toUserSelectTagPage")
    public String toUserSelectTagPage(Model model,String calculateId){
        model.addAttribute("calculateId",calculateId);
        return "tag/userSelectTag";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                       String name, String startTime, String endTime, HttpSession session) {
        String userId = this.getUserSession(session).getUserId();
        if (StringUtils.isNotEmpty(startTime)) {
            startTime = startTime + " 00:00:00";
        }
        if (StringUtils.isNotEmpty(endTime)) {
            endTime = endTime + " 23:59:59";
        }
        // permissionCode要么为空，要么="viewAllTagCalculate"
        // 如果permissionCode不为空且该用户拥有该权限编码表示该用户可以查看所有用户的的计算配置
        if (sysPermissionService.havePermisssion(userId, "viewAllTagCalculate")) {
            userId = null;
        }
        Map<String, Object> map = new HashMap<>();
        map.put("name", name);
        map.put("startTime", startTime);
        map.put("endTime", endTime);
        map.put("userId", userId);
        map.put("enable", "1");
        Page<TagCalculate> sr = tagCalculateService.getTagCalculate(map, page, rows);
        List<TagCalculate> list = sr.getRecords();
//        JSONArray json = JSONArray.fromObject(list, this.getJsonConfig());
        JSONArray jsonArray = new JSONArray();
        Map<String, String> userMap = new HashMap<>();
        for (int i = 0; i < list.size(); i++) {
            TagCalculate tagCalculate = list.get(i);
            JSONObject json = JSON.parseObject(JSON.toJSONString(tagCalculate));
            if (userMap.get(tagCalculate.getUserId()) != null) {
                json.put("userName", userMap.get(tagCalculate.getUserId()));
            } else {
                SysUser user = sysUserService.getUserById(tagCalculate.getUserId());
                if (user != null) {
                    json.put("userName", user.getRealName());
                    userMap.put(user.getId(), user.getRealName());
                }
            }
            jsonArray.add(json);
        }
        Map<String ,Object> res =new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(String id , String name,String dataPath,HttpSession session) {
        if (StringUtils.isEmpty(name)) {
            return this.outFailJson("计算主题不能为空");
        }
        if (StringUtils.isEmpty(id)) {
            TagCalculate tagCalculate = new TagCalculate();
            tagCalculate.setId(KeyUtil.getKey());
            tagCalculate.setCreateDate(LocalDateTime.now());
            tagCalculate.setName(name);
            tagCalculate.setDataPath(dataPath);
            tagCalculate.setUserId(this.getUserSession(session).getUserId());
            tagCalculate.setUserName(this.getUserSession(session).getUserName());
            tagCalculate.setEnable("1");
            tagCalculateService.saveTagCalculate(tagCalculate);
        } else {
            TagCalculate tagCalculate = tagCalculateService.getTagCalculateById(id);
            if (tagCalculate == null) {
                return this.outFailJson("传入的计算配置ID不正确");
            }
            tagCalculate.setName(name);
            tagCalculate.setDataPath(dataPath);
            tagCalculate.setCreateDate(LocalDateTime.now());
            tagCalculateService.updateTagCalculate(tagCalculate);
        }
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/start")
    public String start(String calculateId, String runDate,HttpSession session) {
        if (StringUtils.isEmpty(calculateId)) {
            return this.outFailJson("传入的计算配置ID为空");
        }
        TagCalculate tagCalculate = tagCalculateService.getTagCalculateById(calculateId);
        if (tagCalculate == null) {
            return this.outFailJson("传入的计算配置ID错误");
        }
        runDate = StringUtils.isEmpty(runDate)?"/":runDate;
        String param = calculateId + " "+ tagCalculate.getName() + " " + runDate;
        SSHCommand.submitToCalculateEngine(session,SSHCommand.SESSIONID_CALCULATE,SSHCommand.ENTRY_CALCULATE_AUTO, param);
        //SSHCommand.submitToCalculateEngine(this.getSession(), SSHCommand.SESSIONID_CALCULATE, SSHCommand.ENTRY_CALCULATE, param);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/showCalculateLogs")
    public String showCalculateLogs(HttpSession session) {
        String logs = (String) session.getAttribute(SSHCommand.SESSIONID_CALCULATE);
        if (logs != null) {
            session.setAttribute(SSHCommand.SESSIONID_CALCULATE, null);
            return logs;
        } else {
            return "";
        }
    }

    @ResponseBody
    @RequestMapping("/initSelect")
    public Object initSelect(@RequestParam(defaultValue = "1")long page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)long rows,
                             @RequestParam(defaultValue = "@")String calculateId) {
        Map<String, Object> map = new HashMap<>();
        map.put("calculateId", calculateId);
        Page<TagCalculateSelect> sr = tagCalculateSelectService.getTagCalculateSelectBycalId(calculateId, page, rows);
        List<TagCalculateSelect> list = sr.getRecords();
        JSONArray jsonArray = new JSONArray();
        // 补充父节点和子节点
        for (int i = 0; i < list.size(); i++) {
            TagCalculateSelect tagCalculateSelect = list.get(i);
            JSONObject json = JSON.parseObject(JSON.toJSONString(tagCalculateSelect));
            TagVertex tagVertex = tagVertexService.getTagVertexById(tagCalculateSelect.getTagId());
            json.put("vertexName",tagVertex.getName());
            // 查询父节点并put入json中
            List<TagEdge> parentEdgeList = tagEdgeService.getTagEdgeByVertexId(tagCalculateSelect.getTagId(), 2, TagEdge.DADSON);
            if (parentEdgeList.size() > 0) {
                String parentId = parentEdgeList.get(0).getVertexAid();
                TagVertex parentTagVertex = tagVertexService.getTagVertexById(parentId);
                json.put("parentName", parentTagVertex.getName());
            }
            jsonArray.add(json);
        }
        Map<String,Object> res=  new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",jsonArray);
        return res;
    }

    @ResponseBody
    @RequestMapping("/deleteSelect")
    public String deleteSelect(String id, HttpSession session) {
        if (StringUtils.isEmpty(id)) {
            return this.outFailJson("传入的用户已选择标签ID为空");
        }
        TagCalculateSelect tagCalculateSelect = tagCalculateSelectService.getTagCalculateSelectById(id);
        if (tagCalculateSelect == null) {
            return this.outFailJson("传入的用户已选择标签ID错误");
        }
        if (StringUtils.isNotEmpty(id)) {
            tagCalculateSelectService.deleteTagCalculateSelectById(id);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的用户已选择标签ID为空,不能删除");
        }
    }

    @ResponseBody
    @RequestMapping("/saveSelect")
    public String saveSelect(String tagIds, String calculateId,HttpSession session) {
        if (StringUtils.isEmpty(tagIds)) {
            return this.outFailJson("选择的标签为空！");
        }
        if (StringUtils.isEmpty(calculateId)) {
            return this.outFailJson("所属计算配置记录ID为空");
        }
        TagCalculate tagCalculate = tagCalculateService.getTagCalculateById(calculateId);
        if (tagCalculate == null) {
            return this.outFailJson("传入的算配置记录ID错误");
        }
        List<TagCalculateSelect> list = new ArrayList<>();
        String[] tagId = tagIds.split(",");
        Map<String, Object> map = new HashMap<>();
        map.put("userId", this.getUserSession(session).getUserId());
        for (int i = 0; i < tagId.length; i++) {
            TagVertex tagVertex = tagVertexService.getTagVertexById(tagId[i]);
            if (tagVertex == null) {
                return this.outFailJson("选中的标签中存在无效标签(ID=" + tagId[i] + ")!");
            }
            // 只有规则节点才添加
            if (tagVertex.getType() == TagVertex.RULE) {
                map.put("tagId", tagId[i]);
                map.put("calculateId", calculateId);
                Page<TagCalculateSelect> sr = tagCalculateSelectService.getTagCalculateSelectBycalIdTagId(tagId[i],calculateId, 1, 1);
                // 只有该配置没有该节点的时候才加入
                if (sr.getTotal() == 0) {
                    TagCalculateSelect tagCalculateSelect = new TagCalculateSelect();
                    tagCalculateSelect.setId(KeyUtil.getKey());
                    tagCalculateSelect.setTagId(tagVertex.getId());
                    tagCalculateSelect.setCalculateId(tagCalculate.getId());
                    // 获取规则节点对应的规则并填入
                    TagRule tagRule = tagRuleService.getTagRuleByTagId(tagId[i], this.getUserSession(session).getUserId());
                    if (tagRule != null) {
                        tagCalculateSelect.setRule(tagRule.getRule());
                    }else{
                        return this.outFailJson("选中的标签中存在没有计算规则的标签!");
                    }
                    try{
                        JSONArray.parseArray(tagRule.getRule());
                    }catch(Exception e){
                        return this.outFailJson("选中的标签中存在标签规则不是正确的规则的问题!");
                    }
                    tagCalculateSelect.setTagContent(tagEdgeService.getChildrenStringByParentId(tagId[i]));
                    list.add(tagCalculateSelect);
                }
            }
        }
        tagCalculateSelectService.saveTagCalculateSelects(list);
        return this.outSuccessJson();
    }
}
