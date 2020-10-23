package com.unknown.hrms.service;

import com.baomidou.mybatisplus.service.IService;
import com.unknown.hrms.entity.Payparam;

public interface IPayparamService extends IService<Payparam> {

    public void update(Payparam payparam);

    public void add(Payparam payparam);

    public void deleteById(int id);
}
