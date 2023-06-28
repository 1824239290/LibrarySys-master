package com.xiaoxie.library.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.dao.NoticeMapper;
import com.xiaoxie.library.pojo.Notice;
import com.xiaoxie.library.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired(required = false)
    private NoticeMapper noticeMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        int i = noticeMapper.deleteByPrimaryKey(id);
        return i;
    }

    @Override
    public int insert(Notice record) {
        int insert = noticeMapper.insert(record);
        return insert;
    }

    @Override
    public int insertSelective(Notice record) {
        int i = noticeMapper.insertSelective(record);
        return i;
    }

    @Override
    public Notice selectByPrimaryKey(Integer id) {
        Notice notice = noticeMapper.selectByPrimaryKey(id);
        return notice;
    }

    @Override
    public int updateByPrimaryKeySelective(Notice record) {
        int i = noticeMapper.updateByPrimaryKeySelective(record);
        return i;
    }

    @Override
    public int updateByPrimaryKey(Notice record) {
        int i = noticeMapper.updateByPrimaryKey(record);
        return i;
    }

    @Override
    public PageInfo<Notice> selectAllNotice(Notice notice, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Notice> notices = noticeMapper.selectAllNotice(notice);
        return new PageInfo<>(notices);
    }

    @Override
    public int deleteNoticeByIds(List<String> ids) {
        int i = noticeMapper.deleteNoticeByIds(ids);
        return i;
    }

    @Override
    public Notice selectByTitle(String title) {
        Notice notice = noticeMapper.selectByTitle(title);
        return notice;
    }

}
