package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IAreaMapper;
import com.unknown.hrms.entity.Area;
import com.unknown.hrms.service.IAreaService;
import org.springframework.stereotype.Service;

@Service("AreaServiceImpl")
public class AreaServiceImpl extends ServiceImpl<IAreaMapper,Area> implements IAreaService {
}
