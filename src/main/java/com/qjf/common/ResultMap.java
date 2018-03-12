package com.qjf.common;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * Created by geli on 2018/1/23.
 */
public class ResultMap extends HashMap<String, Object> {
    public static final int register_timeout = 1001;
    public static final String DEFAULT_FAIL_MSG = "操作失败";
    public static final String DEFAULT_SUCCESS_MSG = "操作成功";
    private static final long serialVersionUID = -6084968393280233251L;

    public ResultMap(boolean isSuccess) {
        if(isSuccess) {
            this.put("action", "success");
            this.put("msg", "操作成功");
        } else {
            this.put("action", "fail");
            this.put("msg", "操作失败");
        }

    }

    public ResultMap() {
        this.put("action", "fail");
        this.put("msg", "操作失败");
    }

    public ResultMap setSuccess() {
        this.put("action", "success");
        this.put("msg", "操作成功");
        return this;
    }

    public ResultMap setSuccess(String msg) {
        this.put("action", "success");
        this.put("msg", msg);
        return this;
    }

    public ResultMap setFail() {
        this.put("action", "fail");
        this.put("msg", "操作失败");
        return this;
    }

    public ResultMap setFail(String msg) {
        this.put("action", "fail");
        this.put("msg", msg);
        return this;
    }

    public ResultMap setFail(String msg, String exceptionMsg) {
        this.put("action", "fail");
        this.put("msg", msg);
        this.put("exceptionMsg", exceptionMsg);
        return this;
    }

    public ResultMap setFail(String msg, String exceptionMsg, Integer errorCode) {
        this.put("action", "fail");
        this.put("msg", msg);
        this.put("exceptionMsg", exceptionMsg);
        this.put("errorCode", errorCode);
        return this;
    }

    public void setMsg(String msg) {
        this.put("msg", msg);
    }

    public void setErrorCode(Integer errorCode) {
        this.put("errorCode", errorCode);
    }

    public void setExceptionMsg(String exceptionMsg) {
        this.put("exceptionMsg", exceptionMsg);
    }

    public void addAll(Map<String, Object> data) {
        long time = System.currentTimeMillis();
        if(data != null && !data.isEmpty()) {
            Iterator iter = data.entrySet().iterator();

            while(iter.hasNext()) {
                Entry entry = (Entry)iter.next();
                String key = (String)entry.getKey();
                this.put(key, data.get(key));
            }
        }

    }
}
