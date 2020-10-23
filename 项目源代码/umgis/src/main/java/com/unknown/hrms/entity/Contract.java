package com.unknown.hrms.entity;


import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@TableName("t_contract")
public class Contract {
    @TableId(type = IdType.AUTO)
    private Integer id;

    private String emp_name;

    private String emp_unit;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date emp_beginyear;

    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date emp_endyear;

    private String emp_post;

    private String emp_title;

    private String emp_duty;

    private String emp_pay;
}
