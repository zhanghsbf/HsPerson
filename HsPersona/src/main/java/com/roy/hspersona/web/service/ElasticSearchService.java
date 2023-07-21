package com.roy.hspersona.web.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.roy.hspersona.core.base.MyException;
import com.roy.hspersona.tag.entity.TagVertex;
import com.roy.hspersona.web.entity.DataVO;
import com.roy.hspersona.web.entity.SearchResultEs;
import com.roy.hspersona.web.mapper.ElasticSearchDao;
import org.apache.commons.lang3.StringUtils;
import org.apache.lucene.queryparser.xml.builders.BooleanQueryBuilder;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.join.ScoreMode;
import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.get.GetResponse;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchRequestBuilder;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.action.search.SearchType;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.transport.TransportClient;
import org.elasticsearch.core.TimeValue;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.NestedQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.SearchHits;
import org.elasticsearch.search.aggregations.AggregationBuilder;
import org.elasticsearch.search.aggregations.AggregationBuilders;
import org.elasticsearch.search.aggregations.BucketOrder;
import org.elasticsearch.search.aggregations.bucket.filter.Filter;
import org.elasticsearch.search.aggregations.bucket.filter.Filters;
import org.elasticsearch.search.aggregations.bucket.filter.ParsedFilters;
import org.elasticsearch.search.aggregations.bucket.nested.Nested;
import org.elasticsearch.search.aggregations.bucket.terms.Terms;
import org.elasticsearch.search.builder.SearchSourceBuilder;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @author roy
 * @date 2021/12/15
 * @desc
 */
@Service
public class ElasticSearchService {

    @Resource
    private ElasticSearchDao elasticSearchDao;

    public SearchResultEs<DataVO> getData(Map<String, Object> params, int page, int rows) throws IOException {
        SearchResultEs<DataVO> sr = new SearchResultEs<>();
        RestHighLevelClient esClient = null;
        try {
            //构建客户端
            esClient = elasticSearchDao.getEsClient();
            //构建searchRequest
            String esIndexName = elasticSearchDao.getEsIndexName();
            SearchRequest searchRequest = new SearchRequest();
            searchRequest.indices(esIndexName);

            SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
            searchSourceBuilder.timeout(new TimeValue(200));

            BoolQueryBuilder query = QueryBuilders.boolQuery();

            for(String key: params.keySet()){
                if (StringUtils.isNotEmpty((String) params.get(key))) {
                    if ("@tag.tagName".equals(key)) {
                        BoolQueryBuilder subquery = QueryBuilders.boolQuery()
                        .must(QueryBuilders.matchQuery("@tag.tagName", (String) params.get(key)))
                        .must(QueryBuilders.matchQuery("@tag.isLatest","1"));

                        query.must(QueryBuilders.nestedQuery("@tag",subquery, ScoreMode.None));
                    } else {
                        //模糊匹配
                        List<String> valueList = elasticSearchDao.splitStrToChineseCharNumStrTextStr((String) params.get(key));
                        for (int j = 0; j < valueList.size(); j++) {
                            query.must(QueryBuilders.wildcardQuery(key+".keyword", "*" + valueList.get(j).toLowerCase() + "*"));
                        }
                    }
                }
            }
            searchSourceBuilder.query(query);
            searchSourceBuilder.from((page - 1) * rows).size(rows);
//            searchSourceBuilder.aggregation()
            searchRequest.source(searchSourceBuilder);
            //查询
            SearchResponse actionGet = esClient.search(searchRequest, RequestOptions.DEFAULT);
            //处理结果
            List<DataVO> list = new ArrayList<DataVO>();
            SearchHits hits = actionGet.getHits();
            for (int i = 0; i < hits.getHits().length; i++) {
                SearchHit hit = hits.getAt(i);
                DataVO vo = new DataVO();
                vo.setId(hit.getId());
                vo.setScore(hit.getScore());
                vo.setVersion(hit.getVersion());
                vo.setSource(hit.getSourceAsString());
                list.add(vo);
            }
            sr.setResultList(list);
            sr.setCount(hits.getTotalHits().value);
        } catch (MyException e) {
            e.printStackTrace();
        } finally {
            if (esClient != null) {
                esClient.close();
            }
        }
        return sr;
    }

    public JSONArray getTagAggForSearch(Map<String, Object> params, int page, int rows) throws IOException {
        RestHighLevelClient esClient = null;
        JSONArray jsonArray = new JSONArray();
        try {
            esClient = elasticSearchDao.getEsClient();

            //构建客户端
            esClient = elasticSearchDao.getEsClient();
            //构建searchRequest
            String esIndexName = elasticSearchDao.getEsIndexName();
            SearchRequest searchRequest = new SearchRequest();
            searchRequest.indices(esIndexName);

            SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
            searchSourceBuilder.timeout(new TimeValue(200));

            BoolQueryBuilder query = QueryBuilders.boolQuery();

            AggregationBuilder tagAgg = AggregationBuilders.nested("tagAggs","@tag")
                    .subAggregation(
                            AggregationBuilders.filter("tagFilter",QueryBuilders.termQuery("@tag.isLatest", "1"))
                                .subAggregation(AggregationBuilders.terms("tagAgg").field("@tag.unionTagId").size(rows).order(BucketOrder.count(false)))
                    );
            for(String key: params.keySet()){
                if (StringUtils.isNotEmpty((String) params.get(key))) {
                    if ("@tag.tagName".equals(key)) {
                        BoolQueryBuilder subquery = QueryBuilders.boolQuery()
                                .must(QueryBuilders.matchQuery("@tag.tagName", (String) params.get(key)))
                                .must(QueryBuilders.matchQuery("@tag.isLatest","1"));

                        query.must(QueryBuilders.nestedQuery("@tag",subquery, ScoreMode.None));
                    } else {
                        //模糊匹配
                        List<String> valueList = elasticSearchDao.splitStrToChineseCharNumStrTextStr((String) params.get(key));
                        for (int j = 0; j < valueList.size(); j++) {
                            query.must(QueryBuilders.wildcardQuery(key+".keyword", "*" + valueList.get(j).toLowerCase() + "*"));
                        }
                    }
                }
            }
            searchSourceBuilder.query(query);
            searchSourceBuilder.from((page - 1) * rows).size(rows);
            searchSourceBuilder.aggregation(tagAgg);
            searchRequest.source(searchSourceBuilder);
            //查询
            SearchResponse actionGet = esClient.search(searchRequest, RequestOptions.DEFAULT);

            // 获取嵌套mapping节点
            Nested agg = actionGet.getAggregations().get("tagAggs");
            Filter filter = agg.getAggregations().get("tagFilter");
            Terms ruleAggTerms = filter.getAggregations().get("tagAgg");

            // 遍历查询结果，
            for (Terms.Bucket entry : ruleAggTerms.getBuckets()) {
                String key = (String) entry.getKey();
                long docCount = entry.getDocCount();
                if (StringUtils.isNotEmpty(key)) {
                    try {
                        // 切割 unionTagId 其形式为 tagId_ruleTagId;
                        String[] keys = key.split("_");
                        // 该序号和实际序号相差1 实际序号从0开始，本地序号从1开始
                        String index = keys[0];
                        String ruleTagId = keys[1];
                        StringBuffer tagAggBuffer = new StringBuffer();
                        tagAggBuffer.append("{\"ruleTagId\":\"").append(ruleTagId).append("\",\"tagIndex\":\"").append(index).append("\",\"docCount\":\"")
                                .append(docCount).append("\"}");
                        JSONObject jsonObject = JSONObject.parseObject(tagAggBuffer.toString());
                        jsonArray.add(jsonObject);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 关闭
            if (esClient != null) {
                esClient.close();
            }
        }
        return jsonArray;
    }

    public JSONArray getBrotherTagNodeProportionAgg(List<TagVertex> tagVertexs) throws IOException {
        RestHighLevelClient esClient = null;
        JSONArray jsonArray = new JSONArray();
        try {
            //构建客户端
            esClient = elasticSearchDao.getEsClient();
            //构建searchRequest
            String esIndexName = elasticSearchDao.getEsIndexName();
            SearchRequest searchRequest = new SearchRequest();
            searchRequest.indices(esIndexName);

            SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
            searchSourceBuilder.timeout(new TimeValue(200));

            BoolQueryBuilder query = QueryBuilders.boolQuery();
            // 查询所有的可用标签
            query.must(QueryBuilders.termQuery("@tag.isLatest", 1));
            NestedQueryBuilder nestedQueryBuilder = new NestedQueryBuilder("@tag", query,ScoreMode.None);
            AggregationBuilder tagAgg = AggregationBuilders.nested("tagAggs","@tag");

            // 对每个信息进行聚合
            for (int i = 0; i < tagVertexs.size(); i++) {
                tagAgg.subAggregation(
                        AggregationBuilders.filters("tagFilter_" + tagVertexs.get(i).getId()
                                ,QueryBuilders.termQuery("@tag.isLatest", "1")
                                ,QueryBuilders.termQuery("@tag.tagName", tagVertexs.get(i).getName()))
                                .subAggregation(AggregationBuilders.terms("tagAgg").field("@tag.unionTagId").order(BucketOrder.count(false))));
            }

            searchSourceBuilder.query(nestedQueryBuilder);
            searchSourceBuilder.aggregation(tagAgg);
            searchRequest.source(searchSourceBuilder);
            //查询
            SearchResponse actionGet = esClient.search(searchRequest, RequestOptions.DEFAULT);
            Nested agg = actionGet.getAggregations().get("tagAggs");
            for (int i = 0; i < tagVertexs.size(); i++) {
                long docCount = 0 ;
                ParsedFilters filter = agg.getAggregations().get("tagFilter_" + tagVertexs.get(i).getId());
                JSONObject jsonObject = new JSONObject();
                jsonObject.put("tagId", tagVertexs.get(i).getId());
                jsonObject.put("tagName", tagVertexs.get(i).getName());
                for (Filters.Bucket bucket : filter.getBuckets()) {
                    //只要取最后一个
                    docCount = bucket.getDocCount();
                }
                jsonObject.put("count", docCount);
                jsonArray.add(jsonObject);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 关闭
            if (esClient != null) {
                esClient.close();
            }
        }
        return jsonArray;
    }

    public DataVO getNodeById(String id) throws IOException {
        DataVO vo = null;
        RestHighLevelClient esClient = null;
        try {
            esClient = elasticSearchDao.getEsClient();
            GetRequest getRequest = new GetRequest(elasticSearchDao.getEsIndexName());
            getRequest.id(id);
            GetResponse response = esClient.get(getRequest, RequestOptions.DEFAULT);
            if (response.isExists()) {
                vo = new DataVO();
                vo.setId(response.getId());
                vo.setVersion(response.getVersion());
                vo.setSource(JSON.toJSONString(response.getSource()));
            }
        } catch (MyException | IOException e) {
            e.printStackTrace();
        }finally {
            if(null != esClient){
                esClient.close();
            }
        }
        return vo;
    }
}
