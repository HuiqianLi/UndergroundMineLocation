package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IInsuranceMapper;
import com.unknown.hrms.entity.Insurance;
import com.unknown.hrms.service.IInsuranceService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class InsuranceServiceImpl extends ServiceImpl<IInsuranceMapper, Insurance> implements IInsuranceService {
    @Override
    public List<Map<String, Object>> exportInsu(Insurance insurance) {
        return baseMapper.exportInsu(insurance);
    }

    @Override
    public void insertMaps(List<Map<String, Object>> maps) {
        baseMapper.insertMaps(maps);
    }
}
