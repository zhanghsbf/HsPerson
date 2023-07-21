package com.roy.hspersona.tag.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.roy.hspersona.tag.entity.TagExtTypeField;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public interface TagExtTypeFieldMapper extends BaseMapper<TagExtTypeField> {


    @Select("<script> " +
            "select f.*" +
            "  from tag_ext_type_field f,tag_ext_type t " +
            "  where f.selfTypeId = t.id " +
            "  and f.belongTypeId in " +
            "     <foreach item='belongTypeId' index='index' collection='ids' open='(' separator=',' close=')'> " +
            "           #{belongTypeId} " +
            "     </foreach> " +
            "  and t.type in " +
            "    <foreach item='type' index='index' collection='types' open='(' separator=',' close=')'> " +
            "           #{type} " +
            "     </foreach> " +
            "</script>")
    Page<TagExtTypeField> selectByBelongExtTypeIdAndTypes(Page<TagExtTypeField> pager, @Param("ids") List<String> ids, @Param("types") List<Integer> types);

    @Select(" select f.* " +
            "  from tag_ext_type_field f,tag_ext_type t,tag_data_type_element e " +
            "  where f.belongTypeId = t.id and f.typeElementId = e.id " +
            "   and t.code = #{belongTypeCode} and e.code= #{dataTypeElementCode}")
    Page<TagExtTypeField> getExtTypeFieldByBelongTypeCodeandDataCode(String belongTypeCode, String dataTypeElementCode);
}
