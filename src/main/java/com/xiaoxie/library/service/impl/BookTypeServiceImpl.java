package com.xiaoxie.library.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.dao.BookTypeMapper;
import com.xiaoxie.library.pojo.BookType;
import com.xiaoxie.library.service.BookTypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class BookTypeServiceImpl implements BookTypeService {
    @Autowired(required = false)
    private BookTypeMapper bookTypeMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        int i = bookTypeMapper.deleteByPrimaryKey(id);
        return i;
    }

    @Override
    public int insert(BookType record) {
        int insert = bookTypeMapper.insert(record);
        return insert;
    }

    @Override
    public int insertSelective(BookType record) {
        int i = bookTypeMapper.insertSelective(record);
        return i;
    }

    @Override
    public BookType selectByPrimaryKey(Integer id) {
        BookType bookType = bookTypeMapper.selectByPrimaryKey(id);
        return bookType;
    }

    @Override
    public int updateByPrimaryKeySelective(BookType record) {
        int i = bookTypeMapper.updateByPrimaryKeySelective(record);
        return i;
    }

    @Override
    public int updateByPrimaryKey(BookType record) {
        int i = bookTypeMapper.updateByPrimaryKey(record);
        return i;
    }

    @Override
    public List<BookType> selectAllBookType() {
        List<BookType> bookTypes = bookTypeMapper.selectAllBookType();
        return bookTypes;
    }

    @Override
    public PageInfo<BookType> selectAllBookTypes(BookType bookType, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<BookType> bookTypes = bookTypeMapper.selectAllBookTypes(bookType);
        return new PageInfo<>(bookTypes);
    }

    @Override
    public int deleteBookTypeByIds(List<String> ids) {
        int i = bookTypeMapper.deleteBookTypeByIds(ids);
        return i;
    }

    @Override
    public BookType selectByTypeName(String typeName) {
        BookType bookType = bookTypeMapper.selectByTypeName(typeName);
        return bookType;
    }

    @Override
    public int selectAllBookTypeNumber() {
        int i = bookTypeMapper.selectAllBookTypeNumber();
        return i;
    }
}
