
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>员工列表</title>
    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>

<body>
<div class="pd-20">
    <form method="post" action="authController/getAllEmp">
        <div class="text-c">
            <div class="row cl ">
                <div class="formControls col-3">
                    <input type="hidden" name="roleId" value="${roleId}">
                    登录名: <input type="text"  value="${name}" name="name" class="input-text" style="width: 250px">
                </div>
            </div>
            <div class="row cl">
                <div class="cl pd-5">
                    <button type="submit"
                            class="btn btn-success radius" id="" name="">
                        <i class="Hui-iconfont">&#xe665;</i> 搜用户
                    </button>
                </div>
            </div>
        </div>
    </form>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">

                <a href="javascript:;" onclick="auth_user_role()" class="btn btn-primary radius">
                    <i class="Hui-iconfont">&#xe600;</i> 批量授权
                </a>

            </span>
    </div>
    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr class="text-c">
            <th width="25"><input type="checkbox" name="" value=""></th>
            <th width="150">id</th>
            <th width="150">用户名</th>
            <th width="90">手机号</th>
            <th width="40">性别</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${empList}" var="emp">
            <tr class="text-c">
                <td><input class="empId" type="checkbox" value="${emp.id}" name=""></td>
                <td>${emp.id}</td>
                <td>${emp.username}</td>
                <td>${emp.mobile}</td>
                <td>${emp.sex ==1?"男":"女"}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="../../../js/H-ui.js"></script>
<script type="text/javascript" src="../../../js/H-ui.admin.js"></script>
<script type="text/javascript" src="../../../js/oa_utils.js"></script>
<script type="text/javascript">

    function auth_user_role() {

        // 1.获取用户选择的角色
        var roleId = "${roleId}";

        // 2.获取用户勾选的员工
        var eleArray = $(".empId:checked");
        // 3.创建一个数组
        var empIdArray = new Array();

        // 4.循环遍历，把勾选员工id放入到数组中
        for(var i =0;i<eleArray.length;i++){
            empIdArray.push(eleArray[i].value);
        }

        // 5.把角色Id和员工数组封装到一个对象中
        var param = new Object();
        param.roleId =roleId;
        param.empIdArray = empIdArray;

        // 6.异步发送请求调用Controller入库
        $.post("authController/authUserRole",param,function(data){
            responseClient(data);
        });

    }
</script>
</body>
</html>
