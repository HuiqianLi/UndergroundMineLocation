package com.unknown.hrms.entity;


import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;
import lombok.Data;

@Data//lombok插件，可以在编译的时候帮我们生成getter and setter and toString方法
@TableName("t_attendance")
public class Attendance {

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUser_id() {
        return user_id;
    }

    public void setUser_id(Integer user_id) {
        this.user_id = user_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getUser_category() {
        return user_category;
    }

    public void setUser_category(String user_category) {
        this.user_category = user_category;
    }

    public String getUser_status() {
        return user_status;
    }

    public void setUser_status(String user_status) {
        this.user_status = user_status;
    }

    @TableId(type= IdType.AUTO)//自动增长
    private Integer id;

    private Integer user_id;

    private  String username;

    private String user_category;

    private  String user_status;

    private String create_time;
//    private DateTimeLiteralExpression.DateTime create_time;
//
//    private DateTimeLiteralExpression.DateTime update_time;

}
