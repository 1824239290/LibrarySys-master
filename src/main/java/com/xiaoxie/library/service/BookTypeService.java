package com.xiaoxie.library.service;

import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.pojo.Book;
import com.xiaoxie.library.pojo.BookType;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface BookTypeService {
    int deleteByPrimaryKey(Integer id);

    int insert(BookType record);

    int insertSelective(BookType record);

    BookType selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BookType record);

    int updateByPrimaryKey(BookType record);

    //查询所有书籍类型信息下拉框
    List<BookType> selectAllBookType();

    //查询所有书籍类型信息表格数据展示
    PageInfo<BookType> selectAllBookTypes(@Param("bookType") BookType bookType, @Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

    //根据id集合批量删除书籍类型信息
    int deleteBookTypeByIds(List<String> ids );

    //图书类型重名查询
    BookType selectByTypeName(String typeName);

    //查询总的有多少分类
    int selectAllBookTypeNumber();
}
