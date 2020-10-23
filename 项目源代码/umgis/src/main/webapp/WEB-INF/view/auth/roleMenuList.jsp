
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/style.css" rel="stylesheet" type="text/css" />
</head>

<body>
<table class="table table-border table-bordered table-bg">
    <thead>
    <tr class="text-c">
        <th width="150">菜单名称</th>
        <th width="150">菜单类型</th>
        <th width="100">操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${menuList}" var="menu">
        <tr class="text-c">
            <td>${menu.name}</td>
            <td>
                <c:if test="${menu.type==1}">菜单</c:if>
                <c:if test="${menu.type==2}">目录</c:if>
                <c:if test="${menu.type==3}">按钮</c:if>
            </td>
            <td class="td-manage">
                <a title="删除" href="javascript:;" onclick="del_role_menu(${roleId},${menu.id})" class="ml-5" style="text-decoration:none">
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
    function del_role_menu(rid,mid) {
        layer.confirm("确认要删除吗？",function (index) {
            $.get("authController/delRoleMenu/"+rid+"/"+mid,"",function (data) {
                if(data.state=="SUCCESS"){
                    layer.msg(data.message,{icon:1,time:1000},function(){
                        // 刷新table
                        $("#auth_table").load("authController/getMenuListByRoleId/" + roleId);
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
