package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

@Data
@TableName("t_staff")
public class Staff {

    @TableId(type= IdType.AUTO)
    private Integer id;

    private String staffname;

    private Integer number;

    private  String duty;

    private String deptname;

    private String orgname;
}