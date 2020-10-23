package com.unknown.hrms.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.unknown.hrms.entity.Distance;
import com.unknown.hrms.entity.Emp;
import com.unknown.hrms.entity.Org;
import com.unknown.hrms.entity.chart;
import com.unknown.hrms.service.IEmpService;
import com.unknown.hrms.utils.ResponseUtils;
import com.unknown.hrms.utils.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/empController")
public class EmpController {

    @Autowired
    private IEmpService empService;

    /*  @RequestMapping(value = "/getEmpPage")//获取所有员工
      public String getEmpPage(Page<Emp> page, ModelMap map) {
          page = empService.selectPage(page);
          map.put("url", "empController/getEmpPage");
          return "emp/empList";
      }*/
    @RequestMapping(value = "/getEmpList/{user_id}")//获取和我在同一个机构的员工
    public String getEmpList(ModelMap map, @PathVariable Integer user_id) {
        System.out.println("user_id:"+user_id);
//        List<Emp> empList=empService.findOrgByUserId(user_id);
        List<Emp> empList=empService.selectList(null);
        for(Emp emp:empList){
            System.out.println(empList);
            System.out.println("111111111");
        }
        map.put("empList",empList);
        return "emp/empList";
    }


    @RequestMapping(value = "/getMyEmpList/{user_id}")//获取我的信息
    public String getMyEmpList(ModelMap map,@PathVariable Integer user_id) {
        System.out.println("user_id:"+user_id);
        List<Emp> empList=empService.findByUserId(user_id);
        for(Emp emp:empList){
            System.out.println(empList);
        }
        map.put("empList",empList);
        return "emp/empMyList";
    }

    @RequestMapping(value = "/addEmp")
    @ResponseBody
    public ResultEntity addEmp(Emp emp) {
        System.out.println("emp=[" + emp + "]");
        //boolean insert = empService.insert(emp);
        // return ResponseUtils.responseClinet(orgService.insert(org));
        return ResponseUtils.responseClinet(empService.insert(emp));
    }


    @RequestMapping(value = "/getEmpById/{id}")
    public String getEmpById(@PathVariable Integer id, ModelMap modelMap) {
        Emp emp = empService.selectById(id);
        modelMap.put("emp", emp);
        return "emp/updateEmp";
    }

    @RequestMapping(value = "/updateEmp")
    @ResponseBody
    public ResultEntity updateEmp(Emp emp) {
        return ResponseUtils.responseClinet(empService.updateById(emp));
    }


    @RequestMapping(value = "/batchDelEmp")
    @ResponseBody
    // ?ids
    public ResultEntity batchDelEmp(@RequestParam("ids[]") List<Integer> ids){
        return ResponseUtils.responseClinet(empService.deleteBatchIds(ids));
    }
    @RequestMapping(value = "/getOrgChart")
    public String getOrgChart(ModelMap map){
        List<Integer> maleData = empService.getMaleData();
        List<Integer> femaleData = empService.getFemaleData();
        map.put("maleData",maleData);
        map.put("femaleData",femaleData);
        return "chart/orgChart";
    }

    @RequestMapping(value = "/getEducationChart")
    @ResponseBody
    public List<chart> getEducationChart(ModelMap map){
        List<chart> educationList = new ArrayList<chart>();
        educationList = empService.selectEduGroupBy();
        map.put("educationList",educationList);
        return educationList;
    }
}

