package com.roy.hspersona.system.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.system.entity.SysOrg;
import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.system.service.SysOrgService;
import com.roy.hspersona.system.service.SysUserRoleService;
import com.roy.hspersona.system.service.SysUserService;
import com.roy.hspersona.tag.entity.TagAccount;
import com.roy.hspersona.tag.service.TagAccountService;
import com.roy.hspersona.util.KeyUtil;
import com.roy.hspersona.util.MD5Util;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/2
 * @desc
 */
@Controller
@RequestMapping("/system/user")
public class SysUserController extends MngBaseController {

    @Resource
    private SysUserService sysUserService;

    @Resource
    private SysOrgService sysOrgService;

    @Resource
    private TagAccountService tagAccountService;

    @Resource
    private SysUserRoleService sysUserRoleService;

    @ResponseBody
    @RequestMapping("/changePassword")
    public String changePassword(String oldPass, String newPass, HttpSession session){
        if (newPass.length() < 4) {
            this.outFailJson("新密码输入长度不能小于4位");
            return null;
        }
        SysUser user = sysUserService.getUserById(this.getUserSession(session).getUserId());
        if (!oldPass.equalsIgnoreCase(user.getPassword())) {
            this.outFailJson("原密码输入错误");
            return null;
        }
        // 更新密码
        user.setPassword(newPass);
        sysUserService.updateUser(user);
        return this.outSuccessJson();
    }

    @RequestMapping("toedit")
    public String toEdit(String id,HttpSession session, Model model){
        if(StringUtils.isEmpty(id)){
            id = this.getUserSession(session).getUserId();
        }
        if(StringUtils.isNotEmpty(id)){
            final SysUser user = sysUserService.getUserById(id);
            SysOrg org = sysOrgService.getOrgById(user.getOrgId());
            model.addAttribute("user",user);
            model.addAttribute("orgName",org.getName());
        }
        return "system/editUserInfo";
    }

    @ResponseBody
    @RequestMapping("save")
    public String save(String id,String name,String realName,String orgId){

        if (StringUtils.isEmpty(orgId)) {
            return this.outFailJson("所属机构ID为空！");
        }
        if (StringUtils.isEmpty(id) && StringUtils.isEmpty(name)) {
            return this.outFailJson("用户名为空");
        }
        if (StringUtils.isEmpty(realName)) {
            return this.outFailJson("用户姓名为空");
        }

        if (StringUtils.isEmpty(id)) { //新增
            // 修改是不能修改用户名name的，所以只要在新增的时候判断
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("ww_name", name);
            SysUser sr = sysUserService.getUserById(id);
            map = new HashMap<String, Object>();
            map.put("ww_account", name);
            TagAccount tagAccount = tagAccountService.getTagAccountByAccount(name);
            // user表中的用户需要同步到account表中
            if (null != tagAccount) {
                return this.outFailJson("该用户名已经存在");
            }

            SysUser user = new SysUser();
            user.setId(KeyUtil.getKey());
            user.setCreateDate(LocalDateTime.now());
            user.setEnable(0);
            user.setName(name);
            user.setRealName(realName);
            user.setOrgId(orgId);
            String defaultPassword = ConstantParam.paramMap.get(ConstantParam.DEFAULT_PASSWORD);
            if (defaultPassword == null) {
                return this.outFailJson("请联系系统管理员设置默认密码参数（" + ConstantParam.DEFAULT_PASSWORD + "）");
            }
            user.setPassword(MD5Util.getMD5Code(defaultPassword));
            sysUserService.saveUser(user);
            return this.outSuccessJson();
        } else {
            SysUser user = sysUserService.getUserById(id);
            if (user == null) {
                return this.outFailJson("传入的用户ID错误！");
            }
            user.setRealName(realName);
            sysUserService.updateUser(user);
            return this.outSuccessJson();
        }
    }

    @RequestMapping("/to")
    public String to(){
        return "system/initUser";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(long page,long rows,String orgId) {
        if(page <=0 ){
            page = 1l;
        }
        if(rows <=0){
            rows = Constant.PAGE_SIZE;
        }
        if(StringUtils.isEmpty(orgId)){
            orgId = TreeNode.TOP_NODE_ID;
        }
        String treeCode = "";
        if (!TreeNode.TOP_NODE_ID.equals(orgId)) {
            SysOrg org = sysOrgService.getOrgById(orgId);
            treeCode = org.getTreeCode();
        }
        Page<SysUser> sr = sysUserService.getUserByOrgTreeCode(treeCode, page, rows);
        List<SysUser> list = sr.getRecords();
        for (int i = 0; i < list.size(); i++) {
            SysUser user = list.get(i);
            if (StringUtils.isNotEmpty(user.getOrgId())) {
                SysOrg org = sysOrgService.getOrgById(user.getOrgId());
                if (org != null) {
                    user.setOrgName(org.getName());
                    list.set(i, user);
                }
            }
        }
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.getTotal());
        res.put("rows",list);
        return res;
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object edit(String id,HttpSession session) {
        if(StringUtils.isEmpty(id)){
            id = this.getUserSession(session).getUserId();
        }
        if (StringUtils.isNotEmpty(id)) {
            SysUser user = sysUserService.getUserById(id);
            SysOrg org = sysOrgService.getOrgById(user.getOrgId());
            final JSONObject json = JSON.parseObject(JSON.toJSONString(user));
            json.put("orgName", org.getName());
            return json;
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/ban")
    public String ban(String userId) {
        if (StringUtils.isNotEmpty(userId)) {
            SysUser user = sysUserService.getUserById(userId);
            // 这个计算式表示0和1的对应转变
            user.setEnable((user.getEnable() + 1) % 2);
            sysUserService.updateUser(user);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的用户ID为空，不能完成启禁操作");
        }
    }

    @ResponseBody
    @RequestMapping("/reset")
    public String reset(String userId) {
        if (StringUtils.isNotEmpty(userId)) {
            String defaultPassword = ConstantParam.paramMap.get(ConstantParam.DEFAULT_PASSWORD);
            if (defaultPassword == null) {
                return this.outFailJson("请联系系统管理员设置默认密码参数（" + ConstantParam.DEFAULT_PASSWORD + "）");
            }
            SysUser user = sysUserService.getUserById(userId);
            user.setPassword(MD5Util.getMD5Code(defaultPassword));
            sysUserService.updateUser(user);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的用户ID为空，不能完成重置密码操作");
        }
    }

    @ResponseBody
    @RequestMapping("/assign")
    public String assign(String ids, String userId) {
        if (StringUtils.isNotEmpty(userId)) {
            String[] ida = ids.split(",");
            sysUserRoleService.assignRoleToUser(userId, ida);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的被授权用户ID为空");
        }
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String userId) {
        if (StringUtils.isNotEmpty(userId)) {
            try {
                sysUserService.deleteUserById(userId);
                return this.outSuccessJson();
            } catch (MyException e) {
                return this.outFailJson(e.getMessage());
            }
        } else {
            return this.outFailJson("传入的用户ID为空，没有删除任何用户数据");
        }
    }

    @ResponseBody
    @RequestMapping("/industry")
    public String industry(String ids, String userId) {
        if (StringUtils.isNotEmpty(userId)) {
            SysUser user = sysUserService.getUserById(userId);
            user.setIndustrytypes(ids);
            sysUserService.updateUser(user);
            return this.outSuccessJson();
        } else {
            return this.outFailJson("传入的被分配行业用户ID为空");
        }
    }
}
