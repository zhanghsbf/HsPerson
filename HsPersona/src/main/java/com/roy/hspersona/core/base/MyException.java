package com.roy.hspersona.core.base;

/**
 * 自定义异常类
 */
public class MyException extends Exception {
	/**
	 * @Fields serialVersionUID :
	 */
	private static final long serialVersionUID = -129264675571619830L;

	/**
	 * 错误信息ID
	 */
	private String errMsgId;

	/**
	 * 错误消息
	 */
	private String errMsg;

	/**
	 * 错误提示后跳转的地址
	 */
	private String url;

	/**
	 * 构造函数
	 */
	public MyException() {
	}

	/**
	 * 构造函数
	 */
	public MyException(String errMsg) {
		this.errMsg = errMsg;
	}

	/**
	 * 构造函数
	 */
	public MyException(String errMsgId, String errMsg) {
		this.errMsgId = errMsgId;
		this.errMsg = errMsg;
	}

	/**
	 * 获取错误消息
	 * 
	 * @return
	 */
	public String getMessage() {
		return errMsg;
	}

	/**
	 * 
	 * 获取错误ID
	 * 
	 * @return
	 * @since <IVersion>
	 */
	public String getErrorId() {
		return errMsgId;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}
}
