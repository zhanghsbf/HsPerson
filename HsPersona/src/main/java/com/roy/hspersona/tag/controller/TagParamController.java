package com.roy.hspersona.tag.controller;

import com.alibaba.fastjson.JSONArray;
import com.roy.hspersona.common.ConstantDataType;
import com.roy.hspersona.common.TreeNode;
import com.roy.hspersona.core.base.MngBaseController;
import com.roy.hspersona.system.entity.SysUser;
import com.roy.hspersona.tag.entity.TagEdge;
import com.roy.hspersona.tag.entity.TagExtTypeField;
import com.roy.hspersona.tag.entity.TagParamIn;
import com.roy.hspersona.tag.entity.TagVertex;
import com.roy.hspersona.tag.service.*;
import com.roy.hspersona.util.KeyUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/10
 * @desc
 */
@Controller
@RequestMapping("/tag/tagParam")
public class TagParamController extends MngBaseController {
    @Resource
    private TagVertexService tagVertexService;
    @Resource
    private TagParamInService tagParamInService;
    @Resource
    private TagExtTypeFieldService tagExtTypeFieldService;
    @Resource
    private TagDictionaryService tagDictionaryService;
    @Resource
    private TagEdgeService tagEdgeService;

    @RequestMapping("/to")
    public String to(){
        return "tag/initInParams";
    }

    @ResponseBody
    @RequestMapping("/inTree")
    public Object inTree(String tagId, HttpSession session) {
        List<TreeNode> nodeList = new ArrayList<>();
        if (StringUtils.isEmpty(tagId)) {
            return nodeList;
        }
        // 对应节点不存在则不需要去查询已选择的入参
        TagVertex tagVertex = tagVertexService.getTagVertexById(tagId);
        if (tagVertex == null) {
            return nodeList;
        }
        String userId = this.getUserSession(session).getUserId();
        TreeNode topTreeNode = new TreeNode();
        topTreeNode.setText("入参树根节点");
        // 用户入参规则中把把所属用户ID和所属标签ID的合并值作为顶级节点的parentId
        topTreeNode.setId(KeyUtil.mergeId(userId, tagId));
        nodeList.add(topTreeNode);
        // 如果不是规则节点，也不需要去查询入参，因为只有规则节点才有入参配置
        if (tagVertex.getType() != TagVertex.RULE) {
            return nodeList;
        }

        Map<String, Object> map = new HashMap<>();
        map.put("tagId", tagId);
        map.put("userId", this.getUserSession(session).getUserId());
        List<TagParamIn> list = tagParamInService.getTagParamIn(map,9999).getRecords();

        // 整理成树节点类型
        StringBuffer sb = new StringBuffer();
        for (TagParamIn tagParamIn : list) {
            TreeNode node = new TreeNode();
            node.setId(tagParamIn.getId());
            TagExtTypeField field = tagExtTypeFieldService.getTagExtTypeFieldById(tagParamIn.getFieldId());
            // 组织备注内容
            List<String> memoList = new ArrayList<>();
            if (StringUtils.isNotEmpty(field.getBelongExtType().getMemo())) {
                memoList.add(field.getBelongExtType().getMemo());
            }
            if (StringUtils.isNotEmpty(field.getMemo())) {
                memoList.add(field.getMemo());
            }
            if (field.getSelfExtType().getCode().equals(ConstantDataType.ENUMERATION)) {
                String memo = tagDictionaryService.getStringMemo(field.getDataTypeElement().getCode());
                if (StringUtils.isNotEmpty(memo)) {
                    memoList.add(memo);
                }
            }
            StringBuffer memoSB = new StringBuffer();
            for (String memo : memoList) {
                memoSB.append(";").append(memo);
            }
            if (memoSB.length() > 0) {
                memoSB = memoSB.deleteCharAt(0);
            } else {
                memoSB.append("-");
            }
            // set备注内容
            sb.setLength(0);
            sb.append("<font color='#C80000'>");
            sb.append(field.getDataTypeElement().getName()).append("(");
            sb.append(field.getDataTypeElement().getCode()).append(")");
            sb.append("</font>");
            sb.append("：").append(field.getSelfExtType().getCode());
            sb.append(" => { ");
            sb.append("<font color=blue>length</font>:").append(field.getTypeLength()).append(",");
            sb.append("<font color=blue>precision</font>:").append(field.getTypePrecision()).append(",");
            sb.append("<font color=blue>memo</font>:").append(memoSB.toString());
            sb.append(" }");
            node.setText(sb.toString());
            node.setTmp(tagParamIn.getParentId());
            nodeList.add(node);
        }

        // 列表从后往前检查，如果该节点的前一节点是他的父节点，那把该节点放入到父节点的孩子中，列表中移除该节点
        // 移除这个节点后，后面的节点依次前移一位，然后继续检查本位置节点（也就是没移之前本节点的下一节点）
        // 一直缩至这个列表只有一个节点，也就是只有顶级节点
        int index = nodeList.size() - 1;
        while (nodeList.size() != 1) {
            TreeNode thisNode = nodeList.get(index);
            TreeNode previousNode = nodeList.get(index - 1);
            if (previousNode.getId().equals(thisNode.getTmp())) {
                previousNode.getChildren().add(thisNode);
                nodeList.remove(index);
                if (index == nodeList.size()) {
                    index--;
                }
            } else {
                index--;
            }
        }
        return nodeList;
    }

    @ResponseBody
    @RequestMapping("/add")
    public String add(String tagId, String ids,HttpSession session) {
        if (StringUtils.isEmpty(tagId)) {
            return this.outFailJson("传入的入参所属标签节点ID为空");
        }
        if (StringUtils.isEmpty(ids)) {
            return this.outFailJson("传入的入参ID为空");
        }
        TagVertex vertex = tagVertexService.getTagVertexById(tagId);
        if (vertex == null) {
            return this.outFailJson("传入的入参所属标签节点ID不正确");
        }
        if (vertex.getType() != TagVertex.RULE) {
            return this.outFailJson("只有规则节点(<font color=blue>蓝色</font>)才能维护入参");
        }
        // ids的组成是 id1,id2;id3,id4,id5;id6 的格式 上述示例中表示选择了三个叶子节点，
        // 分别是id2,id5,id6，同时记录了id2的父节点id1，id5祖先节点id3,id4，id6没有父节点。 所以第一步先按分号切割
        // 第二步对每一个节点和他的祖先节点字符串再切割
        String[] idMatrix = ids.split(";");
        Map<String, TagParamIn> paramInMap = new HashMap<>();
        List<TagParamIn> paramInList = new ArrayList<>();
        Map<String, Integer> childNumMap = new HashMap<>();
        SysUser user = new SysUser();
        String userId = this.getUserSession(session).getUserId();
        user.setId(userId);
        for (String id : idMatrix) {
            String[] idArray = id.split(",");
            String parentTreeCode = "";
            // 初始设置最顶级节点，没有其他意义，只要不跟其他的重复即可，这里取userId与tagId的组合。
            // 同一个用户的同一个标签顶级节点对应的parentId是一致的，即所属用户ID和所属标签ID的合并值作为顶级节点的parentId
            String parentId = KeyUtil.mergeId(userId, tagId);
            // 这里从1开始是因为模型树一级节点是基础模型类型的isFirstShow的对象的ID，其他是这个对象的属性的ID，所以不考虑开始的那个
            for (int i = 1; i < idArray.length; i++) {
                // 先成map中取，这里使用map的第一个原因是可以加快速度，减少访问数据库的次数，第二个原因是可能多个叶子属性对应一个父级，但这个父级只需要保存一次
                // map的key值由两部分确定，一个是这个节点对应的属性ID，另外一个是这个节点在入参树中对应的上级节点ID
                TagParamIn paramIn = paramInMap.get(idArray[i] + parentId);
                // 如果map中没有，就得组织，或查数据库，或新建
                if (paramIn == null) {
                    paramIn = tagParamInService.getTagParamInBy(tagId, idArray[i], parentId);
                    // 如果数据库中没有就新建，并把新建的实体放在List中，用于批量保存
                    if (paramIn == null) {
                        paramIn = new TagParamIn();
                        paramIn.setId(KeyUtil.getKey());
                        paramIn.setParentId(parentId);
                        paramIn.setFieldId(idArray[i]);
                        paramIn.setTagId(tagId);
                        // treeCode序号先从map中取,map中没有再从数据库中查
                        // 因为是批量存储，所以如果一个节点下增加多个子节点时可能取得的treeCode一直是相同的
                        Integer maxChildNum = childNumMap.get(parentId);
                        if (maxChildNum == null) {
                            maxChildNum = tagParamInService.getMaxTreeCode(parentId);
                        }
                        paramIn.setTreeCode(parentTreeCode + TreeNode.genTreeCode(maxChildNum + 1));
                        childNumMap.put(parentId, maxChildNum + 1);
                        paramIn.setUserId(userId);
                        paramInList.add(paramIn);
                    }
                    paramInMap.put(idArray[i] + parentId, paramIn);
                }
                parentTreeCode = paramIn.getTreeCode();
                parentId = paramIn.getId();
            }
        }
        tagParamInService.saveTagParamIns(paramInList);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/delete")
    public String delete(String id) {
        if (StringUtils.isEmpty(id)) {
            return this.outFailJson("传入需要删除的入参ID为空");
        }
        TagParamIn thisParamIn = tagParamInService.getTagParamInById(id);
        if (thisParamIn == null) {
            this.outFailJson("传入需要删除的入参ID错误");
            return null;
        }

        String info = tagParamInService.removeTagParamInById(id);
        if (StringUtils.isNotEmpty(info)) {
            return this.outFailJson(info);
        } else {
            return this.outSuccessJson();
        }
    }

    @ResponseBody
    @RequestMapping("/deleteAll")
    public String deleteAll(String id,HttpSession session) {
        if (StringUtils.isEmpty(id)) {
            return this.outFailJson("传入需要删除的入参所属节点ID为空");
        }
        TagVertex tagVertex = tagVertexService.getTagVertexById(id);
        if (tagVertex == null) {
            return this.outFailJson("传入需要删除的入参所属节点ID错误");
        }
        if (tagVertex.getType() != TagVertex.RULE) {
            return this.outFailJson("传入需要删除的入参所属节点不是规则节点");
        }
        List<TagParamIn> list = tagParamInService.getTagParamInByTagId(id, this.getUserSession(session).getUserId());
        tagParamInService.deleteTagParamIns(list);
        return this.outSuccessJson();
    }

    @ResponseBody
    @RequestMapping("/inList")
    public Object inList(String tagId,HttpSession session) {
        List<String> inList = new ArrayList<>();
        if (StringUtils.isEmpty(tagId)) {
            return inList;
        }
        // 对应节点不存在则不需要去查询已选择的入参
        TagVertex tagVertex = tagVertexService.getTagVertexById(tagId);
        if (tagVertex == null) {
            return inList;
        }
        // 如果点击的是标签节点，则切换到上级节点（规则节点）再找入参配置
        if (TagVertex.TAG == tagVertex.getType()) {
            List<TagEdge> edgeList = tagEdgeService.getTagEdgeByVertexId(tagId, 2, TagEdge.DADSON);
            if (edgeList.size() == 0) {
                return inList;
            } else {
                tagId = edgeList.get(0).getVertexAid();
            }
        }
        Map<String, Object> map = new HashMap<>();
        map.put("tagId", tagId);
        map.put("userId", this.getUserSession(session).getUserId());
        List<TagParamIn> list = tagParamInService.getTagParamIn(map, 9999).getRecords();
        Map<String, String> codeMap = new HashMap<>();
        for (TagParamIn tagParamIn : list) {
            TagExtTypeField field = tagExtTypeFieldService.getTagExtTypeFieldById(tagParamIn.getFieldId());
            String parentCode = codeMap.get(tagParamIn.getParentId());
            if (StringUtils.isNotEmpty(parentCode)) {
                parentCode = parentCode + ".";
            } else {
                parentCode = "";
            }
            if (field.getSelfExtType().getType() == 3) {
                codeMap.put(tagParamIn.getId(), parentCode + field.getDataTypeElement().getCode());
            } else {
                inList.add(parentCode + field.getDataTypeElement().getCode());
            }
        }
        return inList;
    }
}
