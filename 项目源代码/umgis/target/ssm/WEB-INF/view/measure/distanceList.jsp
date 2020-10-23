<%--
  Created by IntelliJ IDEA.
  User: Qinci
  Date: 2020/6/22
  Time: 0:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>测量距离记录</title>
    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../../../lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span>测量记录 <span class="c-gray en">&gt;</span> 测量距离记录 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">

    <div class="cl pd-5 bg-1 bk-gray mt-20">
    <span class="l">

    <a href="javascript:;" onclick="batchDel()" class="btn btn-danger radius">
    <i class="Hui-iconfont">&#xe60b;</i> 批量删除
    </a>

    <a href="javascript:;" onclick="doc_add('添加距离测量信息','distanceController/toAddDistance','800','500')" class="btn btn-primary radius">
    <i class="Hui-iconfont">&#xe600;</i> 添加距离测量信息
    </a>


    </span>
    </div>


    <table class="table table-border table-bordered table-hover table-bg table-sort">
        <thead>
        <tr>
            <th scope="col" colspan="8">测量距离记录</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox" name="" value=""></th>
            <th width="40">编号</th>
            <th width="150">位置1</th>
            <th width="150">位置2</th>
            <th width="150">距离</th>
            <th width="100">备注</th>
            <th width="100">创建时间</th>
            <th width="100">操作</th>

        </tr>
        </thead>
        <tbody>

        <c:forEach items="${page.records}" var="distance">
            <tr class="text-c">
                <td><input class="batchDel" type="checkbox" value="${distance.id}" name=""></td>
                <td>${distance.id}</td>
                <td>${distance.position1}</td>
                <td>${distance.position2}</td>
                <td>${distance.distance}</td>
                <td>${distance.note}</td>
                <td>${distance.createTime}</td>
                <td class="td-manage">


                    <a title="编辑" href="javascript:;" onclick="admin_edit('文档编辑','distanceController/getDistanceById/${distance.id}','1','800','500')" class="ml-5" style="text-decoration:none">
                        <i class="Hui-iconfont">&#xe6df;</i>
                    </a>

                    <a title="删除" href="javascript:;" onclick="admin_del(this,${distance.id})" class="ml-5" style="text-decoration:none">
                        <i class="Hui-iconfont">&#xe6e2;</i>
                    </a>

                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>


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
    $(function(){
        $('.table-sort').dataTable({
            "aaSorting": [[ 1, "desc" ]],//默认第几个排序
            "bStateSave": true,//状态保存
            "aoColumnDefs": [
                //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
                {"orderable":false,"aTargets":[0]}// 制定列不参与排序
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

    /*
    参数解释：
    title	标题
    url		请求的url
    id		需要操作的数据id
    w		弹出层宽度（缺省调默认值）
    h		弹出层高度（缺省调默认值）
    */
    /*管理员-增加*/
    function doc_add(title,url,w,h){
        layer_show(title,url,w,h);
    }

    /*管理员-编辑*/
    function admin_edit(title,url,id,w,h){
        layer_show(title,url,w,h);
    }

    function admin_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            $.get("distanceController/deleteDistance/"+id, "", function(data){
                responseClient(data);
            })
            $(obj).parents("tr").remove();
            layer.msg('已删除!',{icon:1,time:1000});
        });
    }

    function batchDel(){
        //debugger
        var array = $(".batchDel:checked");

        var idArray = new Array();

        for(var i=0;i<array.length;i++){
            var id=array[i].value;
            idArray.push(id);
        }

        var param = new Object();
        param.ids=idArray;

        $.post("distanceController/batchDelDistance", param, function(data){
            responseClient(data);
        });
        //location.reload();
        //location.assign(location)
    }


</script>
</body>

</html>
