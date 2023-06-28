package com.xiaoxie.library.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.dao.BookMapper;
import com.xiaoxie.library.pojo.Book;
import com.xiaoxie.library.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class BookServiceImpl implements BookService {
    @Autowired(required = false)
    private BookMapper bookMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        int i = bookMapper.deleteByPrimaryKey(id);
        return i;
    }

    @Override
    public int insert(Book record) {
        int insert = bookMapper.insert(record);
        return insert;
    }

    @Override
    public int insertSelective(Book record) {
        int i = bookMapper.insertSelective(record);
        return i;
    }

    @Override
    public Book selectByPrimaryKey(Integer id) {
        Book book = bookMapper.selectByPrimaryKey(id);
        return book;
    }

    @Override
    public int updateByPrimaryKeySelective(Book record) {
        int i = bookMapper.updateByPrimaryKeySelective(record);
        return i;
    }

    @Override
    public int updateByPrimaryKey(Book record) {
        int i = bookMapper.updateByPrimaryKey(record);
        return i;
    }

    @Override
    public PageInfo<Book> selectAllBook(Book book, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Book> books = bookMapper.selectAllBook(book);
        return new PageInfo<>(books);
    }

    @Override
    public int deleteBookByIds(List<String> ids) {
        int i = bookMapper.deleteBookByIds(ids);
        return i;
    }

    @Override
    public Book selectByBookName(String bookName) {
        Book book = bookMapper.selectByBookName(bookName);
        return book;
    }

    @Override
    public int selectBookNumber() {
        int i = bookMapper.selectBookNumber();
        return i;
    }

    @Override
    public int updateBookStatusById(List<String> ids) {
        int i = bookMapper.updateBookStatusById(ids);
        return i;
    }
}
