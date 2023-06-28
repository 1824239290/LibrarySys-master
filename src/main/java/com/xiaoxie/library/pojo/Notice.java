package com.xiaoxie.library.pojo;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;

import java.io.Serializable;
import java.util.Date;

public class Notice implements Serializable{
    private static final long serialVersionUID = 1L;

    private Integer id;

    @Nullable
    private String title;

    private String content;

    @Nullable
    private String creator;

    //接收页面输入的时间，将其格式化
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    //后端传的日期格式化
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public Notice(Integer id, String title, String content, String creator, Date createTime) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.creator = creator;
        this.createTime = createTime;
    }

    public Notice() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator == null ? null : creator.trim();
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}