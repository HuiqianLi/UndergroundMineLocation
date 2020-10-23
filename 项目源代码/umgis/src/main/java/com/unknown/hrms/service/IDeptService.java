package com.unknown.hrms.service;

import com.baomidou.mybatisplus.service.IService;
import com.unknown.hrms.entity.Dept;
import com.unknown.hrms.entity.Emp;
import com.unknown.hrms.entity.Staff;

import java.util.List;

public interface IDeptService extends IService<Dept> {

    List<Staff> findByDeptName(String name);
}