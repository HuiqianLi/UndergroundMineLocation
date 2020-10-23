
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>员工列表</title>
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<table class="table table-border table-bordered table-bg">
    <thead>
    <tr class="text-c">
        <th width="150">id</th>
        <th width="150">用户名</th>
        <th width="90">手机号</th>
        <th width="40">性别</th>
        <th width="100">操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${empList}" var="emp">
        <tr class="text-c">
            <td>${emp.id}</td>
            <td>${emp.username}</td>
            <td>${emp.mobile}</td>
            <td>${emp.sex ==1?"男":"女"}</td>
            <td class="td-manage">
                <a title="删除" href="javascript:;" onclick="del_role_emp(${roleId},${emp.id})" class="ml-5" style="text-decoration:none">
                    <i class="Hui-iconfont">&#xe6e2;</i>
                </a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="../../../js/H-ui.js"></script>
<script type="text/javascript" src="../../../js/H-ui.admin.js"></script>
<script type="text/javascript" src="../../../js/oa_utils.js"></script>
<script type="text/javascript">
    function del_role_emp(rid,uid) {
        layer.confirm("确认要删除吗？",function (index) {
            $.get("authController/delRoleEmp/"+rid+"/"+uid,"",function (data) {
                if(data.state=="SUCCESS"){
                    layer.msg(data.message,{icon:1,time:1000},function(){
                        // 刷新table
                        $("#auth_table").load("authController/getEmpListByRoleId/" + roleId); //
                    })
                }else{
                    layer.msg(data.message,{icon:2,time:1000})
                }
            });
        });
    }
</script>
</body>
</html>
