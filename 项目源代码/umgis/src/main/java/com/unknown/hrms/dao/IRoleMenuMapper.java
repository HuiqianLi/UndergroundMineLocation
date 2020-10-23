package com.unknown.hrms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.unknown.hrms.entity.RoleMenu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IRoleMenuMapper extends BaseMapper<RoleMenu> {
    void deleteRoleMenuByRoleId(Integer roleId);

    boolean authRoleMenu(@Param("roleId") Integer roleId, @Param("menuIdList") List<Integer> menuIdList);
}
