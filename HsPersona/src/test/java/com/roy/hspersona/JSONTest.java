package com.roy.hspersona;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.parser.ParserConfig;

/**
 * @author roy
 * @date 2021/12/16
 * @desc
 */
public class JSONTest {
    public static void main(String[] args) {
        ParserConfig.getGlobalInstance().setAutoTypeSupport(true);
        String test= "{\"unid\":\"9\",\"DS_USER_ID\":\"9\",\"DS_USER_NAME\":\"吴史散\",\"DS_USER_GENDER\":\"男\",\"DS_USER_HOMEADDR\":\"湖南省长沙市***\",\"DS_USER_ORDER_COUNT\":\"1\",\"DS_USER_AVAILABLE\":\"278.8\",\"@tagIndex\":\"#80后#\",\"DS_USER_REGTIME\":\"2013-09-11\",\"@type\":\"DS_CLIENT\",\"DS_USER_IDENTIFICATION\":\"430903198712214231\",\"DS_USER_ORDER_AMOUNT\":\"700.0\",\"DS_USER_PHONE\":\"13807370009\",\"DS_USER_AGE\":\"32\",\"@tag\":[{\"tagName\":\"80后\",\"tagValue\":\"1\",\"ruleTagId\":\"ID2112121744344949468976184\",\"tagTime\":1639636585039,\"isLatest\":1,\"unionTagId\":\"1_ID2112121744344949468976184\"}]}";
        JSONObject jsonObject = JSON.parseObject(test);
        System.out.println(jsonObject);
    }
}
