package com.xiaoxie.library.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.dao.BookMapper;
import com.xiaoxie.library.dao.BorrowBookMapper;
import com.xiaoxie.library.pojo.BorrowBook;
import com.xiaoxie.library.service.BorrowBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class BorrowBookServiceImpl implements BorrowBookService {

    @Autowired(required = false)
    private BorrowBookMapper borrowBookMapper;

    @Autowired(required = false)
    private BookMapper bookMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        int i = borrowBookMapper.deleteByPrimaryKey(id);
        return i;
    }

    @Override
    public int insert(BorrowBook record) {
        int insert = borrowBookMapper.insert(record);
        return insert;
    }

    @Override
    public int insertSelective(BorrowBook record) {
        int i = borrowBookMapper.insertSelective(record);
        return i;
    }

    @Override
    public BorrowBook selectByPrimaryKey(Integer id) {
        BorrowBook borrowBook = borrowBookMapper.selectByPrimaryKey(id);
        return borrowBook;
    }

    @Override
    public int updateByPrimaryKeySelective(BorrowBook record) {
        int i = borrowBookMapper.updateByPrimaryKeySelective(record);
        return i;
    }

    @Override
    public int updateByPrimaryKey(BorrowBook record) {
        int i = borrowBookMapper.updateByPrimaryKey(record);
        return i;
    }

    @Override
    public int selectAllBorrowBookNumber() {
        int i = borrowBookMapper.selectAllBorrowBookNumber();
        return i;
    }

    @Override
    public PageInfo<BorrowBook> selectAllBorrowBook(BorrowBook borrowBook, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<BorrowBook> borrowBooks = borrowBookMapper.selectAllBorrowBook(borrowBook);
        return new PageInfo<>(borrowBooks);
    }

    @Override
    public List<BorrowBook> queryBorrowBookList(Integer bookId, Integer readerId) {
        List<BorrowBook> borrowBooks = borrowBookMapper.queryBorrowBookList(bookId, readerId);
        return borrowBooks;
    }

    @Override
    public int selectCounts(Integer readerId) {
        int i = borrowBookMapper.selectCounts(readerId);
        return i;
    }

    @Override
    public int updateBorrowBookStatusById(BorrowBook borrowBook, List<String> ids) {
        int i = borrowBookMapper.updateBorrowBookStatusById(borrowBook, ids);
        return i;
    }

    @Override
    public int deleteBorrowBookByIds(List<String> ids) {
        int i = borrowBookMapper.deleteBorrowBookByIds(ids);
        return i;
    }
}
