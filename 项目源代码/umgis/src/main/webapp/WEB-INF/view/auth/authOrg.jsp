<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/6/23
  Time: 16:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>机构授权</title>
    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="../../../css/style.css" rel="stylesheet" type="text/css"/>
    <link href="../../../lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="pd-20">
    <div class="text-c">
        <div class="row cl ">
            <div class="formControls col-3">
                角色:
                <span class="select-box" style="width:150px;">
				<select class="select" name="role" id="role" size="1">
                    	<option value="">==请选择==</option>
                     <c:forEach items="${roleList}" var="role">
                         <option value="${role.id}">${role.roleName}</option>
                     </c:forEach>
				</select>
			</span>

            </div>
            <div class="formControls col-4">
                机构：
                <span class="select-box" style="width:150px;">
				<select class="select" id="org" size="1">
					<option value="">==请选择==</option>
					<c:forEach items="${orgList}" var="org">
                        <option value="${org.id}">${org.name}</option>
                    </c:forEach>
				</select>
				</span>
            </div>
        </div>
        <div class="row cl">
            <div class="cl pd-5">
                <button type="button"
                        class="btn btn-success radius" onclick="org_emp_search()">
                    <i class="Hui-iconfont">&#xe665;</i> 搜索
                </button>
            </div>
        </div>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">

                <a href="javascript:;" onclick="auth_org()" class="btn btn-primary radius">
                    <i class="Hui-iconfont">&#xe600;</i> 确定
                </a>

            </span>
    </div>
    <table class="table table-border table-bordered table-bg" id="auth_table">
    </table>

</div>
<script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="../../../js/H-ui.js"></script>
<script type="text/javascript" src="../../../js/H-ui.admin.js"></script>
<script type="text/javascript" src="../../../js/oa_utils.js"></script>
<script type="text/javascript">

    var roleId;

    // 判断是否选择用户
    function isSelectRole() {
        // 1.先获取用户选择呢的角色
        roleId = $("#role").val();

        // 2.非空判断
        if (!roleId) {
            layer.msg("请先选择角色", {time: 1000, icon: 3});
            return false;
        }
        return true;
    }

    //判断是否选择机构
    function isSelectOrg() {
        orgId = $("#org").val();
        if(!orgId){
            layer.msg("请选择机构",{time:1000,icon:3});
            return false;
        }
        return true;
    }

    function org_emp_search() {
        if(!isSelectRole()){
            return false;
        }
        $("#auth_table").load("authController/getEmpList/" + roleId); //

    }
    function auth_org() {
        if(!isSelectRole()){
            return false;
        }
        if(!isSelectOrg()){
            return false;
        }
        debugger;
        //h获取用户勾选的数据
        var array = $(".checkedEmp:checked");
        //创建一个数组
        var idArray = new Array();
        //循环遍历
        for(var i=0;i<array.length;i++){
            idArray.push(array[i].value);
        }
        var param = new Object();
        param.ids = idArray;
        param.orgId = orgId;
        //发送请求
        $.post("authController/updateEmpOrg",param,function(data){
            if(data.state=="SUCCESS"){
                layer.msg(data.message,{icon:1,time:1000},function(){
                    // 刷新table
                    $("#auth_table").load("authController/getEmpList/" + roleId); //
                })
            }else{
                layer.msg(data.message,{icon:2,time:1000})
            }
        });

    }
</script>
</body>
</html>
