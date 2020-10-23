package com.unknown.hrms.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.unknown.hrms.entity.Distance;
import com.unknown.hrms.service.IDistanceService;
import com.unknown.hrms.utils.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;


@Controller
@RequestMapping("/distanceController")
public class DistanceController {

    @Autowired
    private IDistanceService salaryService;

    @RequestMapping(value="/getDistancePage")
    public String getDistancePage(Page<Distance> page, ModelMap map){
        //1. 查询数据，最后把page对象赋值给方法的形参，方法的形参会自动放入到ModelMap中
        page = salaryService.selectPage(page);
        //2. 设置下一页的请求地址
        map.put("url","salaryController/getDistancePage");
        //3. 跳转到视图
        return "measure/distanceList";
    }



    @RequestMapping(value = "/toAddDistance")
    public String toAddDistance(){
        return "measure/addDistance";//实现点击跳转
    }

    @RequestMapping(value = "/addDistance")
    @ResponseBody
    public ResultEntity addDistance(Distance distance){
        System.out.println("distance = " + distance);

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
        Date date = new Date();
        String s = simpleDateFormat.format(date);
        distance.setCreateTime(s);

        boolean insert = salaryService.insert(distance);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/getDistanceById/{id}")
    public String getDistanceById(@PathVariable Integer id, ModelMap map){
        Distance distance = salaryService.selectById(id);
        map.put("distance",distance);
        return "measure/updateDistance";
    }

    @RequestMapping(value = "/updateDistance")
    @ResponseBody
    public ResultEntity updateDistance(Distance distance){
        System.out.println("distance = "+distance);

        boolean update = salaryService.updateById(distance);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/deleteDistance/{id}")
    public ResultEntity deleteDistance(@PathVariable Integer id){

        System.out.println("distance1111111111111111 ");
        boolean delete = salaryService.deleteById(id);
        return ResultEntity.success();
    }

    @RequestMapping(value="/batchDelDistance")
    @ResponseBody
    public ResultEntity batchDelDistance(@RequestParam("ids[]") Integer []ids){
        System.out.println("xxxxxxxxxxxxx:"+ Arrays.toString(ids));
        for(int i=0;i<ids.length;i++)
            salaryService.deleteById(ids[i]);
        return ResultEntity.success();
    }




    public static HttpSession getSession() {
        HttpSession session = null;
        try {
            session = getRequest().getSession();
        } catch (Exception e) {}
        return session;
    }
    public static HttpServletRequest getRequest() {
        ServletRequestAttributes attrs = (ServletRequestAttributes) RequestContextHolder
                .getRequestAttributes();
        return attrs.getRequest();
    }


}
