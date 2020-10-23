package com.unknown.hrms.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.unknown.hrms.dao.IMarkMapper;
import com.unknown.hrms.entity.Mark;
import com.unknown.hrms.service.IMarkService;
import org.springframework.stereotype.Service;

@Service("MarkServiceImpl")
public class MarkServiceImpl extends ServiceImpl<IMarkMapper,Mark> implements IMarkService {
}
