package com.unknown.hrms.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

@Data//lombok插件，可以在编译的时候帮我们生成getter and setter and toString方法
@TableName("t_menu")
public class Menu {

    @TableId(type= IdType.AUTO)//自动增长
    private Integer id;

    private String name;

    private String url;

    private Integer type;//菜单的类型(1:菜单，2：目录，3：按钮）

    private String ddesc;

    @TableField(value = "p_code")
    private String pCode;//权限码,如果属性和表字段不一致，需要通过TableField建立映射关系

    @TableField(exist = false)//表中不存在parentMenu
    private Menu parentMenu;//父菜单

    private Integer parentMenuId;//父菜单的id

    @TableField(exist = false )
    private Integer subMenuId;

}
