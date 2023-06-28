package com.xiaoxie.library.controller;

import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.pojo.Notice;
import com.xiaoxie.library.service.NoticeService;
import com.xiaoxie.library.utils.DataInfo;
import com.xiaoxie.library.utils.DateUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Arrays;
import java.util.List;


@Controller
@RequestMapping("/notice")
public class NoticeController {
    private static final Logger log = LogManager.getLogger(NoticeController.class);

    @Autowired
    private NoticeService noticeService;

    /**
     * 跳转公告管理界面
     *
     * @return
     */
    @RequestMapping("/noticeList")
    public String noticeList() {
        return "notice/noticeList";
    }

    /**
     * 查询所有图书类型信息
     *
     * @param notice
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/queryAllNotice")
    @ResponseBody
    public DataInfo queryAllNotice(Notice notice, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "15") Integer limit) {
        PageInfo<Notice> noticePageInfo = noticeService.selectAllNotice(notice, page, limit);
        return DataInfo.ok("成功", noticePageInfo.getTotal(), noticePageInfo.getList());
    }

    /**
     * 添加时检查公告标题是否存在
     * @param title
     * @return
     */
    @RequestMapping(value = "/titleExist")
    @ResponseBody
    public DataInfo titleExist(@RequestBody String title) {
        Notice notice = noticeService.selectByTitle(title);
        if (notice == null) {
            return DataInfo.ok();
        } else {
            return DataInfo.fail("公告标题已存在!");
        }
    }

    /**
     * 跳转添加公告页面
     *
     * @return
     */
    @RequestMapping("/noticeAdd")
    public String noticeAdd() {
        return "notice/noticeAdd";
    }

    /**
     * 公告添加
     *
     * @param notice
     * @param request
     * @return
     */
    @RequestMapping("/addNotice")
    @ResponseBody
    public DataInfo addNotice(@RequestBody Notice notice, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        log.info(name + "添加了公告：" + notice.getTitle());
        notice.setCreator(name);
        notice.setCreateTime(DateUtil.getTimestamp());
        int i = noticeService.insertSelective(notice);
        if (i == 1) {
            log.info("添加成功");
            return DataInfo.ok();
        } else {
            log.info("添加失败");
            return DataInfo.fail("公告添加失败!");
        }
    }

    /**
     * 根据Id查出数据跳转修改页面
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/noticeEdit")
    public String noticeEdit(Integer id, Model model) {
        Notice notice = noticeService.selectByPrimaryKey(id);
        model.addAttribute("notice", notice);
        return "notice/noticeEdit";
    }

    /**
     * 修改公告信息
     *
     * @param notice
     * @param request
     * @return
     */
    @RequestMapping("/editNotice")
    @ResponseBody
    public DataInfo editNotice(@RequestBody Notice notice, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        log.info(name + "修改了公告：" + notice.getTitle() + "的信息");
        int i = noticeService.updateByPrimaryKeySelective(notice);
        if (i == 1) {
            log.info("修改成功");
            return DataInfo.ok();
        } else {
            log.info("修改失败");
            return DataInfo.fail("公告修改失败!");
        }
    }

    /**
     * 删除公告信息
     *
     * @param ids
     * @param request
     * @return
     */
    @RequestMapping("/deleteNotice")
    @ResponseBody
    public DataInfo deleteNotice(String ids, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        List<String> list = Arrays.asList(ids.split(","));
        log.info(name + "试图删除公告信息");
        final int i = noticeService.deleteNoticeByIds(list);
        if (i >= 1) {
            log.info("删除了：" + i + "条信息");
            return DataInfo.ok();
        } else {
            log.info("删除失败");
            return DataInfo.fail("删除失败");
        }
    }
}
