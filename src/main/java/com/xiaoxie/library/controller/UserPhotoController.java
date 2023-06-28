package com.xiaoxie.library.controller;

import com.xiaoxie.library.pojo.UserPhoto;
import com.xiaoxie.library.service.UserPhotoService;
import com.xiaoxie.library.utils.DataInfo;
import com.xiaoxie.library.utils.DateUtil;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.UUID;


@Controller
@RequestMapping("/photo")
public class UserPhotoController {
    private static final Logger log = LogManager.getLogger(UserPhotoController.class);

    @Autowired
    private UserPhotoService userPhotoService;

    @RequestMapping("/toUpload")
    public String toUpload() {
        return "upload";
    }

    /**
     * 上传头像
     * @param request
     * @param multipartFile
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    public DataInfo upload(HttpServletRequest request, @RequestParam("file") MultipartFile multipartFile) throws IOException {
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        //获取上传的图片的文件名
        String fileName = multipartFile.getOriginalFilename();
        log.info("上传的头像名称为：" + fileName);
        //获取上传文件的大小
        long size = multipartFile.getSize();
        log.info("上传的头像大小为：" + fileName);
        //获取上传文件的后缀名
        String suffixName = fileName.substring(fileName.lastIndexOf("."));
        log.info("上传的头像后缀为：" + suffixName);
        //将UUID作为文件名，并去掉四个"-"
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        //设置图片上传路径
        String url = request.getSession().getServletContext().getRealPath("images");
        log.info("上传的头像的存储路径为：" + url);
        File file = new File(url);
        if (!file.exists()) {
            //若不存在，则创建目录
            file.mkdir();
        }
        //将uuid和后缀名拼接后的结果作为最终的文件名
        fileName = uuid + suffixName;
        log.info("上传的头像的新的名称为：" + fileName);
        String filePath = url + File.separator + fileName;
        log.info("保存重名命后的图片路径为：" + filePath);
        //以绝对路径保存重名命后的图片
        multipartFile.transferTo(new File(filePath));
        log.info(id+"试图保存头像到数据库");
        int i = userPhotoService.addPhoto(new UserPhoto(null,id,"images/"+fileName, DateUtil.getTimestamp()));
        if (i == 1) {
            log.info(id+"保存头像到数据库成功");
            return DataInfo.ok();
        } else {
            log.info(id+"保存头像到数据库失败");
            return DataInfo.fail("上传失败");
        }
    }

    @RequestMapping("/queryPhoto")
    @ResponseBody
    public DataInfo queryPhoto(HttpServletRequest request){
        HttpSession session = request.getSession();
        Integer id = (Integer) session.getAttribute("id");
        UserPhoto userPhoto = userPhotoService.selectPhoto(id);
        return DataInfo.ok("成功",userPhoto);
    }

}
