package com.unknown.hrms.utils;

public class ResponseUtils {

    public static ResultEntity responseClinet(Boolean flag){
        if(flag){
            return  ResultEntity.success();
        }else{
            return  ResultEntity.faild();
        }
    }
}
