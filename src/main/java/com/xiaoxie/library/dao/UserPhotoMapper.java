package com.xiaoxie.library.dao;

import com.xiaoxie.library.pojo.UserPhoto;


public interface UserPhotoMapper {

    //把图片路径插入数据库
    int addPhoto(UserPhoto userPhoto);

    //根据登录用户的id查出对应的头像
    UserPhoto selectPhoto(Integer id);
}
