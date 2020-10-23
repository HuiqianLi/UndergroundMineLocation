package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IOrgMapper;
import com.unknown.hrms.entity.Org;
import com.unknown.hrms.service.IOrgService;
import org.springframework.stereotype.Service;

@Service
public class OrgServiceImpl extends ServiceImpl<IOrgMapper, Org> implements IOrgService {
}
