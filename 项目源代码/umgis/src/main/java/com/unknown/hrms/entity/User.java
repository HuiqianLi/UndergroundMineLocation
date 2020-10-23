package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;
/**
 * 处理用户登录，权限控制
 */
import java.util.Set;

@Data
@TableName("t_emp")
public class User {

    @TableId(type= IdType.AUTO)
    private Integer id;

    private String username;

    private String password;

    @TableField(exist = false)
    private Set<String> permissionSet;//用户的权限码

}
