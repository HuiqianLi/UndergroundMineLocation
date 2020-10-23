package com.unknown.hrms.controller;

import com.unknown.hrms.entity.User;
import com.unknown.hrms.service.IUserService;
import com.unknown.hrms.utils.ResultEntity;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;


@Controller//Controller-@ResponseBody
@RequestMapping("/userController")
public class UserController {

    @Autowired
    private IUserService userService;

    //登录,身份认证失败的时候会调用
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    @ResponseBody
    public ResultEntity login(String username, String password, HttpSession session) {
        Subject currentUser = SecurityUtils.getSubject();
        try {
            //未认证登录
            if(!currentUser.isAuthenticated()) {
                UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username,password);
                //认证登陆
                currentUser.login(usernamePasswordToken);
            }
        } catch (AuthenticationException e) {
            if(e instanceof AccountException) {
                return ResultEntity.faild("账号或密码错误");
            }
        }


        User user = userService.selectUserByUsername(username);
        session.setAttribute("user",user);
        return ResultEntity.success("登陆成功");
    }
    // 注册
    // 密码的修改
}
