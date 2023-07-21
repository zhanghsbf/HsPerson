package com.roy.hspersona.system.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.entity.SysRole;
import com.roy.hspersona.system.entity.SysUserRole;
import com.roy.hspersona.system.service.SysRolePermissionService;
import com.roy.hspersona.system.service.SysRoleService;
import com.roy.hspersona.system.service.SysUserRoleService;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/5
 * @desc
 */
@Controller
@RequestMapping("/system/role")
public class SysRoleController  extends MngBaseController {

    @Resource
    private SysRoleService sysRoleService;

    @Resource
    private SysUserRoleService sysUserRoleService;

    @Resource
    private SysRolePermissionService sysRolePermissionService;

    @RequestMapping("/to")
    public String to(){
        return "system/initRole";
    }

    @RequestMapping("/toauthorRole")
    public String toauthorRole(String id, Model model){
        model.addAttribute("id",id);
        return "system/authorRole";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(long page,long rows) {
        if(0==rows){
            rows = Constant.PAGE_SIZE;
        }

        Page<SysRole> sr = sysRoleService.getRoleByName("", page, rows);
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",sr.getRecords());
        return res;
    }

    @ResponseBody
    @RequestMapping("/ban")
    public String ban(String roleId) {
        if (StringUtils.isNotEmpty(roleId)) {
            SysRole role = sysRoleService.getRoleById(roleId);
            role.setEnable((role.getEnable() + 1) % 2);// 这个计算式表示0和1的对应转变
            sysRoleService.updateRole(role);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的启禁角色ID为空");
        }
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String roleId){
        if (StringUtils.isNotEmpty(roleId)) {
            List<SysUserRole> list = sysUserRoleService.getUserRoleByRoleId(roleId);
            if (list.size() == 0) {
                sysRoleService.deleteRoleById(roleId);
                return this.outSuccessJson();
            } else {
                return this.outFailJson("本角色已经被用户使用，不能删除");
            }
        } else {
            return this.outFailJson("传入的角色名称为空");
        }
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object edit(String roleId) {
        if (StringUtils.isNotEmpty(roleId)) {
            SysRole role = sysRoleService.getRoleById(roleId);
            return role;
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(String id,String name) {
        if (StringUtils.isNotEmpty(id)) {
            SysRole role = sysRoleService.getRoleById(id);
            if (role == null) {
                this.outFailJson("传入的角色ID错误！");
                return null;
            }
            role.setName(name);
            sysRoleService.updateRole(role);
            return this.outSuccessJson();
        } else {
            if (StringUtils.isNotEmpty(name)) {
                SysRole role = new SysRole();
                role.setId(KeyUtil.getKey());
                role.setName(name);
                role.setEnable(1);
                sysRoleService.saveRole(role);
                return this.outSuccessJson();
            } else {
                return this.outFailJson("传入的角色名称为空");
            }
        }
    }

    @ResponseBody
    @RequestMapping("/assign")
    public String assign(String roleId,String ids) {
        if (StringUtils.isNotEmpty(roleId)) {
            String[] ida = ids.split(";");
            sysRolePermissionService.assignPermissionToRole(roleId, ida);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的角色ID为空");
        }
    }

    @RequestMapping("/toViewRolePermission")
    public String toViewRolePermission(String id,Model model){
        model.addAttribute("id",id);
        return "system/viewRolePermission";
    }

    @ResponseBody
    @RequestMapping("/userRole")
    public Object userRole(String userId) {
        List<SysRole> list = sysRoleService.getAllRole();
        List<SysUserRole> surList = sysUserRoleService.getUserRoleByUserId(userId);

        final JSONArray json = JSONArray.parseArray(JSON.toJSONString(list));

        for (int i = 0; i < surList.size(); i++) {
            SysUserRole sur = surList.get(i);
            for (int j = 0; j < list.size(); j++) {
                if (list.get(j).getId().equals(sur.getRoleId())) {
                    json.getJSONObject(j).put("checked", true);
                    break;
                }
            }
        }
        Map<String ,Object> res = new HashMap<>();
        res.put("total",list.size());
        res.put("rows",json);
        return res;
    }
}
