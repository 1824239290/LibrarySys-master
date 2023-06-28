package com.xiaoxie.library.utils;

import java.io.Serializable;


public class DataInfo implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer code;
    private String msg;
    private Long count;
    private Object data;

    public DataInfo() {

    }

    public DataInfo(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public DataInfo(Integer code, String msg, Object data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }

    public DataInfo(Integer code, String msg, Long count, Object data) {
        this.code = code;
        this.msg = msg;
        this.count = count;
        this.data = data;
    }

    public static DataInfo ok() {
        return new DataInfo(Constants.OK_CODE, Constants.OK_MSG, null);
    }

    public static DataInfo ok(Object data) {
        return new DataInfo(Constants.OK_CODE, Constants.OK_MSG, data);
    }

    //数据表格专用
    public static DataInfo ok(String msg, long count, Object data) {
        return new DataInfo(Constants.OK_CODE1, msg, count, data);
    }

    public static DataInfo ok(String msg, Object data) {
        return new DataInfo(Constants.OK_CODE, msg, data);
    }

    public static DataInfo fail(String msg) {
        return new DataInfo(Constants.FAIL_CODE, msg, null);
    }

    public static DataInfo fail(int errorCode, String msg) {
        return new DataInfo(errorCode, msg, null);
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Long getCount() {
        return count;
    }

    public void setCount(Long count) {
        this.count = count;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
