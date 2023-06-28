package com.xiaoxie.library.dao;

import com.xiaoxie.library.pojo.Notice;

import java.util.List;

public interface NoticeMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Notice record);

    int insertSelective(Notice record);

    Notice selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Notice record);

    int updateByPrimaryKey(Notice record);

    //查询所有公告信息
    List<Notice> selectAllNotice(Notice notice);

    //根据id集合批量删除公告信息
    int deleteNoticeByIds(List<String> ids );

    //公告标题重名查询
    Notice selectByTitle(String title);
}