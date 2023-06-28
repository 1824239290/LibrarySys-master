package com.xiaoxie.library.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.dao.UserMapper;
import com.xiaoxie.library.pojo.User;
import com.xiaoxie.library.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class UserServiceImpl implements UserService {
    @Autowired(required = false)
    private UserMapper userMapper;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        int i = userMapper.deleteByPrimaryKey(id);
        return 0;
    }

    @Override
    public int insert(User record) {
        int insert = userMapper.insert(record);
        return insert;
    }

    @Override
    public int insertSelective(User record) {
        int i = userMapper.insertSelective(record);
        return i;
    }

    @Override
    public User selectByPrimaryKey(Integer id) {
        User user = userMapper.selectByPrimaryKey(id);
        return user;
    }

    @Override
    public int updateByPrimaryKeySelective(User record) {
        int i = userMapper.updateByPrimaryKeySelective(record);
        return i;
    }

    @Override
    public int updateByPrimaryKey(User record) {
        int i = userMapper.updateByPrimaryKey(record);
        return i;
    }

    @Override
    public User selectByUserName(String username) {
        User user = userMapper.selectByUserName(username);
        return user;
    }

    @Override
    public User selectTelAndEmailByUsername(String username) {
        User user = userMapper.selectTelAndEmailByUsername(username);
        return user;
    }

    @Override
    public int updatePasswordByTelAndEmail(String username, String tel, String email, String password) {
        int i = userMapper.updatePasswordByTelAndEmail(username,tel, email, password);
        return i;
    }

    @Override
    public User selectUserTypeByUP(String username, String password) {
        User user = userMapper.selectUserTypeByUP(username, password);
        return user;
    }

    @Override
    public User selectPasswordById(Integer id) {
        User user = userMapper.selectPasswordById(id);
        return user;
    }

    @Override
    public int updatePasswordById(Integer id,String password) {
        int i = userMapper.updatePasswordById(id,password);
        return i;
    }

    @Override
    public int selectUserNumber() {
        int i = userMapper.selectUserNumber();
        return i;
    }

    @Override
    public PageInfo<User> selectAllUser(User user, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<User> users = userMapper.selectAllUser(user);
        return new PageInfo<>(users);
    }

    @Override
    public int deleteUserByIds(List<String> ids) {
        int i = userMapper.deleteUserByIds(ids);
        return i;
    }

    @Override
    public int updatePwdById(Integer id) {
        int i = userMapper.updatePwdById(id);
        return i;
    }

    @Override
    public PageInfo<User> selectAllAdminUser(User user, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<User> users = userMapper.selectAllAdminUser(user);
        return new PageInfo<>(users);
    }

    @Override
    public User selectUserByLibraryCard(String libraryCard) {
        User user = userMapper.selectUserByLibraryCard(libraryCard);
        return user;
    }

}
