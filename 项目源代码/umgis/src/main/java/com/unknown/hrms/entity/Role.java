package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

@Data
@TableName("t_role")
public class Role {

    @TableId(type = IdType.AUTO)
    private Integer id;

    private String roleName;

    private String roleDesc;

    private Integer roleState;
}
