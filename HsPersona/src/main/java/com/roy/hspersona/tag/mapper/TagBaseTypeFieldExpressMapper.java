package com.roy.hspersona.tag.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagBaseTypeFieldExpress;

import java.util.List;
import java.util.Map;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public interface TagBaseTypeFieldExpressMapper extends BaseMapper<TagBaseTypeFieldExpress> {


    List<TagBaseTypeFieldExpress> selectTagBaseTypeFiledExpress(Page<TagBaseTypeFieldExpress> pager, Map<String, Object> map);
}
