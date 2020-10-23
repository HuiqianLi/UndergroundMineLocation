package com.unknown.hrms.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.unknown.hrms.entity.Area;
import com.unknown.hrms.service.IAreaService;
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
@RequestMapping("/areaController")
public class AreaController {

    @Autowired
    private IAreaService areaService;

    @RequestMapping(value="/getAreaPage")
    public String getAreaPage(Page<Area> page, ModelMap map){
        //1. 查询数据，最后把page对象赋值给方法的形参，方法的形参会自动放入到ModelMap中
        page = areaService.selectPage(page);
        //2. 设置下一页的请求地址
        map.put("url","areaController/getAreaPage");
        //3. 跳转到视图
        return "measure/areaList";
    }



    @RequestMapping(value = "/toAddArea")
    public String toAddArea(){
        return "measure/addArea";//实现点击跳转
    }

    @RequestMapping(value = "/addArea")
    @ResponseBody
    public ResultEntity addArea(Area area){
        System.out.println("area = " + area);

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
        Date date = new Date();
        String s = simpleDateFormat.format(date);
        area.setCreateTime(s);

        boolean insert = areaService.insert(area);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/getAreaById/{id}")
    public String getAreaById(@PathVariable Integer id, ModelMap map){
        Area area = areaService.selectById(id);
        map.put("area",area);
        return "measure/updateArea";
    }

    @RequestMapping(value = "/updateArea")
    @ResponseBody
    public ResultEntity updateArea(Area area){
        System.out.println("area = "+area);

        boolean update = areaService.updateById(area);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/deleteArea/{id}")
    public ResultEntity deleteArea(@PathVariable Integer id){

        boolean delete = areaService.deleteById(id);
        return ResultEntity.success();
    }

    @RequestMapping(value="/batchDelArea")
    @ResponseBody
    public ResultEntity batchDelArea(@RequestParam("ids[]") Integer []ids){
        System.out.println("xxxxxxxxxxxxx:"+ Arrays.toString(ids));
        for(int i=0;i<ids.length;i++)
            areaService.deleteById(ids[i]);
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
