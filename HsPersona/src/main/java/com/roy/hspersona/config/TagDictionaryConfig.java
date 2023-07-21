package com.roy.hspersona.config;

import com.roy.hspersona.common.ConstantDict;
import com.roy.hspersona.tag.entity.TagDictionary;
import com.roy.hspersona.tag.service.TagBaseTypeFieldService;
import com.roy.hspersona.tag.service.TagDictionaryService;
import org.springframework.stereotype.Repository;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/6
 * @desc
 */
@Repository
public class TagDictionaryConfig {

    @Resource
    private TagDictionaryService tagDictionaryService;

    @PostConstruct
    public void init(){
        System.out.println("-----加载系统参数数据开始-----");

        try {
            List<TagDictionary> list = tagDictionaryService.getAllTagDictionary();
            String key = "";//
            Map<String, String> tagValueMap = new HashMap<String, String>();
            for (int i = 0; i < list.size(); i++) {
                TagDictionary tagDictionary = list.get(i);
                String type = tagDictionary.getType();
                // 如果不是第一条，且type不等于标杆key的时候，意味着进入另外一个字典
                if (i != 0 && !key.equals(type)) {
                    ConstantDict.tagDictMap.put(key, tagValueMap);
                    tagValueMap = new HashMap<String, String>();
                    key = type;
                }
                tagValueMap.put(tagDictionary.getItemValue(), tagDictionary.getItemName());
                if (i == list.size() - 1) {
                    ConstantDict.tagDictMap.put(key, tagValueMap);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("-----加载系统参数据结束-----");
    }
}
