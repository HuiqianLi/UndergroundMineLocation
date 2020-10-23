package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IEmpReMapper;
import com.unknown.hrms.entity.Emp;
import com.unknown.hrms.service.IEmpReService;
import org.springframework.stereotype.Service;

@Service
public class EmpReServiceImpl extends ServiceImpl<IEmpReMapper,Emp> implements IEmpReService{

}