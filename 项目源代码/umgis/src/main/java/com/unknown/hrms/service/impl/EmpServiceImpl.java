package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IEmpMapper;
import com.unknown.hrms.entity.Emp;
import com.unknown.hrms.entity.chart;
import com.unknown.hrms.service.IEmpService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EmpServiceImpl extends ServiceImpl<IEmpMapper, Emp> implements IEmpService {
    @Autowired
    private IEmpMapper empMapper;



    @Override
    @Transactional
    public List<Emp> findByUserId(int id) {
        List<Emp> empList= empMapper.findByUserId(id);
        return empList;
    }

    @Override
    @Transactional
    public List<Emp> findOrgByUserId(Integer id) {
        List<Emp> empList= empMapper.findOrgByUserId(id);
        return empList;
    }

    @Override
    public List<Integer> getMaleData() {
        List<Integer> maleData = new ArrayList<Integer>();
        String[] org={"教务处","保卫科","后勤部","实训科","招就办","学生科","财务科"};
        for(int i=0;i<org.length;i++){
            EntityWrapper<Emp> entityWrapper = new EntityWrapper<Emp>();
            entityWrapper.eq("sex",1);
            entityWrapper.eq("orgname",org[i]);
            maleData.add(selectCount(entityWrapper));
        }
        return maleData;
    }

    @Override
    public List<Integer> getFemaleData() {
        List<Integer> femaleData = new ArrayList<Integer>();
        String[] org={"教务处","保卫科","后勤部","实训科","招就办","学生科","财务科"};
        for(int i=0;i<org.length;i++){
            EntityWrapper<Emp> entityWrapper = new EntityWrapper<Emp>();
            entityWrapper.eq("sex",0);
            entityWrapper.eq("orgname",org[i]);
            femaleData.add(selectCount(entityWrapper));
        }
        return femaleData;
    }

    @Override
    public List<chart> selectEduGroupBy() {
        DecimalFormat decimalFormat = new DecimalFormat("0.0");
        List<chart> charts = baseMapper.selectEduGroupBy();
        Integer res=0;
        for(chart chart:charts){
            res+=chart.getData();
        }
        for(int i=0;i<charts.size();i++){
            chart chart1 = charts.get(i);
            double j = (double)chart1.getData()/res*100;
            j=Double.parseDouble(decimalFormat.format(j));
            chart1.setProp(j);
            charts.set(i,chart1);
        }
        System.out.println(charts);
        return charts;
    }
}
