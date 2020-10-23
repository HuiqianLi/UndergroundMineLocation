package com.unknown.hrms.service;


import com.baomidou.mybatisplus.service.IService;
import com.unknown.hrms.entity.Menu;

import java.util.List;
import java.util.Map;

public interface IMenuService extends IService<Menu> {
    List<Menu> getMenuListByParentId(Integer id);

    List<Map<String, Object>> getAuthMenuZtreeListByRoleId(Integer roleId);

    List<Menu> getMenuListByRoleId(Integer roleId);
}
