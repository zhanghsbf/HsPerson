package com.roy.hspersona.etl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.etl.entity.EtlJsonConfig;
import com.roy.hspersona.etl.mapper.EtlJsonConfigMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/9
 * @desc
 */
@Service
public class EtlJsonConfigService {

    @Resource
    private EtlJsonConfigMapper etlJsonConfigMapper;

    public Page<EtlJsonConfig> getEtlJsonConfig(Map<String, Object> map, long page, long rows) {
        Page<EtlJsonConfig> pager = new Page<>(page,rows);
        QueryWrapper<EtlJsonConfig> queryWrapper = new QueryWrapper<>();
        
        if (  StringUtils.isNotEmpty((String) map.get("etlName"))) {
            queryWrapper.like("etlName","%" + map.get("etlName") + "%");
        }
        if (  StringUtils.isNotEmpty((String) map.get("userId"))) {
            queryWrapper.eq("userId", map.get("userId"));
        }
        if (  StringUtils.isNotEmpty((String) map.get("enable"))) {
            queryWrapper.eq("enable",map.get("enable"));
        }
        return etlJsonConfigMapper.selectPage(pager,queryWrapper);
    }

    public EtlJsonConfig getEtlJsonConfigById(String id) {
        return etlJsonConfigMapper.selectById(id);
    }

    public void updateEtlJsonConfig(EtlJsonConfig etlJsonConfig) {
        etlJsonConfigMapper.updateById(etlJsonConfig);
    }

    public void saveEtlJsonConfig(EtlJsonConfig config) {
        etlJsonConfigMapper.insert(config);
    }
}
