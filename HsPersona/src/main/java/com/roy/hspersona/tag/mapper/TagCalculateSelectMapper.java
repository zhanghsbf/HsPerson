package com.roy.hspersona.tag.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.roy.hspersona.tag.entity.TagCalculateSelect;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

/**
 * <p>
 * 用户计算标签选择表 Mapper 接口
 * </p>
 *
 * @author roy
 * @since 2021-11-30
 */
public interface TagCalculateSelectMapper extends BaseMapper<TagCalculateSelect> {

    @Update("update tag_calculate_select set tagContent=#{tagContent} where tagId=#{tagId}")
    void updateTagCalSelect(@Param("tagContent") String tagContent, @Param("tagId") String tagId);
}
