package com.xiaoxie.library.dao;

import com.xiaoxie.library.pojo.BorrowBook;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BorrowBookMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(BorrowBook record);

    int insertSelective(BorrowBook record);

    BorrowBook selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(BorrowBook record);

    int updateByPrimaryKey(BorrowBook record);

    //查询所有借阅记录
    int selectAllBorrowBookNumber();

    //查询所有借阅数据
    List<BorrowBook> selectAllBorrowBook(BorrowBook borrowBook);

    //查询借阅时间线
    List<BorrowBook> queryBorrowBookList(@Param("bookId") Integer bookId, @Param("readerId") Integer readerId);

    //一次借一本最多借五本，还书以后才能继续借书
    int selectCounts(Integer readerId);

    //批量更新借阅记录为正常还书
    int updateBorrowBookStatusById(@Param("borrowBook") BorrowBook borrowBook,@Param("ids") List<String> ids);

    //根据id集合批量删除借阅信息
    int deleteBorrowBookByIds(List<String> ids );

}