package com.xiaoxie.library.pojo;

import java.io.Serializable;

public class BookType implements Serializable{
    private static final long serialVersionUID = 1L;

    private Integer id;

    private String typeName;

    private String remark;

    public BookType(Integer id, String typeName, String remark) {
        this.id = id;
        this.typeName = typeName;
        this.remark = remark;
    }

    public BookType() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName == null ? null : typeName.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
}