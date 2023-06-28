package com.xiaoxie.library.dao;

import com.xiaoxie.library.pojo.Book;

import java.util.List;

public interface BookMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Book record);

    int insertSelective(Book record);

    Book selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Book record);

    int updateByPrimaryKey(Book record);

    //查询所有用户信息
    List<Book> selectAllBook(Book book);

    //根据id集合批量删除书籍信息
    int deleteBookByIds(List<String> ids );

    //图书重名查询
    Book selectByBookName(String bookName);

    //查询总的有多少书籍
    int selectBookNumber();

    //批量更新图书状态为未借出
    int updateBookStatusById(List<String> ids);
}