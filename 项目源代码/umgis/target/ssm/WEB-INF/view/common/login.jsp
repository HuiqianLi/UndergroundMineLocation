<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    pageContext.setAttribute("basePath",basePath);
%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/H-ui.login.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>
<body>
<input type="hidden" id="TenantId" name="TenantId" value="" />
<div class="loginWraper">
    <div  class="loginBox">
        <form class="form form-horizontal"  id="login-form" <%--action = "${basePath}userController/login"--%> method="post">
            <div class="row cl">
                <label class="form-label col-3"><i class="Hui-iconfont">&#xe60d;</i></label>
                <div class="formControls col-8">
                    <input  value="admin" name="username" type="text" autocomplete="off" datatype="*" nullmsg="用户名不能为空" placeholder="账户" class="input-text size-L">
                </div>
                <%--<div class=" col-4"></div>--%>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><i class="Hui-iconfont">&#xe60e;</i></label>
                <div class="formControls col-8">
                    <input value="admin" name="password" type="password" autocomplete="off" datatype="*" nullmsg="密码不能为空" placeholder="密码" class="input-text size-L">
                </div>
                <%--<div class=" col-4"></div>--%>
            </div>
            <%--<div class="row cl">
                <div class="formControls col-8 col-offset-3">
                    <input class="input-text size-L" type="text" placeholder="验证码" onblur="if(this.value==''){this.value='验证码:'}" onclick="if(this.value=='验证码:'){this.value='';}" value="验证码:" style="width:150px;">
                    <img src="images/VerifyCode.aspx.png"> <a id="kanbuq" href="javascript:;">看不清，换一张</a> </div>
            </div>--%>
            <div class="row">
                <div class="formControls col-8 col-offset-7">
                    <label >没有账号？点我注册</label>
                </div>
            </div>
            <div class="row">
                <div class="formControls col-8 col-offset-3">
                    <input type="submit" class="btn btn-success radius size-L" value="&nbsp;登&nbsp;&nbsp;&nbsp;&nbsp;录&nbsp;">
                    <input type="reset" class="btn btn-default radius size-L" value="&nbsp;取&nbsp;&nbsp;&nbsp;&nbsp;消&nbsp;">
                </div>
            </div>
        </form>
    </div>
</div>
<div class="footer">Copyright 地下矿井信息管理系统 </div>
<script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../../../js/H-ui.js"></script>
<script type="text/javascript" src="../../../lib/Validform/5.3.2/Validform.js"></script>
<script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="../../../js/oa_utils.js"></script>


<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?080836300300be57b7f34f4b3e97d911";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();
    var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F080836300300be57b7f34f4b3e97d911' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
    $(function () {
        //初始化表单验证
        $("#login-form").Validform({
            tiptype: 2,
            callback:function(form){//表单全部验证通过后会调用这个函数
                var param = formToObject(form);
                $.post("userController/login",param,function(data){
                    if(data.state=="SUCCESS"){
                        layer.msg(data.message,{icon:1,time:1000},function(){
                            // 刷新一下
                            location.href = "toBackHome";
                        })
                    }else{
                        layer.msg(data.message,{icon:2,time:1000})
                    }
                });
                return false;//不提交表单，通过异步的方式吧表单的数据发送到服务端
            }
        });
    });
</script>
</body>
</html>
