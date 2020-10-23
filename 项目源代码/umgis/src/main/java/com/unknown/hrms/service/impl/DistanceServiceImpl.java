package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IDistanceMapper;
import com.unknown.hrms.entity.Distance;
import com.unknown.hrms.service.IDistanceService;
import org.springframework.stereotype.Service;

@Service("DistanceServiceImpl")
public class DistanceServiceImpl extends ServiceImpl<IDistanceMapper,Distance> implements IDistanceService {
}
