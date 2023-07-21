package com.roy.hspersona.system.controller;

import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.entity.SysPermission;
import com.roy.hspersona.system.service.SysPermissionService;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/3
 * @desc
 */
@Controller
@RequestMapping("/system/permission")
public class SysPermissionController extends MngBaseController {

    @Resource
    private SysPermissionService sysPermissionService;

    @RequestMapping("/to")
    public String to(){
        return "system/initPermission";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(String menuId){
        List<SysPermission> sr = sysPermissionService.getPermission("",menuId);
        Map<String,Object> res = new HashMap<>();
        res.put("total",sr.size());
        res.put("rows",sr);
        return res;
    }

    @ResponseBody
    @RequestMapping("/delete")
    public Object delete(String permissionId){
        String id = permissionId;
        if (StringUtils.isNotEmpty(id)) {
            SysPermission permission = sysPermissionService.getPermissionById(id);
            // 下面这个方法将permission.getTreeCode()作为对应菜单的树结构去查
            // 有点取巧成分，但通过分析SQL语句，同样能解决问题
            List<SysPermission> list = sysPermissionService.getUsedPermissionByParentTreeCode(permission.getTreeCode());
            if (list.size() == 0) {
                int info = sysPermissionService.deletePermissionById(id);
                if (info > 0) {
                    return this.outSuccessJson();
                } else {
                    return this.outFailJson("没有需要删除的权限点");
                }
            } else {
                return this.outFailJson("存在部分权限点已经被引用");
            }
        } else {
            return this.outFailJson("传入的权限点ID为空");
        }
    }

    @ResponseBody
    @RequestMapping("/edit")
    public Object edit(String id) {
        if (StringUtils.isNotEmpty(id)) {
            return sysPermissionService.getPermissionById(id);
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/save")
    public String save(String id, String menuId, String code, String memo) {
        if (StringUtils.isEmpty(menuId)) {
            return this.outFailJson("所属菜单ID为空！");
        }
        if (StringUtils.isEmpty(code)) {
            return this.outFailJson("权限点代码为空");
        }
        List<SysPermission> sr = sysPermissionService.getPermission(code,"");
        if (sr.size() > 0) {
            SysPermission perm = sr.get(0);
            if (!perm.getId().equals(id)) {
                return this.outFailJson("该权限点代码已经存在");
            }
        }

        if (StringUtils.isEmpty(id)) {
            SysPermission permission = new SysPermission();
            permission.setId(KeyUtil.getKey());
            permission.setMenuId(menuId);
            permission.setCode(code);
            permission.setMemo(memo);
            permission.setTreeCode(sysPermissionService.genTreeCode(menuId));
            sysPermissionService.savePermission(permission);
            return this.outSuccessJson();
        } else {
            SysPermission permission = sysPermissionService.getPermissionById(id);
            if (permission == null) {
                return this.outFailJson("传入的权限点ID错误！");
            }
            permission.setCode(code);
            permission.setMemo(memo);
            sysPermissionService.updatePermission(permission);
            return this.outSuccessJson();
        }
    }

}
