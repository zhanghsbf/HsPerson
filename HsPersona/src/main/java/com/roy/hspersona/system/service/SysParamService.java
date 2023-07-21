package com.roy.hspersona.system.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.system.entity.SysParam;
import com.roy.hspersona.system.mapper.SysParamMapper;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/5
 * @desc
 */
@Service
public class SysParamService {

    @Resource
    private SysParamMapper sysParamMapper;

    public Page<SysParam> getParam(Map<String, Object> map, long page, long rows) {
        Page<SysParam> pager = new Page<>(page,rows);
        QueryWrapper<SysParam> queryWrapper = new QueryWrapper<>();
        if (StringUtils.isNotEmpty((String) map.get("code"))) {
            queryWrapper.like("code","%" + map.get("code") + "%");
        }
        if (StringUtils.isNotEmpty((String) map.get("value"))) {
            queryWrapper.eq("value",map.get("value"));
        }
        if (StringUtils.isNotEmpty((String) map.get("memo"))) {
            queryWrapper.like("memo","%" + map.get("memo") + "%");
        }
        if (map.get("enable") != null) {
            queryWrapper.eq("enable",map.get("enable"));
        }
        return sysParamMapper.selectPage(pager,queryWrapper);
    }

    public SysParam getSysParamById(String id) {
        return sysParamMapper.selectById(id);
    }

    public String deleteSysParamById(String id) {
        sysParamMapper.deleteById(id);
        return "";
    }

    public SysParam getParamByCode(String code) {
        QueryWrapper<SysParam> queryWrapper = new QueryWrapper<>();
            queryWrapper.eq("code",code);
        final List<SysParam> list = sysParamMapper.selectList(queryWrapper);
        return (list.size() == 0) ? null : list.get(0);
    }

    public void saveSysParam(SysParam param) {
        sysParamMapper.insert(param);
    }

    public void updateSysParam(SysParam param) {
        sysParamMapper.updateById(param);
    }

    public List<SysParam> getAllSysParam() {
        return sysParamMapper.selectList(null);
    }
}
