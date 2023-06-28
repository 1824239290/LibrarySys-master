package com.xiaoxie.library.controller;

import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.pojo.User;
import com.xiaoxie.library.service.UserService;
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
import java.util.UUID;

@Controller
@RequestMapping("/reader")
public class ReaderController {
    private static final Logger log = LogManager.getLogger(ReaderController.class);

    @Autowired
    private UserService userService;

    /**
     * 跳转读者管理界面
     *
     * @return
     */
    @RequestMapping("/readerList")
    public String readList() {
        return "reader/readerList";
    }

    /**
     * 查询所有读者信息
     *
     * @param user
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/queryAllReader")
    @ResponseBody
    public DataInfo queryAllReader(User user, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "15") Integer limit) {
        PageInfo<User> userPageInfo = userService.selectAllUser(user, page, limit);
        return DataInfo.ok("成功", userPageInfo.getTotal(), userPageInfo.getList());
    }

    /**
     * 跳转添加读者页面
     *
     * @return
     */
    @RequestMapping("/readerAdd")
    public String readerAdd() {
        return "reader/readerAdd";
    }

    /**
     * 读者添加
     *
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/addReader")
    @ResponseBody
    public DataInfo addReader(@RequestBody User user, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        user.setCreateDate(DateUtil.getTimestamp());
        user.setLibraryCard(UUID.randomUUID().toString().substring(0, 6));
        user.setPassword("123456");
        log.info(name + "添加了读者：" + user.getUsername());
        int i = userService.insertSelective(user);
        if (i == 1) {
            log.info("添加成功");
            return DataInfo.ok();
        } else {
            log.info("添加失败");
            return DataInfo.fail("用户添加失败!");
        }
    }

    /**
     * 根据Id查出数据跳转修改页面
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/readerEdit")
    public String readerEdit(Integer id, Model model) {
        User user = userService.selectByPrimaryKey(id);
        model.addAttribute("user", user);
        return "reader/readerEdit";
    }

    /**
     * 修改读者信息
     *
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/editReader")
    @ResponseBody
    public DataInfo editReader(@RequestBody User user, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        log.info(name + "修改了读者：" + user.getUsername() + "的信息");
        int i = userService.updateByPrimaryKeySelective(user);
        if (i == 1) {
            log.info("修改成功");
            return DataInfo.ok();
        } else {
            log.info("修改失败");
            return DataInfo.fail("用户修改失败!");
        }
    }

    /**
     * 删除读者信息
     *
     * @param ids
     * @param request
     * @return
     */
    @RequestMapping("/deleteReader")
    @ResponseBody
    public DataInfo deletaReader(String ids, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        List<String> list = Arrays.asList(ids.split(","));
        log.info(name + "试图删除读者信息");
        int i = userService.deleteUserByIds(list);
        if (i >= 1) {
            log.info("删除了：" + i + "条信息");
            return DataInfo.ok();
        } else {
            log.info("删除失败");
            return DataInfo.fail("删除失败");
        }
    }

    /**
     * 重置读者密码
     *
     * @param id
     * @param request
     * @return
     */
    @RequestMapping("/updatePasswordById")
    @ResponseBody
    public DataInfo updatePasswordById(Integer id, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        log.info(name + "试图重置读者密码");
        int i = userService.updatePwdById(id);
        if (i == 1) {
            log.info("重置读者密码成功");
            return DataInfo.ok();
        } else {
            log.info("重置读者密码失败");
            return DataInfo.fail("重置失败");
        }
    }
}
