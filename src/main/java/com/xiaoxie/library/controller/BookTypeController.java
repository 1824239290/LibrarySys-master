package com.xiaoxie.library.controller;

import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.pojo.BookType;
import com.xiaoxie.library.service.BookTypeService;
import com.xiaoxie.library.utils.DataInfo;
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
@RequestMapping("/bookType")
public class BookTypeController {
    private static final Logger log = LogManager.getLogger(BookTypeController.class);

    @Autowired
    private BookTypeService bookTypeService;

    /**
     * 跳转图书类型管理界面
     *
     * @return
     */
    @RequestMapping("/bookTypeList")
    public String bookTypeList() {
        return "bookType/bookTypeList";
    }

    /**
     * 查询所有图书类型信息
     *
     * @param bookType
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/queryAllBookTypes")
    @ResponseBody
    public DataInfo queryAllBookTypes(BookType bookType, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "15") Integer limit) {
        PageInfo<BookType> bookTypePageInfo = bookTypeService.selectAllBookTypes(bookType, page, limit);
        return DataInfo.ok("成功", bookTypePageInfo.getTotal(), bookTypePageInfo.getList());
    }

    /**
     * 添加时检查图书类型名是否存在
     * @param typeName
     * @return
     */
    @RequestMapping(value = "/bookTypeExist")
    @ResponseBody
    public DataInfo bookTypeExist(@RequestBody String typeName) {
        BookType bookType = bookTypeService.selectByTypeName(typeName);
        if (bookType == null) {
            return DataInfo.ok();
        } else {
            return DataInfo.fail("图书类型名已存在!");
        }
    }

    /**
     * 跳转添加图书类型页面
     *
     * @return
     */
    @RequestMapping("/bookTypeAdd")
    public String bookTypeAdd() {
        return "bookType/bookTypeAdd";
    }

    /**
     * 图书类型添加
     *
     * @param bookType
     * @param request
     * @return
     */
    @RequestMapping("/addBookType")
    @ResponseBody
    public DataInfo addBookType(@RequestBody BookType bookType, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        log.info(name + "添加了图书类型：" + bookType.getTypeName());
        int i = bookTypeService.insertSelective(bookType);
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
    @RequestMapping("/bookTypeEdit")
    public String bookTypeEdit(Integer id, Model model) {
        BookType bookType = bookTypeService.selectByPrimaryKey(id);
        model.addAttribute("bookType", bookType);
        return "bookType/bookTypeEdit";
    }

    /**
     * 修改图书类型信息
     *
     * @param bookType
     * @param request
     * @return
     */
    @RequestMapping("/editBookType")
    @ResponseBody
    public DataInfo editBookType(@RequestBody BookType bookType, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        log.info(name + "修改了图书类型：" + bookType.getTypeName() + "的信息");
        int i = bookTypeService.updateByPrimaryKeySelective(bookType);
        if (i == 1) {
            log.info("修改成功");
            return DataInfo.ok();
        } else {
            log.info("修改失败");
            return DataInfo.fail("用户修改失败!");
        }
    }

    /**
     * 删除图书信息
     *
     * @param ids
     * @param request
     * @return
     */
    @RequestMapping("/deleteBookType")
    @ResponseBody
    public DataInfo deleteBookType(String ids, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        List<String> list = Arrays.asList(ids.split(","));
        log.info(name + "试图删除图书类型信息");
        int i = bookTypeService.deleteBookTypeByIds(list);
        if (i >= 1) {
            log.info("删除了：" + i + "条信息");
            return DataInfo.ok();
        } else {
            log.info("删除失败");
            return DataInfo.fail("删除失败");
        }
    }
}
