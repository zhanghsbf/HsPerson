package com.roy.hspersona.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.common.HdfsFile;
import com.roy.hspersona.core.base.MyException;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPut;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * hdfs的操作方式webHdfs的工具类
 */
public class WebHdfsUtil extends HttpUtil{

	/**
	 * 获取某个路径下的所有文件及文件夹列表
	 * @param path: 所在路径
	 * @return 文件列表
	 */
	public static List<HdfsFile> getFileList(String path) throws MyException {
		List<HdfsFile> list = new ArrayList<HdfsFile>();
		String content = sendRequest(getWebHdfsAddress() + getPath(path) + "?op=LISTSTATUS", "get");
		try {
			content = new String(content.getBytes("ISO-8859-1"), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		if (StringUtils.isEmpty(content)) {
			return list;
		}
		JSONObject json = JSON.parseObject(content);
		if (json.get("FileStatuses") == null) {
			return list;
		}
		JSONObject fileStatuses = json.getJSONObject("FileStatuses");
		if (fileStatuses.get("FileStatus") == null) {
			return list;
		}
		JSONArray files = fileStatuses.getJSONArray("FileStatus");
		for (int i = 0; i < files.size(); i++) {
			JSONObject file = files.getJSONObject(i);
			HdfsFile hdfsFile = new HdfsFile();
			hdfsFile.setChildrenNum(file.getIntValue("childrenNum"));
			hdfsFile.setModificationTime(new Date(file.getLong("modificationTime")));
			hdfsFile.setName(file.getString("pathSuffix"));
			hdfsFile.setType(file.getString("type"));
			if (file.get("length") != null) {
				hdfsFile.setLength(file.getLong("length"));
			}
			list.add(hdfsFile);
		}
		return list;
	}

	/**
	 * 创建文件夹，不覆盖
	 * @param path: 文件夹所在路径
	 * @param name: 文件夹名称
	 */
	public static void createFolder(String path, String name) throws MyException {
		if (StringUtils.isEmpty(name)) {
			throw new MyException("文件名为空");
		}
		if (name.length() > 50) {
			throw new MyException("文件名长度大于50");
		}
		String content = sendRequest(getWebHdfsAddress() + getPath(path) + getPath(name) + "?op=MKDIRS&user.name=" + getWebHdfsUser(), "put");
		processResult(content);
	}

	/**
	 * 递归删除文件或文件夹
	 * @param path: 所在路径
	 */
	public static void deleteFiles(String path) throws MyException {
		if (StringUtils.isEmpty(path)) {
			throw new MyException("被删除路径为空");
		}
		String content = sendRequest(getWebHdfsAddress() + getPath(path) + "?op=DELETE&recursive=true&user.name=" + getWebHdfsUser(), "delete");
		processResult(content);
	}

	/**
	 * 重命名文件或文件夹
	 * @param path: 文件或文件夹所在路径
	 * @param oldName: 原名称
	 * @param newName: 新名称
	 */
	public static void renameFiles(String path, String oldName, String newName) throws MyException {
		if (StringUtils.isEmpty(path)) {
			throw new MyException("被重命名对象路径为空");
		}
		if (StringUtils.isEmpty(oldName)) {
			throw new MyException("旧名称为空");
		}
		if (StringUtils.isEmpty(newName)) {
			throw new MyException("新名称为空");
		}
		String url = getWebHdfsAddress() + getPath(path) + getPath(oldName);
		url += "?op=RENAME&user.name=" + getWebHdfsUser();
		url += "&destination=" + getPath(path) + getPath(newName);
		System.out.println("url:" + url);
		String content = sendRequest(url, "put");
		processResult(content);
	}

	/**
	 * 判断一个文件或文件夹是否存在
	 * @param path: 路径
	 * @return true存在，false不存在
	 */
	public static boolean isExist(String path) {
		if (StringUtils.isEmpty(path)) {
			return true;
		}
		try {
			String content = sendRequest(getWebHdfsAddress() + getPath(path) + "?op=GETFILESTATUS", "get");
			JSONObject json = JSON.parseObject(content);
			return json.get("FileStatus") != null;
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * 上传文件
	 * @param path: 文件上传到的路径
	 * @param file: 被上传的文件
	 */
	public static void uploadFile(String path, File file) throws MyException {
		if (file == null) {
			throw new MyException("文件为空");
		}
		CloseableHttpClient httpclient = HttpClients.createDefault();
		try {
			HttpPut httpPut1 = new HttpPut(getWebHdfsAddress() + getPath(path) + "?op=CREATE&user.name=" + getWebHdfsUser());
			CloseableHttpResponse response1 = httpclient.execute(httpPut1);
			Header locationHeader = response1.getFirstHeader("Location");
			if (locationHeader != null) {
				String location = locationHeader.getValue();
				HttpPut httpPut2 = new HttpPut(location);
				FileBody bin = new FileBody(file);
				// StringBody comment = new StringBody("A binary file of some kind", ContentType.TEXT_PLAIN);
				HttpEntity reqEntity = MultipartEntityBuilder.create().addPart("bin", bin).build();// .addPart("comment", comment)
				httpPut2.setEntity(reqEntity);
				CloseableHttpResponse response2 = httpclient.execute(httpPut2);
				HttpEntity entity = response2.getEntity();
				String content = EntityUtils.toString(entity);
				processResult(content);
				EntityUtils.consume(entity);
				response2.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new MyException(e.getMessage());
		} finally {
			try {
				httpclient.close();
			} catch (Exception e) {
				e.printStackTrace();
				throw new MyException(e.getMessage());
			}
		}
	}

	/**
	 * 读取hdfs中的某个文件的内容
	 * @param path: 被读文件地址
	 * @return 文件内容
	 */
	public static String readFile(String path) throws MyException {
		if (StringUtils.isEmpty(path)) {
			return "";
		} else {
			return sendRequest(getWebHdfsAddress() + getPath(path) + "?op=OPEN", "get");
		}
	}

	/**
	 * 解析处理结果
	 */
	private static void processResult(String result) throws MyException {
		if (StringUtils.isNotEmpty(result)) {
			JSONObject json = JSON.parseObject(result);
			if (json.get("boolean") != null) {
				boolean success = json.getBoolean("boolean");
				if (!success) {
					System.out.println(result);
					throw new MyException("创建文件夹失败(Exception: boolean=false)");
				}
			} else if (json.get("RemoteException") != null) {
				System.out.println(result);
				JSONObject exception = json.getJSONObject("RemoteException");
				if (exception.get("exception") != null) {
					throw new MyException("创建文件夹失败(Exception:" + exception.getString("exception") + ")");
				} else {
					System.out.println(result);
					throw new MyException("创建文件夹失败(Exception:null)");
				}
			} else {
				System.out.println(result);
				throw new MyException("创建文件夹失败(Exception:unknown)");
			}
		}
	}

	/**
	 * 返回合适的文件路径，原则是所有路径都是前面有斜杠，后面没有斜杠
	 * @param path: 加工前的路径
	 * @return 加工后的路径
	 */
	public static String getPath(String path) {
		if (StringUtils.isEmpty(path) || "/".equals(path)) {
			return "";
		}
		if (!path.startsWith("/")) {
			path = "/" + path;
		}
		if (path.endsWith("/")) {
			path = path.substring(0, path.length() - 1);
		}
		return path;
	}

	/**
	 * 获取webhdfs路径地址前缀
	 * @return webhdfs路径地址前缀
	 */
	private static String getWebHdfsAddress() throws MyException {
		String webHdfsAddress = ConstantParam.paramMap.get(ConstantParam.WEB_HDFS_ADDRESS);
		if (webHdfsAddress == null) {
			throw new MyException("请联系系统管理员设置webhdfs路径地址前缀参数（" + ConstantParam.WEB_HDFS_ADDRESS + "）");
		}
		if (webHdfsAddress.endsWith("/")) {
			return webHdfsAddress.substring(0, webHdfsAddress.length() - 1);
		} else {
			return webHdfsAddress;
		}
	}

	/**
	 * 获取hdfs文件系统用户名
	 * @return hdfs文件系统用户名
	 */
	private static String getWebHdfsUser() throws MyException {
		String webHdfsUsername = ConstantParam.paramMap.get(ConstantParam.WEB_HDFS_USERNAME);
		if (webHdfsUsername == null) {
			throw new MyException("请联系系统管理员设置hdfs文件系统用户名参数（" + ConstantParam.WEB_HDFS_USERNAME + "）");
		}
		return webHdfsUsername;
	}
}
