package com.unknown.hrms.entity;


import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

@Data
@TableName("t_dept")
public class Dept {

    @TableId(type= IdType.AUTO)
    private Integer id;

    //private Integer userId;

    private String name;

    private String ddesc;

    private String orgname;
}
