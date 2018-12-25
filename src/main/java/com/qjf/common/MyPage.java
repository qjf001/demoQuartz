package com.qjf.common;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2017/3/19 0019.
 */
public class MyPage<E> implements Serializable {

    private static final long serialVersionUID = 1L;
    private int pageNum;
    private int pageSize;
    private long total;
    private long pages;
    private List<E> result;

    public MyPage() { }

    public MyPage(com.baomidou.mybatisplus.plugins.Page page) {
        this.result = page.getRecords();
        this.pageNum = page.getCurrent();
        this.pageSize = page.getSize();
        this.total = page.getTotal();
        this.pages = page.getPages();
    }

    public long getPages() {
        return this.pages;
    }

    public int getPageNum() {
        return this.pageNum;
    }

    public void setPageNum(int pageNum) {
        this.pageNum = pageNum <= 0 ? 1 : pageNum;
    }

    public int getPageSize() {
        return this.pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public long getTotal() {
        return this.total;
    }

    public void setTotal(long total) {
        this.total = total;
        if (this.pageSize > 0) {
            this.pages = (int) (total / (long) this.pageSize + (long) (total % (long) this.pageSize == 0L ? 0 : 1));
        } else {
            this.pages = 0;
        }

        if (this.pageNum > this.pages) {
            this.pageNum = Long.signum(this.pages);
        }

    }

    public boolean isCount() {
        return this.total > -1L;
    }

    public int pageNum(int pageNum) {
        this.pageNum = pageNum <= 0 ? 1 : pageNum;
        return pageNum;
    }

    public int pageSize(int pageSize) {
        this.pageSize = pageSize;
        return pageSize;
    }

    public boolean count(Boolean count) {
        this.total = count.booleanValue() ? 0L : -1L;
        return count;
    }

    public List<E> getResult() {
        return result;
    }

    public void setResult(List<E> result) {
        this.result = result;
    }

}
