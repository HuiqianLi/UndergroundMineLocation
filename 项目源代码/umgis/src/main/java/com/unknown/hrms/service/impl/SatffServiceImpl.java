package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IDeptMapper;
import com.unknown.hrms.dao.IStaffMapper;
import com.unknown.hrms.entity.Dept;
import com.unknown.hrms.entity.Staff;
import com.unknown.hrms.service.IDeptService;
import com.unknown.hrms.service.IStaffService;
import org.springframework.stereotype.Service;

@Service
public class SatffServiceImpl extends ServiceImpl<IStaffMapper, Staff> implements IStaffService {
}
