package com.roy.hspersona.util;

import com.roy.hspersona.core.base.MyException;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.*;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

public class HttpUtil {

	/**
	 * 发送请求并返回结果
	 * @param url: 请求地址
	 * @param method: 请求类型,post,put,get,delete
	 * @return 请求结果
	 */
	public static String sendRequest(String url, String method) throws MyException {
		if (StringUtils.isEmpty(url)) {
			throw new MyException("{\"LocalException\":\"Url is empty\"}");
		}
		if (StringUtils.isEmpty(method)) {
			throw new MyException("{\"LocalException\":\"Method is empty\"}");
		}
		CloseableHttpClient httpclient = HttpClients.createDefault();
		try {
			CloseableHttpResponse response = null;
			if ("post".equals(method)) {
				HttpPost httpPost = new HttpPost(url);
				response = httpclient.execute(httpPost);
			} else if ("get".equals(method)) {
				HttpGet httpGet = new HttpGet(url);
				response = httpclient.execute(httpGet);
			} else if ("put".equals(method)) {
				HttpPut httpPut = new HttpPut(url);
				response = httpclient.execute(httpPut);
			} else if ("delete".equals(method)) {
				HttpDelete httpDelete = new HttpDelete(url);
				response = httpclient.execute(httpDelete);
			}
			if (response == null) {
				throw new MyException("{\"LocalException\":\"Method is error\"}");
			}
			HttpEntity entity = response.getEntity();
			String result = EntityUtils.toString(entity);
			EntityUtils.consume(entity);
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new MyException("{\"LocalException\":\"" + e.getMessage() + "\"}");
		} finally {
			try {
				httpclient.close();
			} catch (Exception e) {
				e.printStackTrace();
				throw new MyException("{\"LocalException\":\"" + e.getMessage() + "\"}");
			}
		}
	}
}
