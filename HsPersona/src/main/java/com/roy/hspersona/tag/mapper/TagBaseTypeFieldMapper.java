package com.roy.hspersona.tag.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.roy.hspersona.tag.entity.TagBaseTypeField;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

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
public interface TagBaseTypeFieldMapper extends BaseMapper<TagBaseTypeField> {
    @Select("SELECT  " +
            "  baseTypeField.id,  " +
            "  element.CODE,  " +
            "  element.NAME,  " +
            "  baseTypeField.selfTypeId   " +
            "FROM  " +
            "  tag_base_type AS baseType  " +
            "  INNER JOIN tag_base_type_field AS baseTypeField ON baseTypeField.belongTypeId = baseType.id  " +
            "  INNER JOIN tag_data_type_element AS element ON baseTypeField.typeElementId = element.id  " +
            "  LEFT JOIN (  " +
            "  SELECT  " +
            "    extType.CODE,  " +
            "    extTypeField.typeElementId   " +
            "  FROM  " +
            "    tag_ext_type AS extType  " +
            "    INNER JOIN tag_ext_type_field AS extTypeField ON extType.id = extTypeField.belongTypeId   " +
            "  WHERE  " +
            "    extType.industryType =#{industryType}   " +
            "  ) AS ext ON baseType.CODE = ext.CODE   " +
            "  AND baseTypeField.typeElementId = ext.typeElementId   " +
            "WHERE  " +
            "  baseType.id =#{typeId}   " +
            "  AND ext.CODE IS NULL")
    List<Map<String, Object>> getUnSelectField(String typeId, int industryType);
}
