package com.roy.hspersona.system.controller;

import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.entity.SysOrg;
import com.roy.hspersona.system.entity.SysOrgExt;
import com.roy.hspersona.system.service.SysOrgService;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/3
 * @desc
 */
@Controller
@RequestMapping("/system/org")
public class SysOrgController extends MngBaseController {

    @Resource
    private SysOrgService sysOrgService;

    @RequestMapping("/to")
    public String to(){
        return "system/initOrg";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init() {
        SysOrgExt orgExt = sysOrgService.genOrgTreeGridNode();
        List<SysOrgExt> res = new ArrayList<>();
        res.add(orgExt);
        return res;
    }

    @ResponseBody
    @RequestMapping("/getChild")
    public Object getChild(String orgId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("parentId", orgId);
        List<SysOrg> list = sysOrgService.getOrg(map);
        Map<String,Object> res = new HashMap<>();
        res.put("total",list.size());
        res.put("rows",list);
        return res;
    }
    //TODO 值没传进来 2021.12.03
    @ResponseBody
    @RequestMapping("/save")
    public String save(SysOrg sysOrg) {
        if (StringUtils.isEmpty(sysOrg.getName())) {
            return this.outFailJson("机构名称为空！");
        }
        if (StringUtils.isEmpty(sysOrg.getParentId())) {
            return this.outFailJson("父节点ID为空！");
        }

        if (StringUtils.isEmpty(sysOrg.getId())) {
            sysOrg.setId(KeyUtil.getKey());
            sysOrg.setLeaf(1);
            sysOrg.setTreeCode(sysOrgService.genTreeCode(sysOrg.getParentId()));
            sysOrgService.saveSysOrg(sysOrg);
            return this.outSuccessJson();
        } else {
            SysOrg org = sysOrgService.getOrgById(sysOrg.getId());
            if (org == null) {
                return this.outFailJson("传入的机构ID错误");
            }
            org.setName(sysOrg.getName());
            org.setType(sysOrg.getType());
            sysOrgService.updateOrg(org);
            return this.outSuccessJson();
        }
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object edit(String id) {
        if (StringUtils.isNotEmpty(id)) {
            return sysOrgService.getOrgById(id);
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/cancel")
    public String cancel(String orgId) {
        if (StringUtils.isNotEmpty(orgId)) {
            SysOrg org = sysOrgService.getOrgById(orgId);
            sysOrgService.changeStatus(org);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的状态改变机构ID为空");
        }
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String orgId) {
        if (StringUtils.isNotEmpty(orgId)) {
            SysOrg org = sysOrgService.getOrgById(orgId);
            boolean canDelete = sysOrgService.canDeleteOrg(org.getTreeCode());
            if (canDelete) {
                sysOrgService.deleteOrgByTreeCode(org.getTreeCode());
                return this.outSuccessJson();
            } else {
                return this.outFailJson("该机构或所辖子机构已被用户数据引用，不能删除");
            }
        } else {
            return this.outFailJson("传入的菜单ID为空");
        }
    }

    @ResponseBody
    @RequestMapping("/allSort")
    public String allSort() {
        List<SysOrg> list = sysOrgService.getAllOrg();
        SysOrg rootOrg = new SysOrg();
        rootOrg.setId(TreeNode.TOP_NODE_ID);
        rootOrg.setTreeCode("");
        list.add(0, rootOrg);
        sysOrgService.sortOrgForList(list);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/sort")
    public String sort(String orgId) {
        String ids = orgId;
        if (StringUtils.isNotEmpty(ids)) {
            String[] ida = ids.split(";");
            for (int i = 0; i < ida.length; i++) {
                SysOrg org = sysOrgService.getOrgById(ida[i]);
                List<SysOrg> list = sysOrgService.getAllChildOrg(org);
                String pTreeCode = org.getTreeCode().substring(0, org.getTreeCode().length() - TreeNode.CODE_LEN);
                org.setTreeCode(pTreeCode + TreeNode.genTreeCode(i + 1));
                sysOrgService.updateOrg(org);
                list.add(0, org);
                sysOrgService.sortOrgForList(list);
            }
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的排序机构ID字符串为空");
        }
    }

    @ResponseBody
    @RequestMapping("/tree")
    public Object tree() {
        TreeNode treeNode = sysOrgService.genOrgTreeNode();
        List<TreeNode> res = new ArrayList<>();
        res.add(treeNode);
        return res;
    }
}
