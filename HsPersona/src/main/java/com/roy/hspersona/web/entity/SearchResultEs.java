package com.roy.hspersona.web.entity;

import java.util.ArrayList;
import java.util.List;

/**
 * @author roy
 * @date 2021/12/16
 * @desc
 */
public class SearchResultEs<T> {

    /**
     * 符合条件的总记录条数
     */
    long count;

    /**
     * 符合条件的本页的记录集
     */
    List<T> resultList;

    public SearchResultEs() {
        this.count = 0;
        this.resultList = new ArrayList<T>();
    }

    /**
     * @return Returns the count.
     */
    public long getCount() {
        return count;
    }

    /**
     * @param count The count to set.
     */
    public void setCount(long count) {
        this.count = count;
    }

    /**
     * @return Returns the resultList.
     */
    public List<T> getResultList() {
        return resultList;
    }

    /**
     * @param resultList The resultList to set.
     */
    public void setResultList(List<T> resultList) {
        this.resultList = resultList;
    }
}
