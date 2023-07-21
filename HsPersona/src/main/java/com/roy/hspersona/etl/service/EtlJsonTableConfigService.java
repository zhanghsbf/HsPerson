package com.roy.hspersona.etl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.roy.hspersona.etl.entity.EtlJsonTableConfig;
import com.roy.hspersona.etl.mapper.EtlJsonTableConfigMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/9
 * @desc
 */
@Service
public class EtlJsonTableConfigService {

    @Resource
    private EtlJsonTableConfigMapper etlJsonTableConfigMapper;

    public List<EtlJsonTableConfig> getEtlJsonTableConfigByConfigId(String configId) {
        QueryWrapper<EtlJsonTableConfig> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("configId",configId);
        return etlJsonTableConfigMapper.selectList(queryWrapper);
    }

    public EtlJsonTableConfig getEtlJsonTableConfigById(String id) {
        return etlJsonTableConfigMapper.selectById(id);
    }

    public void deleteEtlJsonTableConfigById(String id) {
        etlJsonTableConfigMapper.deleteById(id);
    }

    public void saveEtlJsonTableConfig(EtlJsonTableConfig config) {
        etlJsonTableConfigMapper.insert(config);
    }

    public void updateEtlJsonTableConfig(EtlJsonTableConfig config) {
        etlJsonTableConfigMapper.updateById(config);
    }
}
