package com.roy.hspersona.web.service;

import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.web.entity.PersonVO;

/**
 * @author roy
 * @date 2021/12/17
 * @desc
 */

public class FormatService {

    public static String formatAge(String val){
        return val+"岁";
    }

    public static String getDescription(PersonVO personVO, JSONObject sourcejson){
        StringBuffer sb = new StringBuffer();
        sb.append("客户手机号："+personVO.getPhone());
        sb.append("\t注册时间："+personVO.getRegTime());
        sb.append("\t身份证号："+personVO.getIdcard());
        sb.append("\t总交易次数："+personVO.getRefer1());
        sb.append("\t总交易金额："+personVO.getRefer2());

//        sb.append("\t身份证号："+sourcejson.getString("DS_USER_IDENTIFICATION"));
        return sb.toString();
    }
}
