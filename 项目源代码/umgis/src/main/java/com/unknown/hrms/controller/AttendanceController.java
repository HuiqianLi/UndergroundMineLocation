package com.unknown.hrms.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.github.pagehelper.PageInfo;
import com.unknown.hrms.entity.Attendance;
import com.unknown.hrms.service.IAttendanceService;

import com.unknown.hrms.utils.ResponseUtils;
import com.unknown.hrms.utils.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("attendanceController")
public class AttendanceController {

    @Autowired
    private IAttendanceService attendanceService;

    //考勤列表
    @RequestMapping(value = "/getAttendanceList")
    public String getAttendanceList(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize,
            ModelMap map){
//        System.out.println("AttendanceController.getAttendanceList");
//       PageInfo<Attendance> page=attendanceService.getPage(pageNum,pageSize);
//       map.put("pageInfo",page);
//        page.getTotal();
        List<Attendance> attendanceList=attendanceService.selectList(null);
        for(Attendance attendance:attendanceList){
            System.out.println(attendanceList);
        }
        map.put("attendanceList",attendanceList);
        return "/attendance/attendanceList";
    }

    //考勤录入,通过编辑  考勤状态
    @RequestMapping(value = "updateAttendanceById")
    public String updateAttendanceById(HttpServletRequest request){


        System.out.println("1224124");
        return "attendance/attendanceUpdate";
    }

    @RequestMapping(value = "/getAttendanceById/{id}")
    public String getAttendanceById(@PathVariable Integer id,ModelMap modelMap){
        Attendance attendance = attendanceService.selectById(id);
        modelMap.put("attendance",attendance);
        return "attendance/attendanceUpdate";
    }

    @RequestMapping(value = "/updateAttendance")
    @ResponseBody
    public ResultEntity updateAttendance(Attendance attendance){
        /*attendanceService.update(attendance);
        return  ResultEntity.success();*/
        return ResponseUtils.responseClinet(attendanceService.updateById(attendance));
    }

    //我的考勤
    @RequestMapping(value = "/getMyAttendanceList/{user_id}")
    public String getMyAttendanceList(ModelMap map, @PathVariable Integer user_id){

        System.out.println("user_id:"+user_id);
        List<Attendance> attendanceList=attendanceService.findByUserId(user_id);
        //      Attendance attendanceList = attendanceService.findByUserId(user_id);
        System.out.println("001");
        for(Attendance attendance:attendanceList){
            System.out.println(attendanceList);
        }
        //    System.out.println(attendanceList);
        map.put("attendanceList",attendanceList);
        return "/attendance/attendanceMyList";
    }

    @RequestMapping(value = "/deleteById/{id}")
    @ResponseBody
    public ResultEntity deleteById(@PathVariable Integer id){
        return ResponseUtils.responseClinet(attendanceService.deleteById(id));
    }
}
