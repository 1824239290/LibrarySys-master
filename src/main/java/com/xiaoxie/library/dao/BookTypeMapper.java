package com.xiaoxie.library.dao;

import com.xiaoxie.library.pojo.Book;
import com.xiaoxie.library.pojo.BookType;

import java.util.List;

public interface BookTypeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BookType record);

    int insertSelective(BookType record);

    BookType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BookType record);

    int updateByPrimaryKey(BookType record);

    //查询所有书籍类型信息下拉框
    List<BookType> selectAllBookType();

    //查询所有书籍类型信息表格数据展示
    List<BookType> selectAllBookTypes(BookType bookType);

    //根据id集合批量删除书籍类型信息
    int deleteBookTypeByIds(List<String> ids );

    //图书类型重名查询
    BookType selectByTypeName(String typeName);

    //查询总的有多少分类
    int selectAllBookTypeNumber();
}