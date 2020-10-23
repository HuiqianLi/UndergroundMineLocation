package com.unknown.hrms.service;

import com.baomidou.mybatisplus.service.IService;
import com.github.pagehelper.PageInfo;
import com.unknown.hrms.entity.Attendance;

import java.util.List;

public interface IAttendanceService extends IService<Attendance> {

    //  public void update(Integer id);

    public List<Attendance> findByUserId(int id);

//  public Attendance findByUserId(int id);
}


