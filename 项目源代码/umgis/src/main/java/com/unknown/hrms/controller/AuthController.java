package com.unknown.hrms.controller;


import com.alibaba.druid.util.StringUtils;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.unknown.hrms.entity.*;
import com.unknown.hrms.service.*;
import com.unknown.hrms.utils.ResultEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

@Controller
@RequestMapping(value = "/authController")
public class AuthController {
    @Autowired
    private IRoleService roleService;

    @Autowired
    private IEmpService empService;

    @Autowired
    private IRoleEmpService roleEmpService;

    @Autowired
    private IMenuService menuService;

    @Autowired
    private IRoleMenuService roleMenuService;

    @Autowired
    private IOrgService orgService;

    @RequestMapping(value = "/toAuthPage")
    public String toAuthPage(ModelMap modelMap){
        //查询所有角色
        List<Role> roles = roleService.selectList(null);
        modelMap.put("roleList",roles);
        return "auth/authPage";
    }

    /**
     * 获得所有职员
     * @param roleId
     * @param map
     * @param name
     * @return
     */

    @RequestMapping(value = "/getAllEmp")
    public String getAllEmp(Integer roleId, ModelMap map, String name){
        EntityWrapper<Emp> entityWrapper = new EntityWrapper();
        entityWrapper.like("username",name);
        List<Emp> emps = empService.selectList(entityWrapper);

        map.put("empList",emps);
        map.put("name",name);
        map.put("roleId",roleId);
        return "auth/authEmpList";
    }

    /**
     * 给用户授予角色
     * @param roleId
     * @param empIdList
     * @return
     */

    @RequestMapping(value = "/authUserRole")
    @ResponseBody
    public ResultEntity authUserRole(Integer roleId, @RequestParam("empIdArray[]")List<Integer> empIdList){
        //先判断当前员工是否有这个角色
        EntityWrapper<RoleEmp> wrapper = new EntityWrapper<RoleEmp>();
        wrapper.eq("rid",roleId);
        wrapper.in("uid",empIdList);
        int count = roleEmpService.selectCount(wrapper);
        if(count>0){
            return ResultEntity.faild("您选择的用户中已经存在该角色");
        }else{
            if(roleEmpService.authUserRole(roleId,empIdList)){
                return ResultEntity.success();
            }else{
                return ResultEntity.faild();
            }
        }
    }


    @RequestMapping(value = "/toAuthMenuZtreePage/{roleId}")
    public String toAuthMenuZtreePage(@PathVariable Integer roleId, ModelMap map){
        map.put("roleId",roleId);
        return "auth/authMenuZtree";
    }

    /**
     * 根据角色id获得菜单树
     * @param roleId
     * @return
     */

    @RequestMapping(value = "/getAuthMenuZtreeListByRoleId/{roleId}")
    @ResponseBody
    public List<Map<String,Object>> getAuthMenuZtreeListByRoleId(@PathVariable Integer roleId){
        //先根据角色id查询菜单（目的是为了显示当前角色是否有这个菜单的权限)
        List<Map<String,Object>> list = menuService.getAuthMenuZtreeListByRoleId(roleId);
        //把map中的checked的属性换成boolean类型
        for(Map<String,Object> map:list){
            String value=map.get("checked").toString();
            if(StringUtils.isEmpty(value)){
                map.put("checked",false);
            }else{
                map.put("checked",true);
            }
        }
        return list;
    }

    /**
     * 给角色授权
     * @param roleId
     * @param menuIdList
     * @return
     */

    @RequestMapping(value = "/authRoleMenu")
    @ResponseBody
    @Transactional//事务控制
    public ResultEntity authRoleMenu(Integer roleId, @RequestParam("mIdArray[]")List<Integer> menuIdList){
        //先删除当前角色拥有的菜单权
        roleMenuService.deleteRoleMenuByRoleId(roleId);
        //给当前角色赋予菜单权限
        if(roleMenuService.authRoleMenu(roleId,menuIdList)){
            return ResultEntity.success();
        }else{
            return ResultEntity.faild();
        }
    }

    /**
     * 根据角色id，返回用户列表
     * @param roleId
     * @param map
     * @return
     */

    @RequestMapping(value = "/getEmpListByRoleId/{roleId}")
    public String getEmpListByRoleId(@PathVariable Integer roleId,ModelMap map){
        //根据角色id查询员工信息
        EntityWrapper<RoleEmp> roleEmpEntityWrapper = new EntityWrapper<RoleEmp>();
        roleEmpEntityWrapper.eq("rid",roleId);
        List<RoleEmp> roleEmps = roleEmpService.selectList(roleEmpEntityWrapper);

        //判断
        if(!roleEmps.isEmpty()){
            List<Integer> empIdList = new ArrayList<Integer>();
            for(RoleEmp roleEmp:roleEmps){
                empIdList.add(roleEmp.getUid());
            }
            EntityWrapper<Emp> empEntityWrapper = new EntityWrapper<Emp>();
            empEntityWrapper.in("id",empIdList);
            List<Emp> emps = empService.selectList(empEntityWrapper);
            map.put("empList",emps);
            map.put("roleId",roleId);
        }
        return "auth/roleEmpList";
    }

    /**
     * 根据角色id，职员id删除角色对应的职员
     * @param roleId
     * @param empId
     * @return
     */
    @RequestMapping(value = "/delRoleEmp/{roleId}/{empId}")
    @ResponseBody
    public ResultEntity delRoleEmp(@PathVariable Integer roleId,@PathVariable Integer empId){
        EntityWrapper<RoleEmp> entityWrapper = new EntityWrapper<RoleEmp>();
        entityWrapper.eq("rid",roleId);
        entityWrapper.eq("uid",empId);
        boolean delete = roleEmpService.delete(entityWrapper);
        if(delete){
            return ResultEntity.success("删除成功");
        }else{
            return ResultEntity.faild();
        }
    }

    /**
     * 根据角色id，返回菜单列表
     * @param roleId
     * @param map
     * @return
     */

    @RequestMapping(value = "/getMenuListByRoleId/{roleId}")
    public String getMenuListByRoleId(@PathVariable Integer roleId,ModelMap map){
        List<Menu> menuList = menuService.getMenuListByRoleId(roleId);
        System.out.println(menuList);
        map.put("menuList",menuList);
        return "auth/roleMenuList";
    }

    /**
     * 根据角色id，菜单id，删除角色中的菜单
     * @param roleId
     * @param menuId
     * @return
     */

    @RequestMapping(value = "/delRoleMenu/{roleId}/{menuId}")
    @ResponseBody
    public ResultEntity delRoleMenu(@PathVariable Integer roleId,@PathVariable Integer menuId){
        EntityWrapper<RoleMenu> entityWrapper = new EntityWrapper<RoleMenu>();
        entityWrapper.eq("rid",roleId);
        entityWrapper.eq("mid",menuId);
        boolean delete = roleMenuService.delete(entityWrapper);
        if(delete){
            return ResultEntity.success("删除成功");
        }else{
            return ResultEntity.faild();
        }
    }


    //机构授权
    @RequestMapping(value = "/toAuthOrg")
    public String toAuthOrg(ModelMap modelMap){
        EntityWrapper<Role> orgEntityWrapper = new EntityWrapper<Role>();
        orgEntityWrapper.ne("role_name","管理员");
        orgEntityWrapper.ne("role_name","人事助理");
        List<Role> roles = roleService.selectList(orgEntityWrapper);
        modelMap.put("roleList",roles);
        List<Org> orgs = orgService.selectList(null);
        modelMap.put("orgList",orgs);
        return "auth/authOrg";
    }

    @RequestMapping(value = "/getEmpList/{roleId}")
    public String getEmpList(@PathVariable Integer roleId,ModelMap map){
        //根据角色id查询员工信息
        EntityWrapper<RoleEmp> roleEmpEntityWrapper = new EntityWrapper<RoleEmp>();
        roleEmpEntityWrapper.eq("rid",roleId);
        List<RoleEmp> roleEmps = roleEmpService.selectList(roleEmpEntityWrapper);

        //判断
        if(!roleEmps.isEmpty()){
            List<Integer> empIdList = new ArrayList<Integer>();
            for(RoleEmp roleEmp:roleEmps){
                empIdList.add(roleEmp.getUid());
            }
            EntityWrapper<Emp> empEntityWrapper = new EntityWrapper<Emp>();
            empEntityWrapper.in("id",empIdList);
            List<Emp> emps = empService.selectList(empEntityWrapper);
            for(int i=0;i<emps.size();i++){
                Emp emp = new Emp();
                emp=emps.get(i);
                Org org = orgService.selectById(emp.getOrgno());
                emp.setOrgName2(org.getName());
                emps.set(i,emp);
            }
            map.put("empList",emps);
            map.put("roleId",roleId);
        }
        return "auth/roleOrgList";
    }

    @RequestMapping(value = "/updateEmpOrg")
    @ResponseBody
    public ResultEntity updateEmpOrg(@RequestParam("ids[]") List<Integer> ids,Integer orgId){
        System.out.println(ids);
        EntityWrapper<Emp> empEntityWrapper = new EntityWrapper<Emp>();
        empEntityWrapper.in("id",ids);
        if(empService.updateForSet("orgno="+orgId,empEntityWrapper)){
            return ResultEntity.success();
        }else{
            return ResultEntity.faild();
        }
    }

}
