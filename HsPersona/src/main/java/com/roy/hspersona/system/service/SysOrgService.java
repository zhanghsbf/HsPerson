package com.roy.hspersona.system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.system.entity.SysOrg;
import com.roy.hspersona.system.entity.SysOrgExt;
import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.system.mapper.SysOrgMapper;
import com.roy.hspersona.system.mapper.SysUserMapper;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.executor.result.DefaultResultHandler;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/2
 * @desc
 */
@Service
public class SysOrgService {

    @Resource
    private SysOrgMapper sysOrgMapper;

    @Resource
    private SysDictionaryService sysDictionaryService;

    public SysOrg getOrgById(String orgId) {
        return sysOrgMapper.selectById(orgId);
    }

    public SysOrgExt genOrgTreeGridNode() {
        // 按treeCode排好序的机构list
        List<SysOrg> list = this.getAllOrg();
        List<SysOrgExt> nodeList = new ArrayList<SysOrgExt>();
        Map<String, String> map = sysDictionaryService.getMapByCode(ConstantDict.ORG_TYPE);
        // 先将机构list转为能兼容树结构的机构扩展实体列表
        for (int i = 0; i < list.size(); i++) {
            SysOrg org = list.get(i);
            String value = map.get(Integer.toString(org.getType()));
            org.setTypeName(value);
            SysOrgExt orgExt = new SysOrgExt(org);
            nodeList.add(orgExt);
        }
        // 倒树开始处理这些扩展机构节点
        for (int i = nodeList.size() - 1; i >= 0; i--) {
            SysOrgExt orgExt = nodeList.get(i);
            /*
             * 如果是叶子，则不处理，因为叶子没有子节点了，只等别人来包含他
             * 如果不是叶子节点，从这个节点的i+1个节点开始，到列表结束或者节点的父节点编码不等于该节点的ID时结束
             * 这些符合条件的节点都是该节点的子节点，都包含进来 已经包含进来的节点，从列表中移出
             */
            if (list.get(i).getLeaf()!=1) {
                int j = i + 1;
                while (j < nodeList.size() && nodeList.get(j).getParentId().equals(orgExt.getId())) {
                    orgExt.getChildren().add(nodeList.get(j));
                    j++;
                }
                for (int k = j - 1; k > i; k--) {
                    nodeList.remove(k);
                }
            }
        }
        SysOrgExt sysOrgExt = new SysOrgExt();
        sysOrgExt.setId(TreeNode.TOP_NODE_ID);
        sysOrgExt.setName("机构根节点");
        sysOrgExt.setLeaf(0);
        sysOrgExt.setStatus(1);
        sysOrgExt.setChildren(nodeList);
        return sysOrgExt;
    }

    public List<SysOrg> getAllOrg() {
        QueryWrapper<SysOrg> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByAsc("treeCode");
        return sysOrgMapper.selectList(queryWrapper);
    }

    public List<SysOrg> getOrg(Map<String,Object> params) {
        QueryWrapper<SysOrg> queryWrapper = new QueryWrapper<>();
        if(params.containsKey("type") && StringUtils.isNotEmpty((String)params.get("type"))){
            queryWrapper.eq("type",params.get("type"));
        }
        if(params.containsKey("name") && StringUtils.isNotEmpty((String)params.get("name"))){
            queryWrapper.eq("name",params.get("name"));
        }
        if(params.containsKey("parentId") && StringUtils.isNotEmpty((String)params.get("parentId"))){
            queryWrapper.eq("parentId",params.get("parentId"));
        }
        if(params.containsKey("status") && null != params.get("status")){
            queryWrapper.eq("status",params.get("status"));
        }
        queryWrapper.orderByAsc("treeCode");
        return sysOrgMapper.selectList(queryWrapper);
    }

    public String genTreeCode(String parentId) {
        String pTreeCode = "";
        if (!parentId.equals(TreeNode.TOP_NODE_ID)) {
            SysOrg pOrg = this.getOrgById(parentId);
            pTreeCode = pOrg.getTreeCode();
        }
        int index = 0;
        String brotherCode = sysOrgMapper.getMaxTreeCode(parentId);
        if (brotherCode != null) {
            String subCode = brotherCode.substring(pTreeCode.length());
            index = Integer.parseInt(subCode);
        }
        return pTreeCode + TreeNode.genTreeCode(index + 1);
    }

    public void saveSysOrg(SysOrg sysOrg) {
        int status = 1;
        if (!TreeNode.TOP_NODE_ID.equals(sysOrg.getParentId())) {
            SysOrg parentOrg = this.getOrgById(sysOrg.getParentId());
            parentOrg.setLeaf(0);
            sysOrgMapper.updateById(parentOrg);
            status = parentOrg.getStatus();
        }
        sysOrg.setStatus(status);// 与上级状态同步
        sysOrgMapper.insert(sysOrg);
    }

    public void updateOrg(SysOrg org) {
        sysOrgMapper.updateById(org);
    }

    public void changeStatus(SysOrg org) {
        // 这个计算式表示0和1的对应转变
        org.setStatus((org.getStatus() + 1) % 2);
        sysOrgMapper.updateById(org);

        List<SysOrg> list = this.getAllChildOrg(org);
        for (int i = 0; i < list.size(); i++) {
            SysOrg childOrg = list.get(i);
            childOrg.setStatus(org.getStatus());
            sysOrgMapper.updateById(childOrg);
        }
    }

    public List<SysOrg> getAllChildOrg(SysOrg org) {
        // list包含本节点
        List<SysOrg> list = sysOrgMapper.getAllChildOrg(org.getTreeCode());
        if (list.size() > 0) {
            if (org.getTreeCode().equals(list.get(0).getTreeCode())) {
                list.remove(0);
            }
        }
        return list;
    }

    public boolean canDeleteOrg(String treeCode) {
       int orgCount = sysOrgMapper.queryOrgUser(treeCode);
       return orgCount <= 0;
    }

    public void deleteOrgByTreeCode(String treeCode) {
        UpdateWrapper<SysOrg> wrapper = new UpdateWrapper<>();
        wrapper.like("treeCode",treeCode+"%");
        sysOrgMapper.delete(wrapper);
    }

    public void sortOrgForList(List<SysOrg> list) {
        for (int i = 0; i < list.size(); i++) {
            SysOrg org = list.get(i);
            if (StringUtils.isNotEmpty(org.getTreeCode())) {
                // 列表的第一条treeCode已经正确，没有必要再做一次
                if (i > 0) {
                    String pTreeCode = "";
                    int brotherNum = 0;
                    for (int j = i - 1; j >= 0; j--) {
                        SysOrg upOrg = list.get(j);
                        if (org.getParentId().equals(upOrg.getParentId())) {
                            brotherNum++;
                        }
                        if (org.getParentId().equals(upOrg.getId())) {
                            pTreeCode = upOrg.getTreeCode();
                            break;
                        }
                    }
                    org.setTreeCode(pTreeCode + TreeNode.genTreeCode(brotherNum + 1));
                    sysOrgMapper.updateById(org);
                }
            }
        }
    }

    public TreeNode genOrgTreeNode() {
        // 按treeCode排好序的机构list
        List<SysOrg> list = this.getAllOrg();
        List<TreeNode> nodeList = new ArrayList<>();
        // 先将机构list转为树结构节点类型实体列表
        for (int i = 0; i < list.size(); i++) {
            SysOrg org = list.get(i);
            TreeNode node = new TreeNode();
            node.setId(org.getId());
            node.setText(org.getName());
            node.setParentId(org.getParentId());
            nodeList.add(node);
        }
        // 倒树开始处理这些扩展机构节点
        for (int i = nodeList.size() - 1; i >= 0; i--) {
            TreeNode node = nodeList.get(i);
            /*
             * 如果是叶子，则不处理，因为叶子没有子节点了，只等别人来包含他
             * 如果不是叶子节点，从这个节点的i+1个节点开始，到列表结束或者节点的父节点编码不等于该节点的ID时结束
             * 这些符合条件的节点都是该节点的子节点，都包含进来 已经包含进来的节点，从列表中移出
             */
            if (list.get(i).getLeaf()!=1) {
                int j = i + 1;
                while (j < nodeList.size() && nodeList.get(j).getParentId().equals(node.getId())) {
                    node.getChildren().add(nodeList.get(j));
                    j++;
                }
                for (int k = j - 1; k > i; k--) {
                    nodeList.remove(k);
                }
            }
        }
        TreeNode node = new TreeNode();
        node.setId("-1");
        node.setText("机构根节点");
        node.setChildren(nodeList);
        return node;
    }
}
