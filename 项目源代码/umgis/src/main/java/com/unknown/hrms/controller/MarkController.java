package com.unknown.hrms.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.unknown.hrms.entity.Mark;
import com.unknown.hrms.service.IMarkService;
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
@RequestMapping("/markController")
public class MarkController {

    @Autowired
    private IMarkService markService;

    @RequestMapping(value="/getMarkPage")
    public String getMarkPage(Page<Mark> page, ModelMap map){
        //1. 查询数据，最后把page对象赋值给方法的形参，方法的形参会自动放入到ModelMap中
        page = markService.selectPage(page);
        //2. 设置下一页的请求地址
        map.put("url","markController/getMarkPage");
        //3. 跳转到视图
        return "measure/markList";
    }



    @RequestMapping(value = "/toAddMark")
    public String toAddMark(){
        return "measure/addMark";//实现点击跳转
    }

    @RequestMapping(value = "/addMark")
    @ResponseBody
    public ResultEntity addMark(Mark mark){
        System.out.println("mark = " + mark);

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
        Date date = new Date();
        String s = simpleDateFormat.format(date);
        mark.setCreateTime(s);

        boolean insert = markService.insert(mark);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/getMarkById/{id}")
    public String getMarkById(@PathVariable Integer id, ModelMap map){
        Mark mark = markService.selectById(id);
        map.put("mark",mark);
        return "measure/updateMark";
    }

    @RequestMapping(value = "/updateMark")
    @ResponseBody
    public ResultEntity updateMark(Mark mark){
        System.out.println("mark = "+mark);

        boolean update = markService.updateById(mark);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/deleteMark/{id}")
    public ResultEntity deleteMark(@PathVariable Integer id){

        boolean delete = markService.deleteById(id);
        return ResultEntity.success();
    }

    @RequestMapping(value="/batchDelMark")
    @ResponseBody
    public ResultEntity batchDelMark(@RequestParam("ids[]") Integer []ids){
        System.out.println("xxxxxxxxxxxxx:"+ Arrays.toString(ids));
        for(int i=0;i<ids.length;i++)
            markService.deleteById(ids[i]);
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
