package com.unknown.hrms.dao;


import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.unknown.hrms.entity.Menu;

import java.util.List;
import java.util.Map;


public interface IMenuMapper extends BaseMapper<Menu> {
    List<Menu> getMenuListByParentId(Integer id);

    List<Map<String, Object>> getAuthMenuZtreeListByRoleId(Integer roleId);

    List<Menu> getMenuListByRoleId(Integer roleId);
    //public Menu findById(int id);
}
