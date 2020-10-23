package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@TableName("t_org")
public class Org {
    @TableId(type=IdType.AUTO)
    private Integer id;

    private String name;

    private String parentName;

    private String information;

    private String address;

    private Integer number;

    private String manager;

    private String email;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date creatTime;
}
