package com.unknown.hrms.interceprot;


import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 拦截器，判断用户是否登录
 */

@Component
public class LoginIntercepror implements HandlerInterceptor {


    /**
     * 在Controller执行之前进行调用
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        //获取登录的用户状态
        Object user = httpServletRequest.getSession().getAttribute("user");
        //判断是否是登录的状态
        if(user!=null){
            return true;
        }else{
            //如果没有登录，跳转到登录页面
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath()+"/toLogin");
        }
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
