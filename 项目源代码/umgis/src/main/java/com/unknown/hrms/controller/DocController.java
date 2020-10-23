package com.unknown.hrms.controller;

import com.unknown.hrms.entity.Doc;
import com.unknown.hrms.entity.User;
import com.unknown.hrms.service.IDocService;
import com.unknown.hrms.utils.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.baomidou.mybatisplus.plugins.Page;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

import java.util.List;


@Controller
@RequestMapping("/docController")
public class DocController {
    @Autowired
    private IDocService docService;

//    @RequestMapping(value = "/getDocList")
//    public String getDocList(ModelMap map){
//        List<Doc> docList=docService.selectList(null);
//        for(Doc docs:docList){
//            System.out.println(docList);
//        }
//        map.put("docList",docList);
//        return "/doc/docList";//自动增加前后缀->/views/menu/menuList.jsp 在resources的spring-mvc.xml里
//    }

    @RequestMapping(value="/getDocPage")
    public String getDocPage(Page<Doc> page, ModelMap map){
        //1. 查询数据，最后把page对象赋值给方法的形参，方法的形参会自动放入到ModelMap中
        page = docService.selectDocPage(page);
        //2. 设置下一页的请求地址
        map.put("url","docController/getDocPage");
        //3. 跳转到视图
        return "doc/docList";
    }

    @RequestMapping(value = "/toAddDoc")
    public String toAddDoc(){
        return "doc/addDoc";//实现点击跳转
    }

    @RequestMapping(value = "/addDoc")
    @ResponseBody
    public ResultEntity addDoc(Doc doc){
        System.out.println("doc = "+doc);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
        Date date = new Date();
        String s = simpleDateFormat.format(date);
        doc.setPubTime(s);
        doc.setModTime(s);
        HttpSession session = getSession();
        User user1 = (User)session.getAttribute("user");
        doc.setOperator(user1.getId().toString());
        boolean insert = docService.insert(doc);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/updateDoc")
    @ResponseBody
    public ResultEntity updateDoc(Doc doc){
        System.out.println("doc = "+doc);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH-mm-ss");
        Date date = new Date();
        String s = simpleDateFormat.format(date);
        doc.setModTime(s);
        HttpSession session = getSession();
        User user1 = (User)session.getAttribute("user");
        doc.setOperator(user1.getId().toString());
        boolean insert = docService.updateById(doc);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/getDocById/{id}")
    public String getDocById(@PathVariable Integer id, ModelMap map){
        Doc doc = docService.selectById(id);
        map.put("doc",doc);
        return "doc/updateDoc";
    }

    @RequestMapping(value = "/deleteDoc/{id}")
    public ResultEntity deleteDoc(@PathVariable Integer id){
        boolean delete = docService.deleteById(id);
        return ResultEntity.success();
    }

    @RequestMapping(value="/batchDelDoc")
    @ResponseBody
    public ResultEntity batchDelDoc(@RequestParam("ids[]") Integer []ids){
        System.out.println("xxxxxxxxxxxxx:"+ Arrays.toString(ids));
        for(int i=0;i<ids.length;i++)
            docService.deleteById(ids[i]);
        return ResultEntity.success();
    }

    @RequestMapping(value = "/getDocByIdForRead/{id}")
    public String getDocByIdForRead(@PathVariable Integer id, ModelMap map){
        Doc doc = docService.selectById(id);
        map.put("doc",doc);
        return "doc/readContent";
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
