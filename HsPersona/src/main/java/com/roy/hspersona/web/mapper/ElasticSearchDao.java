package com.roy.hspersona.web.mapper;

import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.util.NumUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.HttpHost;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.common.settings.Settings;
import org.springframework.stereotype.Repository;

import java.net.InetAddress;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author roy
 * @date 2021/12/15
 * @desc
 */
@Repository
public class ElasticSearchDao {

    public RestHighLevelClient getEsClient() throws MyException {

        HttpHost[] esHosts = this.getEsAddresses();
        RestClientBuilder restClient = RestClient.builder(esHosts);
        RestHighLevelClient client = new RestHighLevelClient(restClient);
        return client;
    }

    public String getEsClusterName() throws MyException {
        String clusterName = ConstantParam.paramMap.get(ConstantParam.ES_CLUSTER_NAME);
        if (clusterName == null) {
            throw new MyException("请联系系统管理员设置ES集群名称参数（" + ConstantParam.ES_CLUSTER_NAME + "）");
        }
        return clusterName;
    }

    public HttpHost[] getEsAddresses() throws MyException {
        String esClusterIpv4s = ConstantParam.paramMap.get(ConstantParam.ES_CLUSTER_IPV4S);
        HttpHost[] addresses = this.parseIps(esClusterIpv4s);
        if (addresses == null) {
            throw new MyException("请联系系统管理员设置正确格式的IPv4参数（" + ConstantParam.ES_CLUSTER_NAME + "）");
        }
        return addresses;
    }

    public String getEsIndexName() throws MyException {
        String indexName = ConstantParam.paramMap.get(ConstantParam.ES_INDEX_NAME);
        if (indexName == null) {
            throw new MyException("请联系系统管理员设置ES索引名称参数（" + ConstantParam.ES_CLUSTER_NAME + "）");
        }
        return indexName;
    }

    private HttpHost[] parseIps(String ips) {
        if (StringUtils.isEmpty(ips)) {
            return null;
        }
        String[] ipArray = ips.split(",");
        HttpHost[] addresses = new HttpHost[ipArray.length];
        for (int i = 0; i < ipArray.length; i++) {
            String ip = ipArray[i];
            String[] v = ip.split(":");
            if (v.length != 2 || StringUtils.isEmpty(v[0]) || StringUtils.isEmpty(v[1])) {
                return null;
            }
            if (!NumUtil.isInt(v[1], 1, 65535)) {
                return null;
            }
            addresses[i] = new HttpHost(v[0], Integer.parseInt(v[1]));
        }
        return addresses;
    }

    public List<String> splitStrToChineseCharNumStrTextStr(String source) {
        List<String> slist = new ArrayList<>();
        if (StringUtils.isNotEmpty(source)) {
            Pattern p = Pattern.compile("[\\u4e00-\\u9fa5]+|\\d+|[a-zA-Z]+");
            Matcher m = p.matcher(source);
            while (m.find()) {
                if (isExistChinese(m.group())) {// 中文
                    char[] chars = m.group().toCharArray();
                    for (int i = 0; i < chars.length; i++) {
                        slist.add(String.valueOf(chars[i]));
                    }
                } else {
                    slist.add(String.valueOf(m.group()));
                }
            }
        }
        return slist;
    }

    private static boolean isExistChinese(String s) {
        if (StringUtils.isEmpty(s)) {
            return false;
        }
        Pattern p = Pattern.compile("[\\u4e00-\\u9fa5]");
        Matcher m = p.matcher(s);
        if (m.find()) {
            return true;
        } else {
            return false;
        }
    }
}
