package com.xiaoxie.library.service;

import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.pojo.Book;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface BookService {
    int deleteByPrimaryKey(Integer id);

    int insert(Book record);

    int insertSelective(Book record);

    Book selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Book record);

    int updateByPrimaryKey(Book record);

    //查询所有用户信息信息
    PageInfo<Book> selectAllBook(@Param("book") Book book, @Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

    //根据id集合批量删除书籍信息
    int deleteBookByIds(List<String> ids );

    //图书重名查询
    Book selectByBookName(String bookName);

    //查询总的有多少书籍
    int selectBookNumber();

    //批量更新图书状态为未借出
    int updateBookStatusById(List<String> ids);
}
