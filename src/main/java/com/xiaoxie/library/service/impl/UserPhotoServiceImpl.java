package com.xiaoxie.library.service.impl;

import com.xiaoxie.library.dao.UserPhotoMapper;
import com.xiaoxie.library.pojo.UserPhoto;
import com.xiaoxie.library.service.UserPhotoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class UserPhotoServiceImpl implements UserPhotoService {
    @Autowired(required = false)
    private UserPhotoMapper userPhotoMapper;

    @Override
    public int addPhoto(UserPhoto userPhoto) {
        int i = userPhotoMapper.addPhoto(userPhoto);
        return i;
    }

    @Override
    public UserPhoto selectPhoto(Integer id) {
        UserPhoto userPhoto = userPhotoMapper.selectPhoto(id);
        return userPhoto;
    }
}
