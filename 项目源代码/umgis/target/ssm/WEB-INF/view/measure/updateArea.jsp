<%--
  Created by IntelliJ IDEA.
  User: Qinci
  Date: 2020/6/24
  Time: 2:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>修改测量面积项</title>
    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-doc-add">

        <div class="row cl">
            <label class="form-label col-2" ><span class="c-red">*</span>编号：</label>
            <div class="formControls col-10">
                <input type="text" class="input-text" readonly="readonly" value="${area.id}" placeholder="" id="id" name="id" >
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-2" ><span class="c-red">*</span>位置1：</label>
            <div class="formControls col-10">
                <input type="text" class="input-text" value="${area.position1}" placeholder="" id="position1" name="position1" datatype="*" nullmsg="标姓名能为空">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-2" ><span class="c-red">*</span>位置2：</label>
            <div class="formControls col-10">
                <input type="text" class="input-text" value="${area.position2}" placeholder="" id="position2" name="position2" datatype="*" nullmsg="职位不能为空">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-2" ><span class="c-red">*</span>位置3：</label>
            <div class="formControls col-10">
                <input type="text" class="input-text" value="${area.position3}" placeholder="" id="position3" name="position3" datatype="*" nullmsg="职位不能为空">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-2" ><span class="c-red">*</span>面积：</label>
            <div class="formControls col-10">
                <input type="text" class="input-text" value="${area.area}" placeholder="" id="distance" name="distance" datatype="*">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-2" ><span class="c-red">*</span>备注：</label>
            <div class="formControls col-10">
                <input type="text" class="input-text" value="${area.note}" placeholder="" id="note" name="note" datatype="*">
            </div>
        </div>



        <div class="row cl">
            <div class="col-10 col-offset-2">
                <button class="btn btn-primary radius" type="submit"><i class="Hui-iconfont">&#xe632;</i> 保存</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="../../../lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="../../../lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="../../../lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="../../../lib/webuploader/0.1.5/webuploader.min.js"></script>
<script type="text/javascript" src="../../../lib/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" src="../../../lib/ueditor/1.4.3/ueditor.all.min.js"> </script>
<script type="text/javascript" src="../../../lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
<script type="text/javascript" src="../../../js/H-ui.js"></script>
<script type="text/javascript" src="../../../js/H-ui.admin.js"></script>
<script type="text/javascript" src="../../../js/oa_utils.js"></script>
<script type="text/javascript">

    $(function(){

        $("#form-doc-add").Validform({
            tiptype:2,
            callback:function(form){
                submit("../updateArea",form);
                return false;
            }
        });
    });


</script>
</body>
</html>
