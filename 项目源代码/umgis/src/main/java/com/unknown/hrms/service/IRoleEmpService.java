package com.unknown.hrms.service;

import com.baomidou.mybatisplus.service.IService;
import com.unknown.hrms.entity.RoleEmp;

import java.util.List;

public interface IRoleEmpService extends IService<RoleEmp> {
    public Boolean authUserRole(Integer roleId, List<Integer> empIdList);

}
