package com.unknown.hrms.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.unknown.hrms.entity.Dept;
import com.unknown.hrms.entity.Staff;
import com.unknown.hrms.service.IDeptService;
import com.unknown.hrms.service.IStaffService;
import com.unknown.hrms.utils.ResponseUtils;
import com.unknown.hrms.utils.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping(value = "/staffController")
public class StaffController {

    @Autowired
    private IStaffService staffService;

    @RequestMapping(value = "/getStaffPage")
    public String getStaffPage(Page<Staff> page, ModelMap map) {
        page = staffService.selectPage(page);
        map.put("url", "staffController/getStaffPage");
        return "staff/staffList";
    }

    @RequestMapping(value = "/addStaff")
    @ResponseBody
    public ResultEntity addStaff(Staff staff) {
        System.out.println("staff=[" + staff + "]");
        //boolean insert = orgService.insert(org);
        // return ResponseUtils.responseClinet(orgService.insert(org));
        return ResponseUtils.responseClinet(staffService.insert(staff));
    }
    @RequestMapping(value = "/getStaffById/{id}")
    public String getStaffById(@PathVariable Integer id, ModelMap modelMap){
        Staff staff = staffService.selectById(id);
        modelMap.put("staff",staff);
        return  "staff/updateStaff";
    }

    @RequestMapping(value = "/updateStaff")
    @ResponseBody
    public ResultEntity<? extends Object> updateStaff(Staff staff){
        return ResponseUtils.responseClinet(staffService.updateById(staff));
    }
    @RequestMapping(value = "/batchDelStaff")
    @ResponseBody
    // ?ids
    public ResultEntity batchDelStaff(@RequestParam("ids[]") List<Integer> ids){
        return ResponseUtils.responseClinet(staffService.deleteBatchIds(ids));
    }
}
