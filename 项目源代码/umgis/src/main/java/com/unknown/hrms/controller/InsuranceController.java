package com.unknown.hrms.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.google.gson.Gson;
import com.unknown.hrms.entity.Insurance;
import com.unknown.hrms.service.IInsuranceService;
import com.unknown.hrms.utils.ExcelUtil;
import com.unknown.hrms.utils.ResultEntity;
import com.unknown.hrms.utils.SimpleExportParameter;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping(value = "/insuranceController")
public class InsuranceController {

    @Autowired
    private IInsuranceService insuranceService;

    /**
     * 只显示当月的信息
     * @param map
     * @return
     */
    @RequestMapping(value = "/getInsuranceList")
    public String getInsuranceList(ModelMap map){
        List<Insurance> insuranceList = insuranceService.selectList(null);
        map.put("insuranceList",insuranceList);
        return "wage/insuranceList";
    }

    @RequestMapping(value = "addInsurance")
    @ResponseBody
    public ResultEntity addInsurance(Insurance insurance){
        if(insuranceService.insert(insurance)){
            return ResultEntity.success();
        }else{
            return ResultEntity.faild();
        }
    }

    @RequestMapping(value = "batchDelInsu")
    @ResponseBody
    public ResultEntity batchDelInsu(@RequestParam("ids[]") List<Integer> ids){
        if(insuranceService.deleteBatchIds(ids)){
            return ResultEntity.success();
        }else{
            return ResultEntity.faild();
        }
    }

    @RequestMapping(value = "delInsu/{id}")
    @ResponseBody
    public ResultEntity delInsu(@PathVariable Integer id){
        if(insuranceService.deleteById(id)){
            return ResultEntity.success();
        }else{
            return ResultEntity.faild();
        }
    }

    @RequestMapping(value = "/exportInsu")
    public void exportInsu(Insurance insurance, HttpServletResponse response){
       // List<Map<String,Object>> insurances= insuranceService.exportInsu(insurance);
        List<Map<String,Object>> insuranceList = insuranceService.selectMaps(null);
        System.out.println(insuranceList);
        //文档对象，当成一个excel
        Workbook workbook = new HSSFWorkbook();
        Sheet sheet =  workbook.createSheet("保险公积金数据");
        ExcelUtil excelUtil = new ExcelUtil();
        SimpleExportParameter parameter = new SimpleExportParameter();
        //封装导出的参数
        parameter.setDataList(insuranceList);//放入要导出的数据
        parameter.setTitle("保险公积金数据");
        parameter.setFieldsName("姓名,医保缴费金额,社保缴费金额,公积金缴费金额,缴费日期".split(","));
        parameter.setFieldsId("empName,medicalInsu,socialInsu,accuFund,paymentDate".split(","));
        parameter.setWidths("20,20,20,20,30".split(","));
        //把数据全部写到workbook对象中
        excelUtil.simpleExport(workbook,sheet,parameter);
        try {
            //设置响应头
            response.setContentType("application/x-msdownload");
            response.setHeader("Content-Disposition","attachment;filename=insurance.xls");
            //把文档的流写给浏览器
            workbook.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @RequestMapping(value = "/importInsu")
    @ResponseBody
    public String importInsu(MultipartFile file){
        Map<String,Object> map = new HashMap<String, Object>();
        try {
            Workbook workbook = WorkbookFactory.create(file.getInputStream());
            Sheet sheetAt = workbook.getSheetAt(0);
            List<Map<String, Object>> maps = new ExcelUtil().readSimple(sheetAt, 2, "empName,medicalInsu,socialInsu,accuFund,paymentDate".split(","));
            System.out.println(maps);
            insuranceService.insertMaps(maps);
            map.put("flag",true);
        } catch (Exception e) {
            map.put("flag",false);
            e.printStackTrace();
        }
        return new Gson().toJson(map);
    }

    @RequestMapping(value = "/searchInfo")
    public String searchInfo(@RequestParam String empName,ModelMap map){
        System.out.println(empName);
        EntityWrapper<Insurance> entityWrapper = new EntityWrapper<Insurance>();
        entityWrapper.le("emp_name",empName);
        List<Insurance> insurances = insuranceService.selectList(entityWrapper);
        map.put("insuranceList",insurances);
        return "wage/insuranceList";
    }
}
