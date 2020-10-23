package com.unknown.hrms.service;

import com.baomidou.mybatisplus.service.IService;
import com.unknown.hrms.entity.Emp;
import com.unknown.hrms.entity.chart;

import java.util.List;
import java.util.Map;

public interface IEmpService extends IService<Emp> {
    public List<Emp> findByUserId(int id);
    public List<Emp> findOrgByUserId(Integer user_id);

    List<Integer> getMaleData();

    List<Integer> getFemaleData();

    List<chart> selectEduGroupBy();
}
