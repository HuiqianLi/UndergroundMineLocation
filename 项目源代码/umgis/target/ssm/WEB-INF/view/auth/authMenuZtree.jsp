<%--
  Created by IntelliJ IDEA.
  User: dashixin
  Date: 2020/5/25
  Time: 15:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>Title</title>

    <!-- 1. 引入资源文件-->
    <link rel="stylesheet" href="../../../lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">

    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />


    <script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.js"></script>

    <script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>

    <!-- 需要导入all.js-->
    <script type="text/javascript" src="../../../lib/zTree/v3/js/jquery.ztree.all-3.5.js"></script>

    <!-- 1.一如JquerySession插件-->
    <script type="text/javascript" src="../../../js/jquerysession.js"></script>

    <script type="text/javascript" src="../../../js/menuZtree.js"></script>

    <script type="text/javascript" src="../../../js/oa_utils.js"></script>


    <!-- 2. 初始化树-->
    <script type="text/javascript">

        var zTreeObj; // 树插件对象

        //  树插件相关的属性
        var setting = {
            check: {
                enable: true, // 显示checkbox图标
                chkStyle: "checkbox",
                chkboxType: { "Y": "ps", "N": "ps" }
            }
        };

        //  设置静态数据
        var zNodes = [];

        $(document).ready(function(){

            var roleId = "${roleId}";

            // 1.根据角色Id查询出所有的菜单()--》简单的JSON
            $.get("authController/getAuthMenuZtreeListByRoleId/"+roleId,"",function(data){

                // 2.把简单的JSON格式转成标准的JSON格式--》工具类
                var json = format(data);

                // 3.赋值给zNodes,静态数据
                zNodes = json;

                // 4.初始化树插件
                zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
            });

        });


        function selectMenu() {

            // 1.获取角色角色
            var roleId = "${roleId}";

            // 2.获取用户勾选的节点
            var treeObj = $.fn.zTree.getZTreeObj("treeDemo"); // 根据树元素id获取树对象
            var nodes = treeObj.getCheckedNodes(true); // 获取用选中的节点

            // 3.遍历把菜单id添加到数组中
            var mIdArray = new Array();
            for(var i =0;i<nodes.length;i++){
                mIdArray.push(nodes[i].id);
            }

            // 4.把角色id和菜单id封装到一个对象中
            var param = new Object();
            param.roleId = roleId;
            param.mIdArray=mIdArray;

            // 5.发送请求调用Controller入库
            $.post("authController/authRoleMenu",param,function(data){
                responseClient(data);
            });
        }
    </script>
</head>
<body>

<!-- 2.准备容器，用来显示树-->
<div>
    <input class="btn btn-primary radius"  onclick="selectMenu()" type="button" value="确定">
    <ul id="treeDemo" class="ztree"></ul>
</div>
</body>
</html>
