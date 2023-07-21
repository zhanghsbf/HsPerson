package com.roy.hspersona.tag.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagBaseType;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;

import java.util.Map;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public interface TagBaseTypeMapper extends BaseMapper<TagBaseType> {

    @Select("SELECT " +
            " baseType.id, " +
            " baseType.CODE, " +
            " baseType.NAME, " +
            " parent.CODE AS parentTypeCode, " +
            " baseType.type  " +
            "FROM " +
            " tag_base_type AS baseType " +
            " LEFT JOIN tag_base_type AS parent ON baseType.parentTypeId = parent.id " +
            " LEFT JOIN ( SELECT CODE FROM tag_ext_type WHERE industryType = #{industryType} AND type IN ( 1, 2 ) ) AS ext ON baseType.CODE = ext.CODE  " +
            "WHERE " +
            " ext.CODE IS NULL  " +
            " AND baseType.CODE LIKE '%${typeCode}%'  " +
            "ORDER BY " +
            " baseType.treeCode")
    Page<Map<String, Object>> getUnSelectType(Page<Map<String, Object>> pager, int industryType, String typeCode);
}
