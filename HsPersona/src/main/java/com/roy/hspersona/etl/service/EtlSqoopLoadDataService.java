package com.roy.hspersona.etl.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.etl.entity.EtlSqoopLoadData;
import com.roy.hspersona.etl.mapper.EtlSqoopLoadDataMapper;
import com.roy.hspersona.util.DateUtil;
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
public class EtlSqoopLoadDataService {

    @Resource
    private EtlSqoopLoadDataMapper etlSqoopLoadDataMapper;

    public Page<EtlSqoopLoadData> getEtlSqoopLoadData(Map<String, Object> map, long page, long rows) {
        Page<EtlSqoopLoadData> pager = new Page<>(page,rows);
        QueryWrapper<EtlSqoopLoadData> queryWrapper = new QueryWrapper<>();

        List<Object> paramList = new ArrayList<Object>();
        StringBuffer hql = new StringBuffer();
        hql.append(" from EtlSqoopLoadData where 1=1 ");
        if(StringUtils.isNotEmpty((String)map.get("name"))){
            queryWrapper.like("name","%" + map.get("name") + "%");
        }
        if(StringUtils.isNotEmpty((String)map.get("userId"))){
            queryWrapper.eq("userId",map.get("userId"));
        }
        if(StringUtils.isNotEmpty((String)map.get("enable"))){
            queryWrapper.eq("enable",map.get("enable"));
        }
        if (StringUtils.isNotEmpty((String) map.get("startTime"))) {
            queryWrapper.gt("createDate",DateUtil.toDate((String)map.get("startTime"), "yyyy-MM-dd HH:mm:ss"));
        }
        if (StringUtils.isNotEmpty((String) map.get("endTime"))) {
            queryWrapper.le("createDate", DateUtil.toDate((String)map.get("endTime"), "yyyy-MM-dd HH:mm:ss"));
        }
        return etlSqoopLoadDataMapper.selectPage(pager,queryWrapper);
    }

    public void saveEtlSqoopLoadData(EtlSqoopLoadData etlSqoopLoadData) {
        etlSqoopLoadDataMapper.insert(etlSqoopLoadData);
    }

    public EtlSqoopLoadData getEtlSqoopLoadDataById(String id) {
        return etlSqoopLoadDataMapper.selectById(id);
    }

    public void updateEtlSqoopLoadData(EtlSqoopLoadData etlSqoopLoadData) {
        etlSqoopLoadDataMapper.updateById(etlSqoopLoadData);
    }
}
