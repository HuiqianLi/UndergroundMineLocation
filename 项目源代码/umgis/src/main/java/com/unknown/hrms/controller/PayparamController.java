package com.unknown.hrms.controller;


import com.unknown.hrms.entity.Payparam;
import com.unknown.hrms.entity.Role;
import com.unknown.hrms.service.IPayparamService;
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
import java.util.List;

@Controller
@RequestMapping("payparamController")
public class PayparamController {

    @Autowired
    private IPayparamService payparamService;

    //参数列表
    @RequestMapping(value = "/getPayparamList")
    public String getPayparamList(ModelMap map){
        List<Payparam> payparamList = payparamService.selectList(null);
        map.put("payparamList",payparamList);
        return "payparam/payparamList";
    }

    @RequestMapping(value = "/getPayparamById/{id}")
    public String getPayparamById(@PathVariable Integer id,ModelMap map){
        Payparam payparam = payparamService.selectById(id);
        map.put("payparam",payparam);
        return "payparam/payparamUpdate";
    }

    //参数修改
    @RequestMapping(value = "/updatePayparam")
    @ResponseBody
    public ResultEntity updatePayparam(Payparam payparam){
        payparamService.update(payparam);
        return ResultEntity.success();
    }

    //参数添加
    @RequestMapping(value = "addPayparam")
    public String  addPayparam(Payparam payparam, Model model)
    {
        System.out.println("payparam1=[" + payparam + "]");
        //   payparamService.add(payparam);

        return "payparam/payparamAdd";
    }
    @RequestMapping(value = "toaddPayparam")
    @ResponseBody
    public ResultEntity  toaddPayparam(Payparam payparam)
    {
        System.out.println("payparam2=[" + payparam + "]");
        payparamService.add(payparam);
        /*model.addAttribute("msg","参数保存成功");*/
        return  ResultEntity.success();
    }
    //参数删除
    @RequestMapping(value = "/deleteById/{id}")
    @ResponseBody
    public ResultEntity deleteById(Model model, @PathVariable Integer id){
        payparamService.deleteById(id);
        /*model.addAttribute("msg","删除用户成功");*/
        return  ResultEntity.success();
    }
}
