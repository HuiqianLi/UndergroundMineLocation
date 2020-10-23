package com.unknown.hrms.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.unknown.hrms.entity.Dept;
import com.unknown.hrms.entity.Emp;
import com.unknown.hrms.entity.Staff;
import com.unknown.hrms.service.IDeptService;
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
@RequestMapping(value = "/deptController")
public class DeptController {

    @Autowired
    private IDeptService deptService;

    @RequestMapping(value = "/getDeptPage")
    public String getDeptPage(Page<Dept> page, ModelMap map) {
        page = deptService.selectPage(page);
        map.put("url", "deptController/getDeptPage");
        return "dept/deptList";
    }

    @RequestMapping(value = "/addDept")
    @ResponseBody
    public ResultEntity addDept(Dept dept) {
        System.out.println("dept=[" + dept + "]");
        //boolean insert = orgService.insert(org);
        // return ResponseUtils.responseClinet(orgService.insert(org));
        return ResponseUtils.responseClinet(deptService.insert(dept));
    }
    @RequestMapping(value = "/getDeptById/{id}")
    public String getDeptById(@PathVariable Integer id, ModelMap modelMap){
        Dept dept = deptService.selectById(id);
        modelMap.put("dept",dept);
        return  "dept/updateDept";
    }
    /*@RequestMapping(value = "/getStaffList/{name}")
    public String getStaffList(ModelMap map,@PathVariable String name) {
        List<Staff> staffList=deptService.findByDeptName(name);
        map.put("staffList",staffList);
        return  "dept/staffList";
    }*/
    /*@RequestMapping(value = "/getEmpList/{user_id)")//获取我的信息
    public String getEmpList(ModelMap map,@PathVariable Integer user_id) {
        System.out.println("user_id:"+user_id);
        List<Emp> empList=empService.findByUserId(user_id);
        for(Emp emp:empList){
            System.out.println(empList);
        }
        map.put("empList",empList);
        return "emp/empMyList";
    }*/

    @RequestMapping(value = "/updateDept")
    @ResponseBody
    public ResultEntity<? extends Object> updateDept(Dept dept){
        return ResponseUtils.responseClinet(deptService.updateById(dept));
    }
    @RequestMapping(value = "/batchDelDept")
    @ResponseBody
    // ?ids
    public ResultEntity batchDelDept(@RequestParam("ids[]") List<Integer> ids){
        return ResponseUtils.responseClinet(deptService.deleteBatchIds(ids));
    }
}
