package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;


@Data//lombok插件，可以在编译的时候帮我们生成getter and setter and toString方法
@TableName("t_doc")
public class Doc {

    @TableId(type= IdType.AUTO)//自动增长
    private Integer id;

    private String title;

    private String content;

    private String type;//文档的类型(1:规章制度，2：通知公告，3：娱乐新闻）

    private String operator;

    private String pubTime;

    private String modTime;

    @TableField(exist=false)
    private String username;

}
