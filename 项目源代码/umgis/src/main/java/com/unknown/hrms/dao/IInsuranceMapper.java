package com.unknown.hrms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.unknown.hrms.entity.Insurance;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface IInsuranceMapper extends BaseMapper<Insurance> {
    List<Map<String, Object>> exportInsu(Insurance insurance);

    void insertMaps(@Param("maps") List<Map<String, Object>> maps);
}
