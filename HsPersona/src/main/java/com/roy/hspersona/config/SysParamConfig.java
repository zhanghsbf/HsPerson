package com.roy.hspersona.config;

import com.alibaba.fastjson.parser.ParserConfig;
import com.roy.hspersona.common.ConstantParam;
import com.roy.hspersona.system.entity.SysParam;
import com.roy.hspersona.system.service.SysParamService;
import org.springframework.stereotype.Repository;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/6
 * @desc
 */
@Repository
public class SysParamConfig {

    @Resource
    private SysParamService sysParamService;

    @PostConstruct
    public void init() {
        //FastJson支持@Type等自动类型转换。
        ParserConfig.getGlobalInstance().setAutoTypeSupport(true);
        System.out.println("-----加载系统参数数据开始-----");
        List<SysParam> list = sysParamService.getAllSysParam();
        for (int i = 0; i < list.size(); i++) {
            SysParam param = list.get(i);
            ConstantParam.paramMap.put(param.getCode(), param.getValue());
        }
        System.out.println("-----加载系统参数据结束-----");
    }
}
