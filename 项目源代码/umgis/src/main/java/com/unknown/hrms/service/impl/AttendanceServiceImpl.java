package com.unknown.hrms.service.impl;


import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.unknown.hrms.dao.IAttendanceMapper;
import com.unknown.hrms.entity.Attendance;
import com.unknown.hrms.service.IAttendanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service("AttendanceServiceImpl")
public class AttendanceServiceImpl extends ServiceImpl<IAttendanceMapper, Attendance> implements IAttendanceService {

    @Autowired
    private IAttendanceMapper attendanceMapper;

    //    @Transactional
//    public void update(Integer id){
//        attendanceMapper.update(id);
//    }


    @Transactional
    public List<Attendance> findByUserId(int id) {
        List<Attendance> attendanceList= attendanceMapper.findByUserId(id);
        return attendanceList;
    }

//    @Transactional
//    public Attendance findByUserId(int id) {
//        Attendance attendanceList= attendanceMapper.findByUserId(id);
//        return attendanceList;
//    }
}
