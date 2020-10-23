package com.unknown.hrms.service;

import com.baomidou.mybatisplus.service.IService;
import com.unknown.hrms.entity.Insurance;

import java.util.List;
import java.util.Map;

public interface IInsuranceService extends IService<Insurance> {
    List<Map<String, Object>> exportInsu(Insurance insurance);

    void insertMaps(List<Map<String, Object>> maps);
}
