package com.unknown.hrms.controller;

import com.baomidou.mybatisplus.plugins.Page;
import com.unknown.hrms.entity.Contract;
import com.unknown.hrms.service.IContractService;
import com.unknown.hrms.utils.ResponseUtils;
import com.unknown.hrms.utils.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.List;

@Controller
@RequestMapping(value = "/contractController")
public class ContractController {

    @Autowired
    private IContractService contractService;

    @RequestMapping(value = "/getContractPage")
    public String  getContractPage(Page page, ModelMap map){
        System.out.println("ContractController.getContractPage");
        page=contractService.selectPage(page);
        map.put("url","contractController/getContractPage");
        return "contract/contractList";
    }

    @RequestMapping(value = "/toAddContract")
    public String toAddContract(){
        return "contract/contractAdd";
    }

    @RequestMapping(value = "/addContract")
    @ResponseBody
    public ResultEntity<Object> addContract(Contract contract){
        return ResponseUtils.responseClinet(contractService.insert(contract));
    }

    @RequestMapping(value = "/deleteContract/{id}")
    @ResponseBody
    public ResultEntity deleteDoc(@PathVariable Integer id){
        boolean delete = contractService.deleteById(id);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/getContractById/{id}")
    public String getContractById(@PathVariable Integer id, ModelMap modelMap){
        //System.out.println("222");
        Contract contract=contractService.selectById(id);
        //System.out.println(contract);
        modelMap.put("contract",contract);
        return "contract/contractUpdate";
    }

    @RequestMapping(value = "/updateContract")
    @ResponseBody
    public ResultEntity updateContract(Contract contract){

        return ResponseUtils.responseClinet(contractService.updateById(contract));
    }

    @RequestMapping(value = "/batchDelContract")
    @ResponseBody
    public ResultEntity batchDelContract(@RequestParam("ids[]") List<Integer> ids){

        return ResponseUtils.responseClinet(contractService.deleteBatchIds(ids));
    }


}
