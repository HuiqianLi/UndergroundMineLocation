package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IRoleMenuMapper;
import com.unknown.hrms.entity.RoleMenu;
import com.unknown.hrms.service.IRoleMenuService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleMenuServiceImpl extends ServiceImpl<IRoleMenuMapper, RoleMenu> implements IRoleMenuService {
    @Override
    public void deleteRoleMenuByRoleId(Integer roleId) {
        baseMapper.deleteRoleMenuByRoleId(roleId);
    }

    @Override
    public boolean authRoleMenu(Integer roleId, List<Integer> menuIdList) {
        return baseMapper.authRoleMenu(roleId, menuIdList);
    }
}
