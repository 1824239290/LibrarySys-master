package com.xiaoxie.library.pojo;

import com.alibaba.fastjson.annotation.JSONField;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.lang.Nullable;

import java.io.Serializable;
import java.util.Date;

public class BorrowBook implements Serializable{
    private static final long serialVersionUID = 1L;

    private Integer id;

    private Integer bookId;

    private String libraryCard;

    private Integer readerId;

    //接收页面输入的时间，将其格式化
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    //后端传的日期格式化
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date borrowTime;

    @Nullable
    //接收页面输入的时间，将其格式化
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    //后端传的日期格式化
    @JSONField(format = "yyyy-MM-dd HH:mm:ss")
    private Date returnBookTime;

    @Nullable
    private Integer returnBookType;

    @Nullable
    private String remark;

    private Book book;

    private User user;

    public BorrowBook() {
        super();
    }

    public BorrowBook(Integer id, Integer bookId, String libraryCard, Integer readerId, Date borrowTime, Date returnBookTime, Integer returnBookType, String remark, Book book, User user) {
        this.id = id;
        this.bookId = bookId;
        this.libraryCard = libraryCard;
        this.readerId = readerId;
        this.borrowTime = borrowTime;
        this.returnBookTime = returnBookTime;
        this.returnBookType = returnBookType;
        this.remark = remark;
        this.book = book;
        this.user = user;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public String getLibraryCard() {
        return libraryCard;
    }

    public void setLibraryCard(String libraryCard) {
        this.libraryCard = libraryCard;
    }

    public Integer getReaderId() {
        return readerId;
    }

    public void setReaderId(Integer readerId) {
        this.readerId = readerId;
    }

    public Date getBorrowTime() {
        return borrowTime;
    }

    public void setBorrowTime(Date borrowTime) {
        this.borrowTime = borrowTime;
    }

    public Date getReturnBookTime() {
        return returnBookTime;
    }

    public void setReturnBookTime(Date returnBookTime) {
        this.returnBookTime = returnBookTime;
    }

    public Integer getReturnBookType() {
        return returnBookType;
    }

    public void setReturnBookType(Integer returnBookType) {
        this.returnBookType = returnBookType;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    public String toString() {
        return "BorrowBook{" +
                "id=" + id +
                ", bookId=" + bookId +
                ", libraryCard='" + libraryCard + '\'' +
                ", readerId=" + readerId +
                ", borrowTime=" + borrowTime +
                ", returnBookTime=" + returnBookTime +
                ", returnBookType=" + returnBookType +
                ", remark='" + remark + '\'' +
                ", book=" + book +
                ", user=" + user +
                '}';
    }
}