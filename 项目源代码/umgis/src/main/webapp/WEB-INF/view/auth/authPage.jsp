
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>部门列表</title>
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
                类型：
                <span class="select-box" style="width:150px;">
				<select class="select" id="type" size="1">
					<option value="">==请选择==</option>
					<option value="1">人员</option>
					<option value="2">菜单</option>
				</select>
				</span>
            </div>
        </div>
        <div class="row cl">
            <div class="cl pd-5">
                <button type="button"
                        class="btn btn-success radius" onclick="search_auth()">
                    <i class="Hui-iconfont">&#xe665;</i> 搜索
                </button>
            </div>
        </div>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
            <span class="l">

                <a href="javascript:;" onclick="auth_user()" class="btn btn-primary radius">
                    <i class="Hui-iconfont">&#xe600;</i> 授权人员
                </a>

                <a href="javascript:;" onclick="auth_menu()" class="btn btn-primary radius">
                    <i class="Hui-iconfont">&#xe600;</i> 授权菜单
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


    function search_auth() {

        // 1.先判断是否选择角色
        if (!isSelectRole()) {
            return false;
        }

        var type = $("#type").val();

        // 2.在判断是否选择类型
        if (!type) {
            layer.msg("请先选择类型", {time: 1000, icon: 3});
            return false;
        }

        // 3.怕段用户选择的类型
        if (type == "1") { // 查询人员(查询哪个员工拥有当前角色) t_menu_emp

            $("#auth_table").load("authController/getEmpListByRoleId/" + roleId); //

        } else if (type == "2") { // 查询菜单

            $("#auth_table").load("authController/getMenuListByRoleId/" + roleId);
        }
    }

    /**
     * 给人员赋予角色
     */
    function auth_user() {
        if (isSelectRole()) {
            // 3.弹出一个框，显示有的用户
            layer_show("选择用户", "authController/getAllEmp?roleId=" + roleId, "500", "500")
        }
    }

    function auth_menu() {

        if (isSelectRole()) {
            // 3.弹出一个框，显示有的菜单
            layer_show("选择权限", "authController/toAuthMenuZtreePage/" + roleId, "400", "400")
        }

    }
</script>
</body>
</html>
