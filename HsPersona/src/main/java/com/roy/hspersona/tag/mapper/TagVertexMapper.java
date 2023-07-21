package com.roy.hspersona.tag.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.roy.hspersona.tag.entity.TagVertex;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public interface TagVertexMapper extends BaseMapper<TagVertex> {

    @Select("SELECT DISTINCT t.* " +
            "FROM TAG_EDGE e " +
            "inner join TAG_CALCULATE_SELECT s on e.VERTEXAID=s.TAGID " +
            "inner join TAG_CALCULATE c on s.CALCULATEID=c.ID  " +
            "inner join TAG_VERTEX t on e.VERTEXBID=t.ID  " +
            "where c.userId= #{userId} " +
            "and e.type = 1 and t.type = 4 " +
            "and t.name like '%${tagName}%' " +
            "order by rand() ")
    List<TagVertex> getTagVertexRandomByUserAndLikeTagName(@Param("userId") String userId, @Param("tagName")String tagName);

    @Select("SELECT " +
            "  tagVertex.* " +
            "FROM " +
            "  tag_edge AS tagEdge ,tag_vertex AS tagVertex " +
            "WHERE " +
            "  tagEdge.vertexBid = tagVertex.id " +
            "  AND tagEdge.vertexAid = ( " +
            "  SELECT " +
            "    T.vertexAid  " +
            "  FROM " +
            "    tag_edge AS T,tag_vertex V   " +
            "  WHERE " +
            "    T.vertexBid = V.id " +
            "    AND V.name = #{searchKey} " +
            "    AND V.type = #{tagVertexType}  " +
            "  AND V.ENABLE = #{enable}  " +
            "  )")
    List<TagVertex> getBrotherTagByTagName(@Param("searchKey")String searchKey,@Param("tagVertexType") int tagVertexType,@Param("enable") int enable);
}
