package com.unknown.hrms.service;


import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.IService;
import com.unknown.hrms.entity.Doc;

public interface IDocService extends IService<Doc>{
    Page<Doc> selectDocPage(Page<Doc> page);
}
