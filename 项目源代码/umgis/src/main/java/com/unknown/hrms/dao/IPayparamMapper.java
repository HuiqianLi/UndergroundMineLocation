package com.unknown.hrms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.unknown.hrms.entity.Payparam;

public interface IPayparamMapper extends BaseMapper<Payparam> {

    public void update(Payparam payparam);

    public void add(Payparam payparam);
}
