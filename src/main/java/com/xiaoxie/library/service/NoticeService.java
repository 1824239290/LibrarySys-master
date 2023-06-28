package com.xiaoxie.library.service;

import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.pojo.Notice;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface NoticeService {
    int deleteByPrimaryKey(Integer id);

    int insert(Notice record);

    int insertSelective(Notice record);

    Notice selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Notice record);

    int updateByPrimaryKey(Notice record);

    //查询所有公告信息
    PageInfo<Notice> selectAllNotice(@Param("notice") Notice notice, @Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

    //根据id集合批量删除公告信息
    int deleteNoticeByIds(List<String> ids );

    //公告标题重名查询
    Notice selectByTitle(String title);
}
