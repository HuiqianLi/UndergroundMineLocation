
function submit(url,form){

    // 1.获取表单数据并且封装成一个对象
    var param  = formToObject(form);

    // 2.异步发送请求到服务端
    sendUrl(url,param);

}

// 发送请求
function sendUrl(url,param){
    $.post(url,param,function(data){
        responseClient(data);
    });
}

// 响应用户
function responseClient(data){
    if(data.state=="SUCCESS"){
        layer.msg(data.message,{icon:1,time:1000},function(){
            // 获取弹出框的索引
            var index = parent.layer.getFrameIndex(window.name);

            // 关闭
            parent.layer.close(index);
        })
    }else{
        layer.msg(data.message,{icon:2,time:1000})
    }
}

// 提示信息，刷新
function reminderMsg(data){
    if(data.state=="SUCCESS"){
        layer.msg(data.message,{icon:1,time:1000},function(){
            // 刷新一下
            location.reload();
        })
    }else{
        layer.msg(data.message,{icon:2,time:1000})
    }
}

// 封装表单数据
function formToObject(form){

    // 1.获取表单数据
    var formArray =form.serializeArray(); // 把表单转成一个对象数组

    // 2.把表单数据封装到对象里面
    var param = new Object();

    // 3.把数组中的数据封装到param对象中
    for(var i =0;i<formArray.length;i++){
        var name = formArray[i].name; // 表单属性名称
        var value= formArray[i].value; // 表单属性值
        param[name]=value;
    }

    // 4.返回参数对象
    return param;
}