package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IDeptMapper;
import com.unknown.hrms.dao.IEmpMapper;
import com.unknown.hrms.entity.Dept;
import com.unknown.hrms.entity.Emp;
import com.unknown.hrms.entity.Staff;
import com.unknown.hrms.service.IDeptService;
import com.unknown.hrms.service.IEmpService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeptServiceImpl extends ServiceImpl<IDeptMapper, Dept> implements IDeptService {
    @Override
    public List<Staff> findByDeptName(String name) {
        return null;
    }
}
