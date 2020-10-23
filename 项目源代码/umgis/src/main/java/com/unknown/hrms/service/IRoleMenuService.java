package com.unknown.hrms.service;

import com.baomidou.mybatisplus.service.IService;
import com.unknown.hrms.entity.RoleMenu;

import java.util.List;

public interface IRoleMenuService extends IService<RoleMenu> {
    /**
     * 根据角色ID删除当前角色的菜单权限
     * @param roleId
     */
    void deleteRoleMenuByRoleId(Integer roleId);

    /**
     * 给角色赋予菜单权限
     * @param roleId
     * @param menuIdList
     * @return
     */
    boolean authRoleMenu(Integer roleId, List<Integer> menuIdList);
}
