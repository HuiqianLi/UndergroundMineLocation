package com.unknown.hrms.service;

import com.baomidou.mybatisplus.service.IService;
import com.unknown.hrms.entity.User;

import java.util.Set;

public interface IUserService extends IService<User> {
    public User login(String username, String password);

    public User selectUserByUsername(String username);

    public Set<String> getPersByUserId(int id);
}
