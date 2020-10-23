package com.unknown.hrms.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.unknown.hrms.entity.Org;
import com.unknown.hrms.service.IOrgService;
import com.mysql.jdbc.util.ResultSetUtil;
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

import java.io.Serializable;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/orgController")
public class OrgController {
    @Autowired
    private IOrgService orgService;

    @RequestMapping(value = "/getOrgPage")
    public String getOrgPage(Page<Org> page, ModelMap map) {
        page = orgService.selectPage(page);
        map.put("url", "orgController/getOrgPage");
        return "org/orgList";

    }

    @RequestMapping(value = "/addOrg")
    @ResponseBody
    public ResultEntity addOrg(Org org) {
        System.out.println("org=[" + org + "]");
        //boolean insert = orgService.insert(org);
        // return ResponseUtils.responseClinet(orgService.insert(org));
        return ResponseUtils.responseClinet(orgService.insert(org));
    }

    @RequestMapping(value = "/getOrgById/{id}")
    public String getEmpById(@PathVariable Integer id, ModelMap modelMap) {
        Org org = orgService.selectById(id);
        modelMap.put("org", org);
        return "org/updateOrg";
    }

    @RequestMapping(value = "/updateOrg")
    @ResponseBody
    public ResultEntity updateOrg(Org org) {
        return ResponseUtils.responseClinet(orgService.updateById(org));
    }

    @RequestMapping(value = "/batchCombineOrg" )
    @ResponseBody
    // ?ids
    public ResultEntity batchCombineOrg(@RequestParam("ids[]") List<Integer> ids){
        return ResponseUtils.responseClinet(orgService.deleteBatchIds(ids));
    }

    @RequestMapping(value = "/batchDelOrg" )
    @ResponseBody
    // ?ids
    public ResultEntity batchDelOrg(@RequestParam("ids[]") List<Integer> ids){
        return ResponseUtils.responseClinet(orgService.deleteBatchIds(ids));
    }





}