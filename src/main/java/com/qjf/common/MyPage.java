package com.qjf.common;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2017/3/19 0019.
 *
 */
public class MyPage<E> implements Serializable {

    private static final long serialVersionUID = 1L;
    private int current;
    private int size;
    private long total;
    private int pages;
    private List<E> data;
    private Integer code=0;
    private String msg = "";

    public MyPage() {
    }

    public MyPage(com.baomidou.mybatisplus.plugins.Page page){
        this.data = page.getRecords();
        this.current = page.getCurrent();
        this.size = page.getSize();
        this.total = page.getTotal();
        this.pages = page.getPages();
    }

    public int getPages() {
        return this.pages;
    }

    public int getCurrent() {
        return this.current;
    }

    public void setCurrent(int current) {
        this.current = current <= 0?1:current;
    }

    public int getSize() {
        return this.size;
    }

    public void setSize(int size) {
        this.size = size;
    }

    public long getTotal() {
        return this.total;
    }

    public void setTotal(long total) {
        this.total = total;
        if(this.size > 0) {
            this.pages = (int)(total / (long)this.size + (long)(total % (long)this.size == 0L?0:1));
        } else {
            this.pages = 0;
        }

        if( this.current > this.pages) {
            this.current = this.pages;
        }
    }

    public boolean isCount() {
        return this.total > -1L;
    }

    public int current(int current) {
        this.current = current <= 0?1:current;
        return current;
    }

    public int size(int size) {
        this.size = size;
        return size;
    }

    public boolean count(Boolean count) {
        this.total = count.booleanValue()?0L:-1L;
        return count;
    }

    public List<E> getData() {
        return data;
    }

    public void setData(List<E> data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }
}
