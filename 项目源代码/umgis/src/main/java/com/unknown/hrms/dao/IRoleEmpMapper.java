package com.unknown.hrms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.unknown.hrms.entity.RoleEmp;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IRoleEmpMapper extends BaseMapper<RoleEmp> {
    public Boolean authUserRole(@Param("roleId") Integer roleId, @Param("empIdList") List<Integer> empIdList);
}
