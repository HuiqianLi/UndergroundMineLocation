package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.IService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IContractMapper;
import com.unknown.hrms.entity.Contract;
import com.unknown.hrms.service.IContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ContractServiceImpl extends ServiceImpl<IContractMapper,Contract> implements IContractService{

}