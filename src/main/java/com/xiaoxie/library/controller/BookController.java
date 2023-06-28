package com.xiaoxie.library.controller;

import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.pojo.Book;
import com.xiaoxie.library.pojo.BookType;
import com.xiaoxie.library.pojo.User;
import com.xiaoxie.library.service.BookService;
import com.xiaoxie.library.service.BookTypeService;
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
@RequestMapping("/book")
public class BookController {
    private static final Logger log = LogManager.getLogger(BookController.class);

    @Autowired
    private BookService bookService;

    @Autowired
    private BookTypeService bookTypeService;

    /**
     * 跳转图书管理界面
     *
     * @return
     */
    @RequestMapping("/bookList")
    public String bookList() {
        return "book/bookList";
    }

    /**
     * 查询所有图书信息
     *
     * @param book
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/queryAllBook")
    @ResponseBody
    public DataInfo queryAllBook(Book book, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "15") Integer limit) {
        PageInfo<Book> bookPageInfo = bookService.selectAllBook(book, page, limit);
        return DataInfo.ok("成功", bookPageInfo.getTotal(), bookPageInfo.getList());
    }

    /**
     * 查询所有图书分类名称
     * @return
     */
    @RequestMapping("/queryAllBookType")
    @ResponseBody
    public List<BookType> queryAllBookType(){
        List<BookType> bookTypes = bookTypeService.selectAllBookType();
        return bookTypes;
    }

    /**
     * 添加时检查图书名是否存在
     * @param bookName
     * @return
     */
    @RequestMapping(value = "/bookExist")
    @ResponseBody
    public DataInfo bookExist(@RequestBody String bookName) {
        Book book = bookService.selectByBookName(bookName);
        if (book == null) {
            return DataInfo.ok();
        } else {
            return DataInfo.fail("图书名已存在!");
        }
    }

    /**
     * 跳转添加图书页面
     *
     * @return
     */
    @RequestMapping("/bookAdd")
    public String bookAdd() {
        return "book/bookAdd";
    }

    /**
     * 图书添加
     *
     * @param book
     * @param request
     * @return
     */
    @RequestMapping("/addBook")
    @ResponseBody
    public DataInfo addBook(@RequestBody Book book, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        book.setBookNumber(UUID.randomUUID().toString().substring(0, 6));
        log.info(name + "添加了图书：" + book.getBookName());
        int i = bookService.insertSelective(book);
        System.out.println(i);
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
    @RequestMapping("/bookEdit")
    public String bookEdit(Integer id, Model model) {
        Book book = bookService.selectByPrimaryKey(id);
        model.addAttribute("book", book);
        return "book/bookEdit";
    }

    /**
     * 修改图书信息
     *
     * @param book
     * @param request
     * @return
     */
    @RequestMapping("/editBook")
    @ResponseBody
    public DataInfo editBook(@RequestBody Book book, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        log.info(name + "修改了图书：" + book.getBookName() + "的信息");
        int i = bookService.updateByPrimaryKeySelective(book);
        if (i == 1) {
            log.info("修改成功");
            return DataInfo.ok();
        } else {
            log.info("修改失败");
            return DataInfo.fail("图书修改失败!");
        }
    }

    /**
     * 删除图书信息
     *
     * @param ids
     * @param request
     * @return
     */
    @RequestMapping("/deleteBook")
    @ResponseBody
    public DataInfo deletaBook(String ids, HttpServletRequest request) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        List<String> list = Arrays.asList(ids.split(","));
        log.info(name + "试图删除图书信息");
        int i = bookService.deleteBookByIds(list);
        if (i >= 1) {
            log.info("删除了：" + i + "条信息");
            return DataInfo.ok();
        } else {
            log.info("删除失败");
            return DataInfo.fail("删除失败");
        }
    }
}
