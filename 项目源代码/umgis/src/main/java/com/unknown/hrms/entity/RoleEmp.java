package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

@Data
@TableName("t_role_emp")
public class RoleEmp {

    @TableId(type= IdType.AUTO)
    private Integer id;

    private Integer uid;

    private Integer rid;
}
