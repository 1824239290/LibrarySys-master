package com.xiaoxie.library.pojo;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable{
    private static final long serialVersionUID = 1L;

    private Integer id;

    private String username;

    private String password;

    private Integer userType;

    private String realName;

    private String sex;

    //接收页面输入的时间，将其格式化
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    //后端传的日期格式化
    @JSONField(format = "yyyy-MM-dd")
    private Date birthday;

    @Nullable
    private String address;

    private String tel;

    private String email;

    //接收页面输入的时间，将其格式化
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    //后端传的日期格式化
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date createDate;

    @Nullable
    private String libraryCard;

    @Nullable
    private Integer userStatus;


    public User() {
        super();
    }

    public User(Integer id, String username, String password, Integer userType, String realName, String sex, @Nullable Date birthday, @Nullable String address, String tel, String email, Date createDate, @Nullable String libraryCard, @Nullable Integer userStatus) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.userType = userType;
        this.realName = realName;
        this.sex = sex;
        this.birthday = birthday;
        this.address = address;
        this.tel = tel;
        this.email = email;
        this.createDate = createDate;
        this.libraryCard = libraryCard;
        this.userStatus = userStatus;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Nullable
    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(@Nullable Date birthday) {
        this.birthday = birthday;
    }

    @Nullable
    public String getAddress() {
        return address;
    }

    public void setAddress(@Nullable String address) {
        this.address = address;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    @Nullable
    public String getLibraryCard() {
        return libraryCard;
    }

    public void setLibraryCard(@Nullable String libraryCard) {
        this.libraryCard = libraryCard;
    }

    @Nullable
    public Integer getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(@Nullable Integer userStatus) {
        this.userStatus = userStatus;
    }
}