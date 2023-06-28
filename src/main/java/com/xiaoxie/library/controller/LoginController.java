package com.xiaoxie.library.controller;

import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.codeutil.IVerifyCodeGen;
import com.xiaoxie.library.codeutil.SimpleCharVerifyCodeGenImpl;
import com.xiaoxie.library.codeutil.VerifyCode;
import com.xiaoxie.library.pojo.Notice;
import com.xiaoxie.library.pojo.User;
import com.xiaoxie.library.service.NoticeService;
import com.xiaoxie.library.service.UserService;
import com.xiaoxie.library.utils.AesUtil;
import com.xiaoxie.library.utils.DataInfo;
import com.xiaoxie.library.utils.DateUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.UUID;


@Controller
public class LoginController {

    private static final Logger log = LogManager.getLogger(LoginController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private NoticeService noticeService;

    /**
     * 跳转首页
     * @return
     */
    @RequestMapping("/toIndex")
    public String toIndex(){
        return "index";
    }

    /**
     * 跳转欢迎页
     * @return
     */
    @RequestMapping("/welcome")
    public String welcome(Model model){
        //查询公告信息
        PageInfo<Notice> noticePageInfo = noticeService.selectAllNotice(null, 1, 6);
        List<Notice> noticeList = noticePageInfo.getList();
        model.addAttribute("noticeList",noticeList);
        return "welcome";
    }

    /**
     * 跳转登录页
     * @return
     */
    @RequestMapping("/")
    public String login() {
        return "login";
    }

    /**
     * 跳转注册页面
     * @return
     */
    @RequestMapping("/register")
    public String register(Model model) {
        return "register";
    }

    /**
     * 跳转忘记密码页面
     * @return
     */
    @RequestMapping("/retrievePassword")
    public String retrievePassword() {
        return "retrievePassword";
    }

    /**
     * 跳转基本资料页面
     * @return
     */
    @RequestMapping("/setting")
    public String setting(HttpServletRequest request,Model model){
        HttpSession session = request.getSession();
        int id = (int) session.getAttribute("id");
        User user = userService.selectByPrimaryKey(id);
        model.addAttribute("user",user);
        return "setting/userSetting";
    }

    /**
     * 获取验证码方法
     * @param request
     * @param response
     */
    @RequestMapping("/verifyCode")
    public void verifyCode(HttpServletRequest request, HttpServletResponse response) {
        IVerifyCodeGen iVerifyCodeGen = new SimpleCharVerifyCodeGenImpl();
        try {
            //设置长宽
            VerifyCode verifyCode = iVerifyCodeGen.generate(80, 28);
            String code = verifyCode.getCode();
            //将VerifyCode绑定session
            request.getSession().setAttribute("VerifyCode", code);
            //设置响应头
            response.setHeader("Pragma", "no-cache");
            //设置响应头
            response.setHeader("Cache-Control", "no-cache");
            //在代理服务器端防止缓冲
            response.setDateHeader("Expires", 0);
            //设置响应内容类型
            response.setContentType("image/jpeg");
            response.getOutputStream().write(verifyCode.getImgBytes());
            response.getOutputStream().flush();
        } catch (IOException e) {
            System.out.println("异常处理");
        }
    }

    /**
     * 注册时检查用户名是否存在
     * @param username
     * @return
     */
    @RequestMapping("/userExist")
    @ResponseBody
    public DataInfo userExist(@RequestBody String username) {
        User user = userService.selectByUserName(username);
        if (user == null) {
            return DataInfo.ok();
        } else {
            return DataInfo.fail("用户名已存在!");
        }
    }

    /**
     * 注册时检查验证码是否正确
     * @param request
     * @param captcha
     * @return
     */
    @RequestMapping("/codeExist")
    @ResponseBody
    public DataInfo codeExist(HttpServletRequest request, @RequestBody String captcha) {
        //判断验证码是否正确（验证码已经放入session）
        HttpSession session = request.getSession();
        String realCode = (String) session.getAttribute("VerifyCode");
        if (realCode.toLowerCase().equals(captcha.toLowerCase())) {
            return DataInfo.ok();
        } else {
            return DataInfo.fail("验证码错误!");
        }
    }

    /**
     * 注册用户
     * @param user
     * @return
     */
    @RequestMapping("/registerUser")
    @ResponseBody
    public DataInfo registerUser(@RequestBody User user) throws IOException {
        user.setCreateDate(DateUtil.getTimestamp());
        user.setLibraryCard(UUID.randomUUID().toString().substring(0, 6));
        log.info(user.getUsername()+"进行了注册");
        int i = userService.insertSelective(user);
        if (i == 1) {
            log.info("注册成功");
            return DataInfo.ok();
        } else {
            log.info("注册失败");
            return DataInfo.fail("注册失败!");
        }
    }

    /**
     * 查询有没有绑定手机号或邮箱
     * @param username
     * @return
     */
    @RequestMapping("/telEmailExist")
    @ResponseBody
    public DataInfo telEmailExist(@RequestBody String username) {
        User user = userService.selectTelAndEmailByUsername(username);
        if (user == null) {
            return DataInfo.fail("该用户暂无任何绑定!");
        } else {
            return DataInfo.ok("请求成功", user.getUsername());
        }
    }

    /**
     * 根据邮箱或手机号找回密码
     * @param tel
     * @param email
     * @param password
     * @return
     */
    @RequestMapping("/retrievePasswordUser")
    @ResponseBody
    public DataInfo retrievePasswordUser(@RequestParam(value = "username") String username, @RequestParam(value = "tel") String tel, @RequestParam(value = "email") String email, @RequestParam(value = "password") String password) {
        log.info(username+"试图找回密码");
        int i = userService.updatePasswordByTelAndEmail(username, tel, email, password);
        if (i == 1) {
            log.info("找回密码成功");
            return DataInfo.ok();
        } else {
            log.info("找回密码失败");
            return DataInfo.fail("请输入正确的绑定信息!");
        }
    }

    /**
     * 登录
     * @param username
     * @param password
     * @return
     */
    @RequestMapping("/loginTo")
    @ResponseBody
    public DataInfo loginTo(HttpServletRequest request,@RequestParam(value = "username") String username,@RequestParam(value = "password") String password) throws Exception {
        log.info("用户试图以用户名："+username+"和密码："+password+"进行登录操作");
        String unm = AesUtil.aesDecrypt(username);
        String pwd = AesUtil.aesDecrypt(password);
        log.info("用户试图以用户名："+unm+"和密码："+pwd+"进行登录操作");
        User user = userService.selectUserTypeByUP(unm, pwd);
        HttpSession session = request.getSession();
        if (user != null){
            if (user.getUserStatus() == 1){
                log.info("用户正常："+user.getUsername());
                if (user.getUserType() == 0){
                    session.setAttribute("id",user.getId());
                    session.setAttribute("name",user.getUsername());
                    session.setAttribute("type","supperAdmin");
                    log.info("超级管理员"+user.getUsername());
                    return DataInfo.ok();
                }else if (user.getUserType() == 1){
                    session.setAttribute("id",user.getId());
                    session.setAttribute("name",user.getUsername());
                    session.setAttribute("type","admin");
                    log.info("普通管理员"+user.getUsername());
                    return DataInfo.ok();
                }else if (user.getUserType() == 2){
                    session.setAttribute("id",user.getId());
                    session.setAttribute("name",user.getUsername());
                    session.setAttribute("type","reader");
                    log.info("读者"+user.getUsername());
                    return DataInfo.ok();
                }else {
                    return null;
                }
            }else {
                log.info("用户冻结："+user.getUsername());
                return DataInfo.fail("用户已被冻结");
            }
        }else {
            log.info("用户名或密码错误");
            return DataInfo.fail("用户名或密码错误");
        }
    }

    /**
     * 退出功能
     */
    @GetMapping("/loginOut")
    public String loginOut(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();//注销
        return "redirect:/";
    }


    /**
     * 基本资料保存
     * @param request
     * @param user
     * @return
     */
    @RequestMapping("/userSetting")
    @ResponseBody
    public DataInfo userSetting(HttpServletRequest request,@RequestBody User user){
        System.out.println(user);
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        user.setId(id);
        int i = userService.updateByPrimaryKeySelective(user);
        if (i == 1){
            return DataInfo.ok();
        }else {
            return DataInfo.fail("保存失败");
        }
    }

    /**
     * 跳转修改密码界面
     * @return
     */
    @RequestMapping("/toUpPwd")
    public String toUpPwd(){
        return "upPwd/updatePassword";
    }

    /**
     * 修改密码
     * @param oldPassword
     * @param newPassword1
     * @return
     */
    @RequestMapping("/updatePassword")
    @ResponseBody
    public DataInfo updatePassword(HttpServletRequest request,@RequestParam(value = "oldPassword") String oldPassword,@RequestParam(value = "newPassword1") String newPassword1){
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        log.info(id+"试图修改密码");
        User user = userService.selectPasswordById(id);
        if (user.getPassword() == oldPassword){
            int a = userService.updatePasswordById(id,newPassword1);
            if (a == 1){
                log.info(id+"修改密码成功");
               return DataInfo.ok();
            }else {
                log.info(id+"修改密码失败");
                return DataInfo.fail("修改失败");
            }
        }else {
            log.info(id+"修改密码失败");
            return DataInfo.fail("旧密码错误");
        }
    }
}
