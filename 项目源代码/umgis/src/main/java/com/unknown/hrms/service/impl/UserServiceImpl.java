package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IUserMapper;
import com.unknown.hrms.entity.User;
import com.unknown.hrms.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Set;

@Service
public class UserServiceImpl extends ServiceImpl<IUserMapper, User> implements IUserService {

    @Autowired
    private IUserMapper userMapper;
    @Override
    public User login(String username, String password) {

        EntityWrapper<User> entityWrapper = new EntityWrapper();
        entityWrapper.eq("username",username);
        entityWrapper.eq("password",password);
        List<User> userList = baseMapper.selectList(entityWrapper);
        if(userList.isEmpty()){
            return null;
        }else{
            //查询当前用户的权限
            return userList.get(0);
        }
    }

    @Override
    public User selectUserByUsername(String username) {
        User user = userMapper.selectUserByUsername(username);
        return user;
    }

    @Override
    public Set<String> getPersByUserId(int id) {
        Set<String> permissionCode = userMapper.getPersByUserId(id);
        return permissionCode;
    }
}
