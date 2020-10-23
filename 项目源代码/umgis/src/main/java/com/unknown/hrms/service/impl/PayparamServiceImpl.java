package com.unknown.hrms.service.impl;


import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IPayparamMapper;
import com.unknown.hrms.entity.Payparam;
import com.unknown.hrms.service.IPayparamService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("PayparamServiceImpl")
public class PayparamServiceImpl extends ServiceImpl<IPayparamMapper, Payparam> implements IPayparamService {

    @Autowired
    private IPayparamMapper payparamMapper;

    @Transactional
    public void update(Payparam payparam){
        payparamMapper.update(payparam);
    }

    @Transactional
    public void add(Payparam payparam){
        payparamMapper.add(payparam);
    }


    @Transactional
    public void deleteById(int id){
        payparamMapper.deleteById(id);
    }
}
