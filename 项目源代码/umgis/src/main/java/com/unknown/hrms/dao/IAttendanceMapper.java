package com.unknown.hrms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.unknown.hrms.entity.Attendance;

import java.util.List;

public interface IAttendanceMapper extends BaseMapper<Attendance> {

    //    public void update(Integer id);

    public List<Attendance> findByUserId(int id);

    //   public Attendance findByUserId(int id);
}
