package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@TableName("t_emp")
public class Emp {
    @TableId(type= IdType.AUTO)
    private Integer id;

    private String username;

    private String password;

    private Integer sex;

    private String mobile;

    private Integer orgno;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date birthday;

    private String email;

    private Integer attenceno;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updateTime;

    private String education;

    private String orgname;

    @TableField(exist = false)
    private String orgName2;

    //新增
    private String techgrade;

    private String post;

    private String title;

    private String duty;
}
