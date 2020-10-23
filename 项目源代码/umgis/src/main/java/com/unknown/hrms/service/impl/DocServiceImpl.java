package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IDocMapper;
import com.unknown.hrms.entity.Doc;
import com.unknown.hrms.service.IDocService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("DocServiceImpl")
public class DocServiceImpl extends ServiceImpl<IDocMapper,Doc> implements IDocService{
    @Override
    public Page<Doc> selectDocPage(Page<Doc> page) {

        int current = page.getCurrent();
        int size = page.getSize();

        //1.算总条数
        Integer total = super.baseMapper.selectCount(null);

        //2.查询当前页要显示的数据
        List<Doc> docs= baseMapper.selectDocPage( (current-1)*size,size);

        page.setTotal(total);//总条数
        page.setRecords(docs);//当前要展示的数据

        return page;
    }
}
