package com.xiaoxie.library.service;

import com.github.pagehelper.PageInfo;
import com.xiaoxie.library.pojo.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import java.util.List;


public interface UserService {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);

    //注册重名查询
    User selectByUserName(String username);

    //根据用户名查手机号和邮箱
    User selectTelAndEmailByUsername(String username);

    //根据手机号或邮箱，修改密码
    int updatePasswordByTelAndEmail(@Param("username") String username,@Param("tel") String tel, @Param("email") String email, @Param("password") String password);

    //根据用户名密码查询用户类型,用户状态和用户id
    User selectUserTypeByUP(@Param("username") String username,@Param("password") String password);

    //根据id查询旧密码是否正确
    User selectPasswordById(Integer id);

    //根据id修改密码
    int updatePasswordById(@Param("id") Integer id,@Param("password") String password);

    //查询总的有多少用户
    int selectUserNumber();

    //查询所有用户信息
    PageInfo<User> selectAllUser(@Param("user") User user, @Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

    //根据id集合批量删除用户信息
    int deleteUserByIds(List<String> ids );

    //根据id重置密码为123456
    int updatePwdById(Integer id);

    //查询所有管理员信息
    PageInfo<User> selectAllAdminUser(@Param("user") User user, @Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize);

    //根据借书卡号查询是否是登录用户的
    User selectUserByLibraryCard(String libraryCard);
}
