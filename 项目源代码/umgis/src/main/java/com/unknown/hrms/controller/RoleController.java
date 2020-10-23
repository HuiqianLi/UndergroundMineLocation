package com.unknown.hrms.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.unknown.hrms.entity.Role;
import com.unknown.hrms.entity.RoleEmp;
import com.unknown.hrms.entity.RoleMenu;
import com.unknown.hrms.service.IRoleEmpService;
import com.unknown.hrms.service.IRoleMenuService;
import com.unknown.hrms.service.IRoleService;
import com.unknown.hrms.utils.ResultEntity;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping(value = "/roleController")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @Autowired
    private IRoleEmpService roleEmpService;

    @Autowired
    private IRoleMenuService roleMenuService;

    @RequestMapping(value = "/getRoleList")
    @RequiresPermissions("system:role")
    public String getRoleList(ModelMap map){
        List<Role> roleList=roleService.selectList(null);
        map.put("roleList",roleList);
        return "role/roleList";
    }

    @RequestMapping(value = "/addRole")
    @ResponseBody
    public ResultEntity addRole(String roleName, String roleDesc){

        Role role = new Role();
        role.setRoleName(roleName);
        role.setRoleDesc(roleDesc);
        role.setRoleState(1);
        boolean insert = roleService.insert(role);
        if(insert){
            return ResultEntity.success();
        }else{
            return ResultEntity.faild();
        }
    }

    @RequestMapping(value = "/batchDelRole")
    @ResponseBody
    @Transactional
    public ResultEntity batchDelRole(@RequestParam("ids[]") List<Integer>  ids){
        //删除用户角色表,菜单表
        for(Integer id:ids){
            EntityWrapper<RoleEmp> roleEmpWrapper = new EntityWrapper<RoleEmp>();
            roleEmpWrapper.eq("rid",id);
            roleEmpService.delete(roleEmpWrapper);
            EntityWrapper<RoleMenu> roleMenuWrapper = new EntityWrapper<RoleMenu>();
            roleMenuWrapper.eq("rid",id);
            roleMenuService.delete(roleMenuWrapper);
        }
       if(roleService.deleteBatchIds(ids)){
           return ResultEntity.success();
       }else{
           return ResultEntity.faild();
       }
    }

    @RequestMapping(value = "delRole/{roleId}")
    @ResponseBody
    @Transactional
    public ResultEntity delRole(@PathVariable Integer roleId){
        EntityWrapper<RoleEmp> roleEmpWrapper = new EntityWrapper<RoleEmp>();
        roleEmpWrapper.eq("rid",roleId);
        roleEmpService.delete(roleEmpWrapper);
        EntityWrapper<RoleMenu> roleMenuWrapper = new EntityWrapper<RoleMenu>();
        roleMenuWrapper.eq("rid",roleId);
        roleMenuService.delete(roleMenuWrapper);
        if(roleService.deleteById(roleId)){
            return ResultEntity.success();
        }else{
            return ResultEntity.faild();
        }
    }

    @RequestMapping(value = "/getRoleById/{id}")
    public String getRoleById(@PathVariable Integer id,ModelMap map){
        Role role = roleService.selectById(id);
        map.put("role",role);
        return "role/updateRole";
    }
    @RequestMapping(value ="/updateRole" )
    @ResponseBody
    public ResultEntity updateRole(Integer id,String roleName,String roleDesc){
        Role role = new Role();
        role.setId(id);
        role.setRoleName(roleName);
        role.setRoleDesc(roleDesc);
        if(roleService.updateById(role)){
            return ResultEntity.success();
        }else{
            return ResultEntity.faild();
        }
    }
}
