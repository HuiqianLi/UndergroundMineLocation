package com.unknown.hrms.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.unknown.hrms.entity.Emp;
import com.unknown.hrms.entity.Org;
import com.unknown.hrms.service.IOrgService;
import com.unknown.hrms.service.IEmpReService;
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
@RequestMapping(value = "/empReController")
public class EmpReController {

    @Autowired
    private IEmpReService empReService;

    @Autowired
    private IOrgService orgService;

//    public EmpReController(IOrgService orgService) {
//        this.orgService = orgService;
//    }

    @RequestMapping(value = "/getEmpRePage")
    public String  getEmpRePage(Page page, ModelMap map){
        System.out.println("EmpReController.getEmpRePage");
        page=empReService.selectPage(page);
        map.put("url","empReController/getEmpRePage");
        return "empRe/empReList";
    }

    @RequestMapping(value = "/toAddEmpRe")
    public String toAddEmpRe(){
        return "empRe/empReAdd";
    }

    @RequestMapping(value = "/addEmpRe")
    @ResponseBody
    public ResultEntity<Object> addEmpRe(Emp empRe){

        return ResponseUtils.responseClinet(empReService.insert(empRe));
    }

    //    @RequestMapping(value = "/deleteById")
//    public ResultEntity<Object> deleteByID(Integer id){
//        return  ResponseUtils.responseClinet(empReService.deleteById(id));
//    }
    @RequestMapping(value = "/deleteEmpRe/{id}")
    public ResultEntity deleteDoc(@PathVariable Integer id){
        boolean delete = empReService.deleteById(id);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/getEmpReById/{id}")
    public String getEmpReById(@PathVariable Integer id, ModelMap modelMap){
        Emp empRe=empReService.selectById(id);
        modelMap.put("empRe",empRe);
        //System.out.println("111");
        //List<Org> orgList=orgService.selectList(null);
        List<Org> orgList=orgService.selectList(null);
        modelMap.put("orgList",orgList);
        System.out.println("orgList:"+orgList);
        return "empRe/empReUpdate";
    }

    @RequestMapping(value = "/updateEmpRe")
    @ResponseBody
    public ResultEntity<? extends Object> updateEmpRe(Emp empRe){

        return ResponseUtils.responseClinet(empReService.updateById(empRe));
    }

    @RequestMapping(value = "/batchDelEmpRe")
    @ResponseBody
    public ResultEntity batchDelEmpRe(@RequestParam("ids[]") List<Integer> ids){

        return ResponseUtils.responseClinet(empReService.deleteBatchIds(ids));
    }


    public void setOrgService(IOrgService orgService) {
        this.orgService = orgService;
    }
}
