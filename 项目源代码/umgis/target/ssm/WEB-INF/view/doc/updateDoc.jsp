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
    <title>修改文档</title>
    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-doc-add">
        <div class="row cl">
            <label class="form-label col-2" ><span class="c-red">*</span>文章标题：</label>
            <div class="formControls col-10">
                <input type="text" class="input-text" value="${doc.title}" placeholder="" id="title" name="title" datatype="*" nullmsg="标题不能为空">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-2" ><span class="c-red">*</span>文章id：</label>
            <div class="formControls col-10">
                <input type="text" class="input-text" readonly="readonly" value="${doc.id}" placeholder="" id="id" name="id" >
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-2" ><span class="c-red">*</span>文章类型：</label>
            <div class="formControls col-10">
                <input type="text" class="input-text" value="${doc.type}" placeholder="" id="type" name="type" datatype="*" nullmsg="类型不能为空">
            </div>
        </div>

        <div class="row cl">
            <label class="form-label col-2"><span class="c-red">*</span>文章内容：</label>
            <div class="formControls col-10">
                <textarea id="content" name="content"  cols="" rows="" style="height:250px" class="textarea"  placeholder="说点什么...最少输入10个字符" datatype="*10-2000" dragonfly="true" nullmsg="内容不能为空！" onKeyUp="textarealength(this,2000)">${doc.content}</textarea>
                <p class="textarea-numberbar"><em class="textarea-length">0</em>/2000</p>
            </div>
        </div>
        <%--       <div class="row cl">
                   <label class="form-label col-2">文章作者：</label>
                   <div class="formControls col-2">
                       <input type="text" class="input-text" value="0" placeholder="" id="" name="">
                   </div>

               </div>--%>


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
                submit("../updateDoc",form);
                return false;
            }
        });
    });


</script>
</body>
</html>
