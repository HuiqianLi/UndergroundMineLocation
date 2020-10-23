package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

@Data
@TableName("t_role_menu")
public class RoleMenu {
    @TableId(type= IdType.AUTO)
    private Integer id;

    private Integer rid;

    private Integer mid;
}
