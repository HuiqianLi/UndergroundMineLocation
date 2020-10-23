<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>Title</title>
    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-role-add">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>角色名字：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" placeholder="" id="roleName" name="roleName" datatype="*2-16" nullmsg="角色名称不能为空">
            </div>
            <div class="col-4"> </div>
        </div>

        <div class="row cl">
            <label class="form-label col-3">角色描述：</label>
            <div class="formControls col-5">
                <textarea  name="roleDesc" rows="5" cols="40"></textarea>
            </div>
            <div class="col-4"> </div>
        </div>

        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../../../lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="../../../js/H-ui.js"></script>
<script type="text/javascript" src="../../../js/H-ui.admin.js"></script>
<script type="text/javascript" src="../../../js/oa_utils.js"></script>
<!-- 1.一如JquerySession插件-->
<script type="text/javascript" src="../../../js/jquerysession.js"></script>
<script type="text/javascript">
    $(function(){

        // 初始化表单验证
        $("#form-role-add").Validform({
            tiptype:2,
            callback:function(form){ // 表单全部验证通过后会调用这个函数
                submit("roleController/addRole",form);
                return false;
            }
        });
    });

</script>
</body>
</html>
