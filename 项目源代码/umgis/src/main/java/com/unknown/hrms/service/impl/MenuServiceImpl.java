package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IMenuMapper;
import com.unknown.hrms.entity.Menu;
import com.unknown.hrms.service.IMenuService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("MenuServiceImpl")
public class MenuServiceImpl extends ServiceImpl<IMenuMapper,Menu> implements IMenuService {
    @Override
    public List<Menu> getMenuListByParentId(Integer id) {

        return baseMapper.getMenuListByParentId(id);
    }

    @Override
    public List<Map<String, Object>> getAuthMenuZtreeListByRoleId(Integer roleId) {
        return baseMapper.getAuthMenuZtreeListByRoleId(roleId);
    }

    @Override
    public List<Menu> getMenuListByRoleId(Integer roleId) {
        return baseMapper.getMenuListByRoleId(roleId);
    }
}
