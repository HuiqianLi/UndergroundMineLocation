<%--
  Created by IntelliJ IDEA.
  User: dashixin
  Date: 2020/5/21
  Time: 16:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>Title</title>
    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/webuploader/0.1.5/webuploader.css" rel="stylesheet" type="text/css" />
</head>
<div class="pd-20">
    <form action="abc" method="post" class="form form-horizontal" id="form-admin-add">
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>姓名：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="username" name="username" datatype="*2-16" nullmsg="用户名不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>密码：</label>
            <div class="formControls col-5">
                <input type="password" placeholder="密码" name="passsword" autocomplete="off" value="" class="input-text" datatype="*6-20" nullmsg="密码不能为空">
            </div>
            <div class="col-4"> </div>
        </div>

        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>确认密码：</label>
            <div class="formControls col-5">
                <input type="password" placeholder="密码" name="repassword" recheck="passsword" autocomplete="off" value="" class="input-text" datatype="*6-20" nullmsg="密码不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>性别：</label>
            <div class="formControls col-5 skin-minimal">
                <div class="radio-box">
                    <input type="radio" value="1" id="sex-1" name="sex" datatype="*" nullmsg="请选择性别！">
                    <label for="sex-1">男</label>
                </div>
                <div class="radio-box">
                    <input type="radio" value="0" id="sex-0" name="sex">
                    <label for="sex-0">女</label>
                </div>
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>所在机构：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="orgname" name="orgname"  datatype="s" nullmsg="机构不能为空">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>手机：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="" placeholder="" id="user-tel" name="mobile"  datatype="m" nullmsg="手机不能为空">
            </div>
            <div class="col-4"> </div>
        </div>

        <%--  <div class="row cl">
              <label class="form-label col-3"><span class="c-red">*</span>排序的索引：</label>
              <div class="formControls col-5">
                  <input type="text" class="input-text" value="1" placeholder="" name="orderbyIndex"  datatype="n">
              </div>
              <div class="col-4"> </div>
          </div>--%>

        <%-- <div class="row cl">
             <label class="form-label col-3"><span class="c-red">*</span>部门：</label>
             <div class="formControls col-5">
                 <input type="text" class="input-text" value="10" placeholder="" id="deptno" name="deptno"  datatype="n">
             </div>
             <div class="col-4"> </div>
         </div>--%>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>邮箱：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" placeholder="@" value="admin@qf.com" name="email" id="email" datatype="e" nullmsg="请输入邮箱！">
            </div>
            <div class="col-4"> </div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>生日：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text Wdate" onclick="WdatePicker({readOnly:true,lang:'zh-cn'})"  placeholder="" id="birthday" name="birthday"  datatype="*" nullmsg="生日不能为空">
            </div>
            <div class="col-4"> </div>
        </div>

        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>学历：</label>
            <div class="formControls col-4 skin-minimal">
                <div class="radio-box">
                    <input type="radio" value="本科" id="education-0" name="education" datatype="*" nullmsg="请选择学历！">
                    <label for="education-0">本科</label>
                </div>
                <div class="radio-box">
                    <input type="radio" value="硕士" id="education-1" name="education">
                    <label for="education-1">硕士</label>
                </div>
                <div class="radio-box">
                    <input type="radio" value="博士" id="education-2" name="education">
                    <label for="education-2">博士</label>
                </div>
                <div class="radio-box">
                    <input type="radio" value="博士" id="education-3" name="education">
                    <label for="education-3">博士后</label>
                </div>
            </div>
            <div class="row cl">
                <label class="form-label col-3"><span class="c-red">*</span>创建时间：</label>
                <div class="formControls col-5">
                    <input type="text" class="input-text Wdate" onclick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  placeholder="" id="update_time" name="updateTime"  datatype="*" nullmsg="不能为空">
                </div>
                <div class="col-4"> </div>
            </div>

            <%--
                    <div class="row cl">
                        <label class="form-label col-3">头像：</label>

                        <div class="formControls col-5">
                            <input type="hidden" name="userPng" id="userPng">
                            <div id="uploader" class="wu-example">
                                <div id="uploader-demo">
                                    <!--用来存放item-->
                                    <div id="fileList" class="uploader-list">

                                    </div>
                                    <div id="filePicker">选择图片</div>
                                </div>
                            </div>
                        </div>
                    </div>
            --%>

            <div class="row cl">
                <div class="col-9 col-offset-3">
                    <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
                </div>
            </div>
    </form>
</div>
<script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../../../lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="../../../lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="../../../js/H-ui.js"></script>
<script type="text/javascript" src="../../../js/H-ui.admin.js"></script>
<script type="text/javascript" src="../../../lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="../../../lib/webuploader/0.1.5/webuploader.js"></script>
<script type="text/javascript" src="../../../js/oa_utils.js"></script>
<script type="text/javascript">
    $(function(){

        // 初始化表单验证
        // 初始化表单验证
        $("#form-admin-add").Validform({
            tiptype:2,
            callback:function(form){ // 表单全部验证通过后会调用这个函数
                submit("empController/addEmp",form);
                return false; // return false表示表单不会提交
            }
        });
    });


</script>
</body>
</html>
