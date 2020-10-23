package com.unknown.hrms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.unknown.hrms.entity.User;

import java.util.Set;

public interface IUserMapper extends BaseMapper<User> {
    public User selectUserByUsername(String username);

    //public  findRoles(String username)

    Set<String> getPersByUserId(Integer id);
}
