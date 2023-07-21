package com.roy.hspersona.util;

import com.alibaba.fastjson.JSONObject;

/**
 * @author roy
 * @date 2021/12/16
 * @desc
 */
public class PagerUtil {
    public static JSONObject pagNumCalcute(long pageNow,long total,int pageSize){
        //开始序号
        long start =1 ;
        //结束页面编号
        long end = 1;
        //页面总数
        long pageSum= (total+pageSize-1)/pageSize;
        if(pageSum<=10){
            //页码总数不超过10页
            start = 1;
            end = pageSum;
        }else{
            //页码总数超过10页
            if(pageNow<7){
                //当前页为前6页
                start = 1;
                end = 10;
            }else{
                if(pageSum-pageNow>=4){
                    //当前页为最后4页
                    start = pageNow-5;
                    end = pageNow+4;
                }else{
                    start = pageSum-9;
                    end = pageSum;
                }
            }
        }
        StringBuffer pagerBuffer = new StringBuffer();
        pagerBuffer.append("{\"start\":\"").append(start).append("\",\"end\":\"").append(end).append("\"}");
        JSONObject jsonObject = JSONObject.parseObject(pagerBuffer.toString());
        return jsonObject;
    }
}
