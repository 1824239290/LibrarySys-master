package com.xiaoxie.library.controller;

import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.pojo.Book;
import com.xiaoxie.library.pojo.BorrowBook;
import com.xiaoxie.library.pojo.User;
import com.xiaoxie.library.service.BookService;
import com.xiaoxie.library.service.BorrowBookService;
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


@Controller
@RequestMapping("/borrowBook")
public class BorrowBookController {
    private static final Logger log = LogManager.getLogger(BorrowBookController.class);

    @Autowired
    private BookService bookService;

    @Autowired
    private UserService userService;

    @Autowired
    private BorrowBookService borrowBookService;

    /**
     * 跳转借阅页面
     *
     * @return
     */
    @RequestMapping("/borrowBookList")
    public String borrowBookList() {
        return "borrowBook/borrowBookList";
    }

    /**
     * 跳转读者借阅页面
     *
     * @return
     */
    @RequestMapping("/readerBorrowList")
    public String readerBorrowList() {
        return "readerBorrow/readerBorrowList";
    }

    /**
     * 查询所有借阅记录
     *
     * @param bookName
     * @param libraryCard
     * @param username
     * @param returnBookType
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/queryAllBorrowBook")
    @ResponseBody
    public DataInfo queryAllBorrowBook(String bookName, String libraryCard, String username, String returnBookType, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "15") Integer limit) {

        //借阅对象
        BorrowBook borrowBook = new BorrowBook();
        borrowBook.setLibraryCard(libraryCard);
        if (returnBookType != null && !"".equals(returnBookType)) {
            borrowBook.setReturnBookType(Integer.parseInt(returnBookType));
        }

        //读者对象
        User user = new User();
        user.setUsername(username);

        //图书对象
        Book book = new Book();
        book.setBookName(bookName);

        //级联到借阅对象中
        borrowBook.setUser(user);
        borrowBook.setBook(book);

        //分页查询所有信息
        PageInfo<BorrowBook> borrowBookPageInfo = borrowBookService.selectAllBorrowBook(borrowBook, page, limit);
        return DataInfo.ok("成功", borrowBookPageInfo.getTotal(), borrowBookPageInfo.getList());
    }

    /**
     * 借阅图书跳转
     *
     * @return
     */
    @RequestMapping("/addBorrowBook")
    public String addBorrowBook() {
        return "borrowBook/addBorrowBook";
    }

    /**
     * 借阅图书
     *
     * @param request
     * @param id
     * @param libraryCard
     * @return
     */
    @RequestMapping("/borrowBookSubmit")
    @ResponseBody
    public DataInfo borrowBookSubit(HttpServletRequest request, @RequestParam("id") Integer id, @RequestParam("libraryCard") String libraryCard) {
        HttpSession session = request.getSession();
        Integer uid = (Integer) session.getAttribute("id");
        String name = (String) session.getAttribute("name");
        log.info(name + "试图借阅书籍");
        //先查询借书卡号是否正确
        User user = userService.selectUserByLibraryCard(libraryCard);
        if (user != null && user.getUsername().equals(name)) {
            log.info(name + "借书卡号正确");
            //查询是否已经借了五本书
            int a = borrowBookService.selectCounts(id);
            if (a < 5) {
                log.info(name + "借书少于五本");
                //更新图书状态为已借出
                Book book = new Book();
                book.setId(id);
                book.setBookStatus(1);
                bookService.updateByPrimaryKeySelective(book);
                log.info("已经更新图书状态");
                //借阅信息插入借阅表
                BorrowBook borrowBook = new BorrowBook();
                borrowBook.setBookId(id);
                borrowBook.setLibraryCard(libraryCard);
                borrowBook.setReaderId(uid);
                borrowBook.setBorrowTime(DateUtil.getTimestamp());
                borrowBook.setReturnBookType(4);
                int i = borrowBookService.insertSelective(borrowBook);
                if (i == 1) {
                    log.info(name + "借书成功");
                    return DataInfo.ok();
                } else {
                    log.info(name + "借书失败");
                    return DataInfo.fail("借书失败");
                }
            } else {
                log.info(name + "已经借阅五本书籍");
                return DataInfo.fail("你已经借阅五本书籍，归还图书后可再次借阅");
            }
        } else {
            log.info(name + "借书卡号错误");
            return DataInfo.fail("借书卡号错误");
        }
    }

    /**
     * 正常归还图书
     *
     * @param request
     * @param ids
     * @param bookIds
     * @return
     */
    @RequestMapping("/returnBooks")
    @ResponseBody
    public DataInfo returnBooks(HttpServletRequest request, @RequestParam("ids") String ids, @RequestParam("bookIds") String bookIds) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        log.info(name + "试图归还图书");
        List<String> idsList = Arrays.asList(ids.split(","));
        List<String> bookIdsList = Arrays.asList(bookIds.split(","));
        int a = bookService.updateBookStatusById(bookIdsList);
        log.info(name + "归还了" + a + "本图书");
        BorrowBook borrowBook = new BorrowBook();
        borrowBook.setReturnBookTime(DateUtil.getTimestamp());
        borrowBook.setReturnBookType(0);
        int b = borrowBookService.updateBorrowBookStatusById(borrowBook, idsList);
        log.info(name + "更新了" + b + "跳借阅记录");
        if (a >= 1 && b >= 1) {
            log.info(name + "归还图书成功");
            return DataInfo.ok();
        } else {
            log.info(name + "归还图书失败");
            return DataInfo.fail("还书失败");
        }
    }

    /**
     * 删除借阅信息
     *
     * @param request
     * @param ids
     * @return
     */
    @RequestMapping("/deleteBorrowBook")
    @ResponseBody
    public DataInfo deleteBorrowBook(HttpServletRequest request, String ids) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        List<String> idsList = Arrays.asList(ids.split(","));
        log.info(name + "试图删除借阅信息");
        int i = borrowBookService.deleteBorrowBookByIds(idsList);
        if (i >= 1) {
            log.info("删除成功," + "删除了" + i + "条信息");
            return DataInfo.ok();
        } else {
            log.info("删除失败");
            return DataInfo.fail("删除失败");
        }
    }

    /**
     * 跳转异常还书界面
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/toAbnormalBorrowBook")
    public String toAbnormalBorrowBook(@RequestParam("id") Integer id, Model model) {
        BorrowBook borrowBook = borrowBookService.selectByPrimaryKey(id);
        model.addAttribute("borrowBook", borrowBook);
        return "borrowBook/abnormalBrrowBook";
    }

    /**
     * 异常还书
     *
     * @param borrowBook
     * @return
     */
    @RequestMapping("/abnormalBorrowBook")
    @ResponseBody
    public DataInfo abnormalBorrowBook(HttpServletRequest request, BorrowBook borrowBook) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        log.info(name + "试图异常还书");
        if (borrowBook.getReturnBookType() == 1) {
            int a = borrowBookService.updateByPrimaryKeySelective(borrowBook);
            Book book = new Book();
            book.setBookStatus(2);
            book.setId(borrowBook.getBookId());
            int b = bookService.updateByPrimaryKeySelective(book);
            if (a == 1 && b == 1) {
                log.info(name + "延迟还书成功");
                return DataInfo.ok();
            } else {
                log.info(name + "延迟还书失败");
                return DataInfo.fail("延迟还书失败");
            }
        } else if (borrowBook.getReturnBookType() == 2) {
            borrowBook.setReturnBookTime(DateUtil.getTimestamp());
            int a = borrowBookService.updateByPrimaryKeySelective(borrowBook);
            Book book = new Book();
            book.setBookStatus(0);
            book.setId(borrowBook.getBookId());
            int b = bookService.updateByPrimaryKeySelective(book);
            if (a == 1 && b == 1) {
                log.info(name + "破损还书成功");
                return DataInfo.ok();
            } else {
                log.info(name + "破损还书失败");
                return DataInfo.fail("破损还书失败");
            }
        } else {
            int a = borrowBookService.updateByPrimaryKeySelective(borrowBook);
            Book book = new Book();
            book.setBookStatus(3);
            book.setId(borrowBook.getBookId());
            int b = bookService.updateByPrimaryKeySelective(book);
            if (a == 1 && b == 1) {
                log.info(name + "丢失还书成功");
                return DataInfo.ok();
            } else {
                log.info(name + "丢失还书失败");
                return DataInfo.fail("丢失还书失败");
            }
        }
    }

    @RequestMapping("/updateBooks")
    @ResponseBody
    public DataInfo updateBooks(HttpServletRequest request, @RequestParam("ids") String ids, @RequestParam("bookIds") String bookIds) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");
        List<String> idsList = Arrays.asList(ids.split(","));
        List<String> bookIdsList = Arrays.asList(bookIds.split(","));
        log.info(name + "试图更新延迟还书和丢失还书");
        BorrowBook borrowBook = new BorrowBook();
        borrowBook.setReturnBookTime(DateUtil.getTimestamp());
        borrowBook.setReturnBookType(0);
        borrowBook.setRemark(null);
        int a = borrowBookService.updateBorrowBookStatusById(borrowBook, idsList);
        int b = bookService.updateBookStatusById(bookIdsList);
        if (a >= 1 && b >= 1) {
            log.info(name + "更新成功");
            return DataInfo.ok();
        } else {
            log.info(name + "更新失败");
            return DataInfo.fail("更新异常还书失败");
        }
    }

    /**
     * 借阅时间线
     */
    @RequestMapping("/queryBookList")
    public String queryBookList(String flag, Integer id, Model model) {
        List<BorrowBook> list = null;
        if (flag.equals("book")) {
            list = borrowBookService.queryBorrowBookList(id, null);
        } else {
            list = borrowBookService.queryBorrowBookList(null, id);
        }
        model.addAttribute("borrowBook", list);
        System.out.println(list);
        return "borrowBook/BookList";
    }

    /**
     * 读者借阅时间线
     */
    @RequestMapping("/readerQueryBookList")
    public String readerQueryBookList(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        List<BorrowBook> borrowBooks = borrowBookService.queryBorrowBookList(null, id);
        model.addAttribute("borrowBooks", borrowBooks);
        return "readerBorrow/readerBookList";
    }

    /**
     * 查询读者所有借阅记录
     *
     * @param page
     * @param limit
     * @return
     */
    @RequestMapping("/readerQueryAllBorrowBook")
    @ResponseBody
    public DataInfo readerQueryAllBorrowBook(HttpServletRequest request, @RequestParam(defaultValue = "1") Integer page, @RequestParam(defaultValue = "15") Integer limit) {
        HttpSession session = request.getSession();
        String name = (String) session.getAttribute("name");

        //借阅对象
        BorrowBook borrowBook = new BorrowBook();

        //读者对象
        User user = new User();
        user.setUsername(name);

        //级联到借阅对象中
        borrowBook.setUser(user);

        //分页查询所有信息
        PageInfo<BorrowBook> borrowBookPageInfo = borrowBookService.selectAllBorrowBook(borrowBook, page, limit);
        return DataInfo.ok("成功", borrowBookPageInfo.getTotal(), borrowBookPageInfo.getList());
    }
}
