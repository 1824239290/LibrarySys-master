package com.xiaoxie.library.pojo;

import java.util.Date;

/**
 * @author xiaoxie
 * @create 2022-02-15 21:13
 */
public class UserPhoto {

    private Integer id;

    private Integer userId;

    private String picture;

    private Date uploadTime;

    public UserPhoto() {

    }

    public UserPhoto(Integer id, Integer userId, String picture, Date uploadTime) {
        this.id = id;
        this.userId = userId;
        this.picture = picture;
        this.uploadTime = uploadTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public Date getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(Date uploadTime) {
        this.uploadTime = uploadTime;
    }
}
