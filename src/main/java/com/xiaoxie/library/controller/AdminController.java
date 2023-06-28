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
@RequestMapping("/admin")
public class AdminController {
    private static final Logger log = LogManager.getLogger(AdminController.class);

    @Autowired
    private UserService userService;

    /**
     * 跳转管理员管理界面
     *
     * @return
     */
    @RequestMapping("/adminList")
    public String adminList() {
        return "admin/adminList";
    }

    /**
     * 查询所有管理员信息
     *
     * @param user
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/queryAllAdmin")
    @ResponseBody
    public DataInfo queryAllAdmin(User user, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "15") Integer limit) {
        PageInfo<User> userPageInfo = userService.selectAllAdminUser(user,page,limit);
        return DataInfo.ok("成功", userPageInfo.getTotal(), userPageInfo.getList());
    }

    /**
     * 跳转添加管理员页面
     *
     * @return
     */
    @RequestMapping("/adminAdd")
    public String adminAdd() {
        return "admin/adminAdd";
    }

    /**
     * 管理员添加
     *
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/addAdmin")
    @ResponseBody
    public DataInfo addAdmin(@RequestBody User user, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        user.setCreateDate(DateUtil.getTimestamp());
        user.setLibraryCard(UUID.randomUUID().toString().substring(0, 6));
        user.setPassword("123456");
        user.setUserType(1);
        log.info(name + "添加了管理员：" + user.getUsername());
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
    @RequestMapping("/adminEdit")
    public String adminEdit(Integer id, Model model) {
        User user = userService.selectByPrimaryKey(id);
        model.addAttribute("admin", user);
        return "admin/adminEdit";
    }

    /**
     * 修改管理员信息
     *
     * @param user
     * @param request
     * @return
     */
    @RequestMapping("/editAdmin")
    @ResponseBody
    public DataInfo editAdmin(@RequestBody User user, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        log.info(name + "修改了管理员：" + user.getUsername() + "的信息");
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
     * 删除管理员信息
     *
     * @param ids
     * @param request
     * @return
     */
    @RequestMapping("/deleteAdmin")
    @ResponseBody
    public DataInfo deleteAdmin(String ids, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        List<String> list = Arrays.asList(ids.split(","));
        log.info(name + "试图删管理员信息");
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
     * 重置管理员密码
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
        log.info(name + "试图重置管理员密码");
        int i = userService.updatePwdById(id);
        if (i == 1) {
            log.info("重置置管理员密码成功");
            return DataInfo.ok();
        } else {
            log.info("重置置管理员密码失败");
            return DataInfo.fail("重置失败");
        }
    }

}
