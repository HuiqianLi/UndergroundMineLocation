<%--
  Created by IntelliJ IDEA.
  User: dashixin
  Date: 2020/5/21
  Time: 15:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>Title</title>
    <link rel="stylesheet" href="lib/layer/ui/css/layui.css" media="all">
    <script type="text/javascript" src="lib/layer/ui/layui.js"></script>
</head>
<body>
<!-- 显示分页导航条-->
<div id="test1"></div>
<script type="text/javascript">
    layui.use('laypage', function(){
        var laypage = layui.laypage;

        //执行一个laypage实例
        //完整功能
        laypage.render({
            elem: 'test1'
            ,count: "${page.total}"
            ,limit:"${page.size}"
            ,curr:"${page.current}"
            ,layout: [ 'prev', 'page', 'next', 'limit', 'count']
            ,limits:[5,10,20,30]
            ,jump: function(obj,first){
                if(!first){
                    location.href="${url}?current="+obj.curr+"&size="+obj.limit;
                }
            }
        });
    });
</script>
</body>
</html>
