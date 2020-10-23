
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
        <th width="25"><input type="checkbox" name="" value=""></th>
        <th width="150">id</th>
        <th width="150">用户名</th>
        <th width="90">手机号</th>
        <th width="40">性别</th>
        <th width="60">机构</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${empList}" var="emp">
        <tr class="text-c">
            <td><input class="checkedEmp" type="checkbox" value="${emp.id}" name=""></td>
            <td>${emp.id}</td>
            <td>${emp.username}</td>
            <td>${emp.mobile}</td>
            <td>${emp.sex ==1?"男":"女"}</td>
            <td>${emp.orgName}</td>
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

</script>
</body>
</html>
