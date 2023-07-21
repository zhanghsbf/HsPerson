package com.roy.hspersona.common;

import java.util.ArrayList;
import java.util.List;

/**
 * @ClassName: TreeNode
 * @Description: 构建easyUI树结构，用到的TreeNode节点格式
 */
public class TreeNode {

	/**
	 * 树结构节点对应的ID
	 */
	private String id;

	/**
	 * 树结构节点对应的文字
	 */
	private String text;

	/**
	 * 树结构节点对应的状态:closed,open
	 */
	private String state;

	/**
	 * 树结构节点对应的节点图标:使用css对应的class风格
	 */
	private String iconCls;

	/**
	 * 树结构节点对应的选中状态:true,false
	 */
	private boolean checked;

	/**
	 * 上级编号
	 */
	private String parentId;

	/**
	 * 树结构节点对应的子节点列表
	 */
	private List<TreeNode> children = new ArrayList<TreeNode>();
	/**
	 * 临时属性
	 */
	private String tmp;
	
	/**
	 * 树结构编码单级长度
	 */
	public static int CODE_LEN = 5;

	/**顶级节点ID
	 * 
	 */
	public static String TOP_NODE_ID="-1";
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getIconCls() {
		return iconCls;
	}

	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public List<TreeNode> getChildren() {
		return children;
	}

	public void setChildren(List<TreeNode> children) {
		this.children = children;
	}

	public String getTmp() {
		return tmp;
	}

	public void setTmp(String tmp) {
		this.tmp = tmp;
	}

	/**
	 * @Title: genTreeCode
	 * @Description: 根据序号生成五位的树结构代码
	 * @param i : 序号
	 * @return: 树结构代码
	 */
	public static String genTreeCode(int i) {
		i = i + (int) Math.pow(10, (double) CODE_LEN);
		return Integer.toString(i).substring(1);
	}
}
