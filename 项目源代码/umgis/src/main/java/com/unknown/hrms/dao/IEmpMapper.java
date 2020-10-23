package com.unknown.hrms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.unknown.hrms.entity.Emp;
import com.unknown.hrms.entity.chart;

import java.util.List;

public interface IEmpMapper extends BaseMapper<Emp> {
    public List<Emp> findByUserId(int id);
    public List<Emp> findOrgByUserId(int id);

    List<chart> selectEduGroupBy();
}
