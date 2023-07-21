package com.roy.hspersona.etl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.etl.entity.EtlDatabaseSource;
import com.roy.hspersona.etl.mapper.EtlDatabaseSourceMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/8
 * @desc
 */
@Service
public class EtlDatabaseSourceService {

    @Resource
    private EtlDatabaseSourceMapper etlDatabaseSourceMapper;

    public Page<EtlDatabaseSource> getEtlDatabaseSource(String userId, String alias, long page, long rows) {
        Page<EtlDatabaseSource> pager = new Page<>(page, rows);
        QueryWrapper<EtlDatabaseSource> queryWrapper = new QueryWrapper<>();

        if (StringUtils.isNotEmpty(userId)) {
            queryWrapper.eq("userId",userId);
        }
        if (StringUtils.isNotEmpty(alias)) {
            queryWrapper.like("alias","%"+alias+"%");
        }
        return etlDatabaseSourceMapper.selectPage(pager,queryWrapper);
    }

    public void deleteEtlDatabaseSourceById(String id) {
        etlDatabaseSourceMapper.deleteById(id);
    }

    public void saveEtlDatabaseSource(EtlDatabaseSource dbSource) {
        etlDatabaseSourceMapper.insert(dbSource);
    }

    public EtlDatabaseSource getEtlDatabaseSourceById(String id) {
        return etlDatabaseSourceMapper.selectById(id);
    }

    public void updateEtlDatabaseSource(EtlDatabaseSource dbSource) {
        etlDatabaseSourceMapper.updateById(dbSource);
    }

    public List<EtlDatabaseSource> getEtlDatabaseSourceByUserId(String userId) {
        QueryWrapper<EtlDatabaseSource> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("userId",userId);
        return etlDatabaseSourceMapper.selectList(queryWrapper);
    }
}
