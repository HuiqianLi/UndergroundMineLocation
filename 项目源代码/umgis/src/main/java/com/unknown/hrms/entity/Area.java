package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;


@Data//lombok插件，可以在编译的时候帮我们生成getter and setter and toString方法
@TableName("area")

public class Area {
    @TableId(type= IdType.AUTO)//自动增长
    private Integer id;

    private String position1;
    private String position2;
    private String position3;
    private String area;

    private String createTime;

    private String note;

}
