package com.test.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("")
public class IndexController extends BaseController {

    @RequestMapping("/index")
    public String index() {
        return "index";
    }

    @RequestMapping("/login")
    public String login() {
        return "login";
    }
    
    @RequestMapping("/register")
    public String register() {
        return "register";
    }
    
    @RequestMapping("/forgotPwd")
    public String forgotpwd() {
        return "forgotPwd";
    }

    @RequestMapping("/forgotPwd2")
    public String forgotpwd2() {
        return "forgotPwd2";
    }
    
    @RequestMapping("/forgotPwd3")
    public String forgotpwd3() {
        return "forgotPwd3";
    }
    
    @RequestMapping("/bootPage")
    public String bootPage() {
        return "bootPage";
    }

    @RequestMapping("/userCenter")
    public String userCenter() {
        return "userCenter";
    }
}
