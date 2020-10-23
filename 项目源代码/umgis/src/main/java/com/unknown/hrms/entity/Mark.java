package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;


@Data//lombok插件，可以在编译的时候帮我们生成getter and setter and toString方法
@TableName("mark")

public class Mark {
    @TableId(type= IdType.AUTO)//自动增长
    private Integer id;

    private String name;
    private String point;
    private String note;

    private String createTime;

}
