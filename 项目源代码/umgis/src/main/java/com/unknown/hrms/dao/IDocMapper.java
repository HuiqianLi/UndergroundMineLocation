package com.unknown.hrms.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.unknown.hrms.entity.Doc;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IDocMapper extends BaseMapper<Doc>{
    List<Doc> selectDocPage(@Param("index") Integer index, @Param("size") Integer size); //这个sql自己实现
}
