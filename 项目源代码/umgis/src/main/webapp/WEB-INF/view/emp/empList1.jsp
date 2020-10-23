<%--
  Created by IntelliJ IDEA.
  User: dashixin
  Date: 2020/5/21
  Time: 14:49
  To change this template use File | Settings | File Templates.
--%>
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
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">></span> 员工信息管理 <span class="c-gray en">&gt;</span> 管理员列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
    <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">
                <a href="javascript:;" onclick="batchDel()" class="btn btn-danger radius">
                    <i class="Hui-iconfont">&#xe60b;</i> 批量删除
                </a>
                <a href="javascript:;" onclick="emp_add('添加员工','toAddEmp','800','500')" class="btn btn-primary radius">
                    <i class="Hui-iconfont">&#xe600;</i> 添加员工信息
                </a>
            </span>
    </div>
    <div class="mt-20">
        <table class="table table-border table-bordered table-hover table-bg table-sort">
            <thead>
            <tr class="text-c">
                <th width="25"><input type="checkbox" name="" value=""></th>
                <th width="40">ID</th>
                <th width="150">用户名</th>
                <th width="90">手机号</th>
                <th width="150">邮箱</th>
                <%--<th width="150">头像</th>--%>
                <th width="40">性别</th>
                <th width="40">学历</th>
                <th width="100">所在机构</th>
                <th width="130">生日</th>
                <%--th width="100">创建人</th>--%>
                <%--  <th width="120">创建时间</th>--%>
                <%--<th width="100">操作</th>--%>
            </tr>
            </thead>
            <tbody>

            <c:forEach items="${empList}" var="emp">
                <tr class="text-c">
                    <td><input class="batchDel" type="checkbox" value="${emp.id}" name=""></td>
                    <td>${emp.id}</td>
                    <td>${emp.username}</td>
                    <td>${emp.mobile}</td>
                    <td>${emp.email}</td>
                        <%-- <td>
                             <!--
                                 onerror:但无法显示src的时候就会调用onerror函数
                             -->
                             <img onerror="this.src='upload/default.jpg'"  src="commonController/showPng?pngPath=${emp.userPng}"  style="width: 100px;">
                         </td>--%>
                    <td>${emp.sex ==1?"男":"女"}</td>
                        <%--<td>${emp.deptno}</td>
                        <td>${emp.createUser.username}</td>--%>
                    <td>${emp.education}</td>
                    <td>${emp.orgname}</td>
                    <td>
                        <fmt:formatDate value="${emp.birthday}" pattern="yyyy-MM-dd"/>
                    </td>
                        <%-- <td>
                             <fmt:formatDate value="${emp.updateTime}" pattern="yyyy-MM-dd"/>
                         </td>
         --%>
                        <%--<td class="td-manage">


                            <a title="编辑" href="javascript:;" onclick="admin_edit('员工编辑','empController/getEmpById/${emp.id}','1','800','500')" class="ml-5" style="text-decoration:none">
                                <i class="Hui-iconfont">&#xe6df;</i>
                            </a>

                            <a title="删除" href="javascript:;" onclick="admin_del(this,'1')" class="ml-5" style="text-decoration:none">
                                <i class="Hui-iconfont">&#xe6e2;</i>
                            </a>

                        </td>--%>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- 包含公共分页页面-->
        <jsp:include page="../common/page.jsp"/>
    </div>
    <script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>
    <script type="text/javascript" src="../../../lib/laypage/1.2/laypage.js"></script>
    <script type="text/javascript" src="../../../lib/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../../js/H-ui.js"></script>
    <script type="text/javascript" src="../../../js/H-ui.admin.js"></script>
    <script type="text/javascript" src="../../../js/oa_utils.js"></script>
    <script type="text/javascript" src="../../../lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        /*
            参数解释：
            title	标题
            url		请求的url
            id		需要操作的数据id
            w		弹出层宽度（缺省调默认值）
            h		弹出层高度（缺省调默认值）
        */

        $(function(){
            $('.table-sort').dataTable({
                "aaSorting": [[ 1, "desc" ]],//默认第几个排序
                "bStateSave": true,//状态保存
                "aoColumnDefs": [
                    //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
                    {"orderable":false,"aTargets":[0,3,4]}// 制定列不参与排序
                ]
            });
            $('.table-sort tbody').on( 'click', 'tr', function () {
                if ( $(this).hasClass('selected') ) {
                    $(this).removeClass('selected');
                }
                else {
                    table.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });
        });
        /*管理员-增加*/
        function emp_add(title,url,w,h){
            layer_show(title,url,w,h);
        }

        /*管理员-删除*/
        function admin_del(obj,id){
            layer.confirm('确认要删除吗？',function(index){
                //此处请求后台程序，下方是成功后的前台处理……

                // 发送异步请求把用户输出
                $.get("empController/deleteEmp/"+id,"",function(data){
                    responseClient(data);
                });
            });
        }
        /*管理员-编辑*/
        function admin_edit(title,url,id,w,h){
            layer_show(title,url,w,h);
        }

        function batchDel(){

            // 1.要获取用户勾选的数据
            var array = $(".batchDel:checked");

            // 2.创建一个数组
            var idArray = new Array();

            // 3.循环遍历把id放入到数组中
            for(var i =0;i<array.length;i++){
                var id = array[i].value
                idArray.push(id);
            }

            // 4.创建一个对象，把数组封装到对象中
            var param = new Object();
            param.ids=idArray;

            // 5.发送请求
            $.post("empController/batchDelEmp",param,function(data){
                reminderMsg(data);
            });
        }
    </script>
</body>
</html>
