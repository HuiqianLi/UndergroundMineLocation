
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>菜单列表</title>
    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>

<body>
    <nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>系统管理 <span class="c-gray en">&gt;</span> 角色管理 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
    <div class="pd-20">
    <div class="cl pd-5 bg-1 bk-gray mt-20">
    <span class="l">

    <a href="javascript:;" onclick="batchDel()" class="btn btn-danger radius">
    <i class="Hui-iconfont">&#xe60b;</i> 批量删除
    </a>

    <a href="javascript:;" onclick="role_add('添加角色','toAddRole','400','400')" class="btn btn-primary radius">
    <i class="Hui-iconfont">&#xe600;</i> 添加角色
    </a>

    </span>
    </div>
    <table class="table table-border table-bordered table-bg">
    <thead>
    <tr>
    <th scope="col" colspan="11">角色列表</th>
    </tr>
    <tr class="text-c">
    <th width="25"><input type="checkbox" name="" value=""></th>
    <th width="40">ID</th>
    <th width="150">角色名称</th>
    <th width="90">角色描述</th>
    <th width="100">操作</th>
    </tr>
    </thead>
    <tbody>

    <c:forEach items="${roleList}" var="role">
        <tr class="text-c">
        <td><input class="batchDel" type="checkbox" value="${role.id}" name=""></td>
        <td>${role.id}</td>
        <td>${role.roleName}</td>
        <td>${role.roleDesc}</td>
        <td class="td-manage">

        <a title="编辑" href="javascript:;" onclick="role_edit('角色编辑','roleController/getRoleById/${role.id}','400','400')" class="ml-5" style="text-decoration:none">
        <i class="Hui-iconfont">&#xe6df;</i>
        </a>

        <a title="删除" href="javascript:;" onclick="deleteRole(${role.id})" class="ml-5" style="text-decoration:none">
        <i class="Hui-iconfont">&#xe6e2;</i>
        </a>

        </td>
        </tr>
    </c:forEach>
    </tbody>
    </table>

    </div>
    <script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>
    <script type="text/javascript" src="../../../lib/laypage/1.2/laypage.js"></script>
    <script type="text/javascript" src="../../../lib/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../../js/H-ui.js"></script>
    <script type="text/javascript" src="../../../js/H-ui.admin.js"></script>
    <script type="text/javascript" src="../../../js/oa_utils.js"></script>
    <script type="text/javascript">
    /*
    参数解释：
    title	标题
    url		请求的url
    id		需要操作的数据id
    w		弹出层宽度（缺省调默认值）
    h		弹出层高度（缺省调默认值）
    */
    /*管理员-增加*/
    function role_add(title,url,w,h){
    layer_show(title,url,w,h);
    }

    /*管理员-编辑*/
    function role_edit(title,url,w,h){
    layer_show(title,url,w,h);
    }

    function batchDel() {
        layer.confirm("确定要删除吗",function (index) {
            //h获取用户勾选的数据
            var array = $(".batchDel:checked");
            //创建一个数组
            var idArray = new Array();
            //循环遍历
            for(var i=0;i<array.length;i++){
                idArray.push(array[i].value);
            }
            var param = new Object();
            param.ids = idArray;
            //发送请求
            $.post("roleController/batchDelRole",param,function(data){
                reminderMsg(data);
            });
        });
    }

    function deleteRole(rid) {
        layer.confirm("你确定要删除吗？",function (index) {
            $.get("roleController/delRole/"+rid,"",function (data) {
                reminderMsg(data);
            });
        });
    }
    </script>
</body>
</html>
