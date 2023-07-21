package com.roy.hspersona.es;

import org.apache.http.HttpHost;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.TotalHits;
import org.apache.lucene.search.join.ScoreMode;
import org.elasticsearch.action.search.SearchRequest;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestClientBuilder;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.core.TimeValue;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.builder.SearchSourceBuilder;

import java.io.IOException;

/**
 * @author roy
 * @date 2021/12/16
 * @desc
 */
public class EsClientTest {

    public static void main(String[] args) throws IOException {
        HttpHost[] esHosts = new HttpHost[] { new HttpHost("hadoop01", 9200),
                new HttpHost("hadoop02", 9200),
                new HttpHost("hadoop03", 9200)};
        //1、构建客户端
        RestClientBuilder restClient = RestClient.builder(esHosts);
        RestHighLevelClient client = new RestHighLevelClient(restClient);
        //2、构建searchRequest --扩展
        BoolQueryBuilder must = QueryBuilders.boolQuery();
        //普通类型直接查询
//        must.must(QueryBuilders.matchQuery("DS_USER_ID","5"));
        //nested类型的嵌套查询需要增加一层NestedQuery，不能直接查。
//        must.must(QueryBuilders.matchQuery("@tag.tagName","80后"));
//        BoolQueryBuilder subquery = QueryBuilders.boolQuery()
//                .must(QueryBuilders.matchQuery("@tag.tagName", "70后"))
//                .must(QueryBuilders.matchQuery("@tag.isLatest","1"));
//
//        must.must(QueryBuilders.nestedQuery("@tag",subquery, ScoreMode.None));

        must.must(QueryBuilders.wildcardQuery("DS_USER_HOMEADDR.keyword","湖南省*"));


        SearchSourceBuilder searchSourceBuilder = new SearchSourceBuilder();
        searchSourceBuilder.query(must);
        searchSourceBuilder.timeout(new TimeValue(200));

        SearchRequest searchRequest = new SearchRequest();
        searchRequest.indices("hspersona_esdb");
        searchRequest.source(searchSourceBuilder);

        //3、实际进行查询 -- 固定
        SearchResponse resp = client.search(searchRequest, RequestOptions.DEFAULT);
        //4、处理sarchResponse --扩展
        TotalHits totalHits = resp.getHits().getTotalHits();
        System.out.println("总匹配记录："+totalHits.value);
        for (SearchHit hit : resp.getHits()) {
            System.out.println(hit.docId());
            System.out.println(hit.getScore());
            System.out.println(hit.getSourceAsString());
            System.out.println("=========");
        }
        client.close();
    }
}
