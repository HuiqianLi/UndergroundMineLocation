package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IRoleEmpMapper;
import com.unknown.hrms.entity.RoleEmp;
import com.unknown.hrms.service.IRoleEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleEmpService extends ServiceImpl<IRoleEmpMapper, RoleEmp> implements IRoleEmpService {
    @Override
    public Boolean authUserRole(Integer roleId, List<Integer> empIdList) {
        return baseMapper.authUserRole(roleId,empIdList);
    }
}
