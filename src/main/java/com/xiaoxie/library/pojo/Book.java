package com.xiaoxie.library.pojo;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class Book implements Serializable{
    private static final long serialVersionUID = 1L;

    private Integer id;

    private String bookName;

    private String author;

    private String press;

    private String bookNumber;

    private String bookDescription;

    private String bookLanguage;

    private Double bookPrice;

    //接收页面输入的时间，将其格式化
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    //后端传的日期格式化
    @JSONField(format = "yyyy-MM-dd")
    private Date publicationTime;

    private String typeName;

    private Integer bookStatus;

    public Book(Integer id, String bookName, String author, String press, String bookNumber, String bookDescription, String bookLanguage, Double bookPrice, Date publicationTime, String typeName, Integer bookStatus) {
        this.id = id;
        this.bookName = bookName;
        this.author = author;
        this.press = press;
        this.bookNumber = bookNumber;
        this.bookDescription = bookDescription;
        this.bookLanguage = bookLanguage;
        this.bookPrice = bookPrice;
        this.publicationTime = publicationTime;
        this.typeName = typeName;
        this.bookStatus = bookStatus;
    }

    public Book() {
        super();
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getBookName() {
        return bookName;
    }

    public void setBookName(String bookName) {
        this.bookName = bookName;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPress() {
        return press;
    }

    public void setPress(String press) {
        this.press = press;
    }

    public String getBookNumber() {
        return bookNumber;
    }

    public void setBookNumber(String bookNumber) {
        this.bookNumber = bookNumber;
    }

    public String getBookDescription() {
        return bookDescription;
    }

    public void setBookDescription(String bookDescription) {
        this.bookDescription = bookDescription;
    }

    public String getBookLanguage() {
        return bookLanguage;
    }

    public void setBookLanguage(String bookLanguage) {
        this.bookLanguage = bookLanguage;
    }

    public Double getBookPrice() {
        return bookPrice;
    }

    public void setBookPrice(Double bookPrice) {
        this.bookPrice = bookPrice;
    }

    public Date getPublicationTime() {
        return publicationTime;
    }

    public void setPublicationTime(Date publicationTime) {
        this.publicationTime = publicationTime;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public Integer getBookStatus() {
        return bookStatus;
    }

    public void setBookStatus(Integer bookStatus) {
        this.bookStatus = bookStatus;
    }
}