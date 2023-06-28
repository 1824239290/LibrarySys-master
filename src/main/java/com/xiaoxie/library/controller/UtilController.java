package com.xiaoxie.library.controller;

import com.xiaoxie.library.pojo.Book;
import com.xiaoxie.library.service.BookService;
import com.xiaoxie.library.service.BookTypeService;
import com.xiaoxie.library.service.BorrowBookService;
import com.xiaoxie.library.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;


@Controller
@RequestMapping("/util")
public class UtilController {
    @Autowired
    private UserService userService;

    @Autowired
    private BookService bookService;

    @Autowired
    private BookTypeService bookTypeService;

    @Autowired
    private BorrowBookService borrowBookService;

    /**
     * 首页统计和图标数据查询
     * @return
     */
    @RequestMapping("/getCount")
    @ResponseBody
    public synchronized Map<String,Object> getCount(){
        Map<String,Object> map = new HashMap<>(16);
        int user = userService.selectUserNumber();
        int book = bookService.selectBookNumber();
        int bookType = bookTypeService.selectAllBookTypeNumber();
        int borrowBook = borrowBookService.selectAllBorrowBookNumber();
        map.put("user",user);
        map.put("book",book);
        map.put("bookType",bookType);
        map.put("borrowBook",borrowBook);
        return map;
    }
}
