package com.roy.hspersona.web.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.common.Constant;
import com.roy.hspersona.tag.entity.TagDictionary;
import com.roy.hspersona.tag.entity.TagVertex;
import com.roy.hspersona.tag.service.TagBaseTypeService;
import com.roy.hspersona.tag.service.TagExtTypeService;
import com.roy.hspersona.tag.service.TagVertexService;
import com.roy.hspersona.util.PagerUtil;
import com.roy.hspersona.web.entity.DataVO;
import com.roy.hspersona.web.entity.PersonVO;
import com.roy.hspersona.web.entity.SearchResultEs;
import com.roy.hspersona.web.service.ElasticSearchService;
import com.roy.hspersona.web.service.PersonService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/15
 * @desc
 */
@Controller
@RequestMapping("/web/search")
public class SearchController extends WebBaseController{

    @Resource
    private TagVertexService tagVertexService;
    @Resource
    private TagExtTypeService tagExtTypeService;
    @Resource
    private TagBaseTypeService tagBaseTypeService;
    @Resource
    private PersonService personService;

    @Resource
    private ElasticSearchService elasticSearchService;

    @RequestMapping("/search")
    public String search(HttpSession session, Model model){
        // 获取类型云词
        String userId = this.getAccountSession(session).getUserId();

        // 随机获取标签,此处为本用户计算过的标签
        List<TagVertex> vertexList = tagVertexService.getTagVertexRandomByUserAndLikeTagName(userId, "");
        model.addAttribute("tags",JSONArray.toJSONString(vertexList));

        // 获取类型
        JSONArray types = new JSONArray();
        types.addAll(tagExtTypeService.getSelectTagExtType());
        types.addAll(tagBaseTypeService.getSelectTagBaseType());
        model.addAttribute("types",types);
        return "web/main";
    }

    @ResponseBody
    @RequestMapping("/init")
    public Object init(String searchKey, @RequestParam(defaultValue = "@tag.tagName") String searchCode,
                       @RequestParam(defaultValue = "1")int page, @RequestParam(defaultValue = ""+Constant.PAGE_SIZE)int rows,
                       @RequestParam(defaultValue = "10") int topTagCount,HttpSession session) throws IOException {
        /*
         * 获取参数并初始化
         */
        if (StringUtils.isEmpty(searchKey.trim())) {
            return this.outFailJson("搜索信息为空");
        }

        /*
         * 获取搜索的数据
         */
        Map<String, Object> map = new HashMap<>();
        map.put(searchCode, searchKey);
        SearchResultEs<DataVO> datas = elasticSearchService.getData(map, page, rows);
        if (datas.getCount() == 0) {
            return this.outFailJson("未搜索到相关信息！");
        }

        /*
         * 逐条翻译数据
         */
        List<DataVO> searchResultList = datas.getResultList();
        // 翻译数据
        List<PersonVO> personVOList = personService.getPersonVOByDataVOs(searchResultList);
        if (personVOList == null) {
            return this.outFailJson("未搜索到相关信息！");
        }
        // 将列表视图数据转换成json格式
        JSONArray personListVOJson = JSONArray.parseArray(JSON.toJSONString(personVOList));

        /*
         * 计算翻页的相关数据
         */
        long total = datas.getCount();// 数据总数
        JSONObject pagerInfo = PagerUtil.pagNumCalcute(page, total, rows);

        /*
         * 获取top10 的包含名称标签统计//标签top-10统计数据,不包含tagName,需要处理
         */
        JSONArray tagTopAggrJsonArr = elasticSearchService.getTagAggForSearch(map, page, topTagCount);
        JSONArray tagNameAggrArr = tagVertexService.getTagVertextNameForTagTop(tagTopAggrJsonArr);
        JSONArray brotherTagAgg = new JSONArray();

        /*
         * 若是查询的标签信息，则直接将兄弟节点标签占比进行统计
         */
        if ("@tag.tagName".equals(searchCode)) {// 如果查询的是标签信息
            // 获取兄弟节点信息
            List<TagVertex> tagVertexs = tagVertexService.getBrotherTagByTagName(searchKey);
            // 查询同一ruleId节点的Tag节点聚合信息
            brotherTagAgg = elasticSearchService.getBrotherTagNodeProportionAgg(tagVertexs);
        }
        /*
         * 返回数据
         */
        Map<String,Object> res = new HashMap<>();
        res.put("pager",pagerInfo);
        res.put("rows",personListVOJson);
        res.put("tagTop",tagNameAggrArr);
        res.put("tagPie",brotherTagAgg);
        return res;
    }

//    public String matchSearch() {
//        // 默认情况下，搜索匹配都从1开始
//        String key = this.getStrParam("key");
//        String code = this.getStrParam("code");
//        String userId = this.getAccountSession().getUserId();
//
//        if (StringUtils.isEmpty(code) || StringUtils.isEmpty(key)) {
//            return null;
//        }
//        // 标签
//        JSONArray json = null;
//        List<KeyValue> keyValues = new ArrayList<KeyValue>();
//        if ("@tag.tagName".equals(code)) {
//            List<DynaBean> vertexList = tagVertexService.getTagVertexRandomByUserAndLikeTagName(userId, key);
//
//            for (DynaBean tagVertex : vertexList) {
//                // 标签直接一样即可,其中key为所传之值，value为显示的值
//                keyValues.add(new KeyValue((String) tagVertex.get("name"), (String) tagVertex.get("name")));
//            }
//
//        } else {
//            // 属性，查询字典表
//            String[] codes = code.split("\\.");
//            // 获取code的最后一个
//            code = codes[codes.length - 1];
//            // 查字典表模糊查询
//            SearchResult<TagDictionary> tSearchResult = tagDictionaryService.getTagDictionaryByTypeAndLikeName(code, key, 1, Constant.PAGE_SIZE);
//            for (TagDictionary tagDictionary : tSearchResult.getResultList()) {
//                keyValues.add(new KeyValue((String) tagDictionary.getItemValue(), (String) tagDictionary.getItemName()));
//            }
//        }
//        json = JSONArray.fromObject(keyValues, this.getJsonConfig());
//        if (json != null) {
//            this.outJson(json.toString());
//        }
//        return null;
//    }
}
