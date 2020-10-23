package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IRoleMapper;
import com.unknown.hrms.entity.Role;
import com.unknown.hrms.service.IRoleService;
import org.springframework.stereotype.Service;

@Service
public class RoleServiceImpl extends ServiceImpl<IRoleMapper, Role> implements IRoleService {
}
