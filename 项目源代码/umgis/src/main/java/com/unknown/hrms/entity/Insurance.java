package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
@TableName("t_insurance")
public class Insurance {

    @TableId(type= IdType.AUTO)
    private Integer id;

    private String empName;

    private double medicalInsu;

    private double socialInsu;

    private double accuFund;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date paymentDate;
}
