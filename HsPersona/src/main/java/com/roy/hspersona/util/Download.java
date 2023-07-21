package com.roy.hspersona.util;

import java.io.BufferedOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

/**
 * 下载方法
 */
public class Download {

	/**
	 * 下载指定格式的文本文件
	 */
	public static void downloadText(HttpServletResponse response, String fileName, String contextType, String data) {
		response.setContentType(contextType);
		response.setCharacterEncoding("UTF-8");
		response.addHeader("Content-Disposition", "attachment;filename=" + fileName);
		BufferedOutputStream buff = null;
		ServletOutputStream outSTr = null;
		try {
			outSTr = response.getOutputStream();
			buff = new BufferedOutputStream(outSTr);
			buff.write(data.getBytes("UTF-8"));
			buff.flush();
			buff.close();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				buff.close();
				outSTr.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
