package com.roy.hspersona.config;

import com.roy.hspersona.common.ConstantTag;
import com.roy.hspersona.tag.entity.TagDataTypeElement;
import com.roy.hspersona.tag.service.TagDataTypeElementService;
import org.springframework.stereotype.Repository;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/6
 * @desc
 */
@Repository
public class ElementMapConfig {

    @Resource
    private TagDataTypeElementService tagDataTypeElementService;

    @PostConstruct
    public void init(){
        System.out.println("-----加载标签元素数据开始-----");
        List<TagDataTypeElement> tagDataTypeElements = tagDataTypeElementService.getAllTagDataTypeElements();
        //设置元素全局数组
        for(int i=0;i<tagDataTypeElements.size();i++){
            ConstantTag.elementMap.put(tagDataTypeElements.get(i).getCode(), tagDataTypeElements.get(i).getName());
        }
        System.out.println("-----加载标签元素数据结束-----");
    }
}
