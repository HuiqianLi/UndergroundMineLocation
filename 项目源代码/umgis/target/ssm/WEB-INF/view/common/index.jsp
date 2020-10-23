<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <title>Title</title>
    <link href="../../../css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="../../../skin/default/skin.css" rel="stylesheet" type="text/css" id="skin" />
    <link href="../../../lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/style.css" rel="stylesheet" type="text/css" />

</head>
<body>
<header class="Hui-header cl"> <a class="Hui-logo l" title="H-ui.admin v2.3" href="/">UMGIS</a> <a class="Hui-logo-m l" href="/" title="H-ui.admin">H-ui</a> <span class="Hui-subtitle l">V1.0</span>
    <nav class="mainnav cl" id="Hui-nav">
<%--        <ul>--%>
<%--            <li class="dropDown dropDown_click"><a href="javascript:;" class="dropDown_A"><i class="Hui-iconfont">&#xe600;</i> 新增 <i class="Hui-iconfont">&#xe6d5;</i></a>--%>
<%--                <ul class="dropDown-menu radius box-shadow">--%>
<%--                    <li><a href="javascript:;" onclick="member_add('添加用户','member-add.html','','510')"><i class="Hui-iconfont">&#xe60d;</i> 用户</a></li>--%>
<%--                </ul>--%>
<%--            </li>--%>
<%--        </ul>--%>
    </nav>
    <ul class="Hui-userbar">
        <li>你好！</li>
        <li class="dropDown dropDown_hover"><a href="#" class="dropDown_A">${sessionScope.user.username} <i class="Hui-iconfont">&#xe6d5;</i></a>
            <ul class="dropDown-menu radius box-shadow">
                <li><a href="userController/logout">切换账户</a></li>
                <li><a href="userController/logout">退出</a></li>
            </ul>
        </li>
        <li id="Hui-msg"> <a href="#" title="消息"><span class="badge badge-danger">1</span><i class="Hui-iconfont" style="font-size:18px">&#xe68a;</i></a> </li>
        <li id="Hui-skin" class="dropDown right dropDown_hover"><a href="javascript:;" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
            <ul class="dropDown-menu radius box-shadow">
                <li><a href="javascript:;" data-val="default" title="默认（黑色）">默认（黑色）</a></li>
                <li><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                <li><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                <li><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                <li><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                <li><a href="javascript:;" data-val="orange" title="绿色">橙色</a></li>
            </ul>
        </li>
    </ul>
    <a aria-hidden="false" class="Hui-nav-toggle" href="#"></a> </header>
<aside class="Hui-aside">
    <input runat="server" id="divScrollValue" type="hidden" value="" />
    <div class="menu_dropdown bk_2">
        <shiro:hasPermission name="employee">
        <dl id="menu-picture">
            <dt><i class="Hui-iconfont">&#xe613;</i> 员工管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <shiro:hasPermission name="emp:manage">
                    <li><a _href="empController/getEmpList/${sessionScope.user.id}" href="javascript:void(0)">员工信息管理</a></li> </shiro:hasPermission>
                    <shiro:hasPermission name="emp:my">
                    <li><a _href="empController/getMyEmpList/${sessionScope.user.id}" href="javascript:void(0)">个人信息维护</a></li> </shiro:hasPermission>
                </ul>
            </dd>
        </dl>
        </shiro:hasPermission>
<%--        <shiro:hasPermission name="statistics">--%>
<%--        <dl id="menu-picture">--%>
<%--            <dt><i class="Hui-iconfont">&#xe613;</i> 统计管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>--%>
<%--            <dd>--%>
<%--                <ul>--%>
<%--                    <shiro:hasPermission name="sta:org">--%>
<%--                    <li><a _href="empController/getOrgChart" href="javascript:void(0)">部门性别统计</a></li></shiro:hasPermission>--%>
<%--                    <shiro:hasPermission name="sta:edu">--%>
<%--                    <li><a _href="toEductionChart" href="javascript:void(0)">学历比例统计</a></li></shiro:hasPermission>--%>
<%--                </ul>--%>
<%--            </dd>--%>
<%--        </dl>--%>
<%--        </shiro:hasPermission>--%>
<%--        <shiro:hasPermission name="institution">--%>
<%--        <dl id="menu-product">--%>
<%--            <dt><i class="Hui-iconfont">&#xe620;</i> 组织机构管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>--%>
<%--            <dd>--%>
<%--                <ul>--%>
<%--                    <shiro:hasPermission name="ins:org">--%>
<%--                    <li><a _href="orgController/getOrgPage" href="javascript:void(0)">机构管理</a></li></shiro:hasPermission>--%>
<%--                    <shiro:hasPermission name="ins:dept">--%>
<%--                    <li><a _href="deptController/getDeptPage" href="javascript:void(0)">部门管理</a></li></shiro:hasPermission>--%>
<%--                    <shiro:hasPermission name="ins:form">--%>
<%--                    <li><a _href="staffController/getStaffPage" href="javascript:void(0)">编制管理</a></li></shiro:hasPermission>--%>
<%--                </ul>--%>
<%--            </dd>--%>
<%--        </dl>--%>
<%--        </shiro:hasPermission>--%>
        <dl id="menu-article">
            <dt><i class="Hui-iconfont">&#xe616;</i> 资讯管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>

                    <li><a _href="docController/getDocPage" href="javascript:void(0)">文档管理</a></li>
                </ul>
            </dd>
        </dl>
        <shiro:hasPermission name="measure">
        <dl id="menu-picture">
            <dt><i class="Hui-iconfont">&#xe613;</i> 测量记录<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>

                    <shiro:hasPermission name="mea:distance">
                    <li><a _href="distanceController/getDistancePage" href="javascript:void(0)">测量距离列表</a></li></shiro:hasPermission>
                    <shiro:hasPermission name="mea:area">
                    <li><a _href="areaController/getAreaPage" href="javascript:;">测量面积列表</a></li></shiro:hasPermission>
                    <shiro:hasPermission name="mea:mark">
                    <li><a _href="markController/getMarkPage" href="javascript:;">标记列表</a></li></shiro:hasPermission>
                </ul>
            </dd>
        </dl>
        </shiro:hasPermission>
<%--        <shiro:hasPermission name="sal:attendance">--%>
<%--        <dl id="menu-attendance">--%>
<%--            <dt><i class="Hui-iconfont">&#xe60d;</i> 考勤管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>--%>
<%--            <dd>--%>

<%--                <ul>--%>
<%--                    <shiro:hasPermission name="atten:list">--%>
<%--                    <li><a _href="attendanceController/getAttendanceList" href="javascript:;">人员考勤列表</a></li>--%>
<%--                    </shiro:hasPermission>--%>
<%--                    <shiro:hasPermission name="atten:my">--%>
<%--                    <li><a _href="attendanceController/getMyAttendanceList/${sessionScope.user.id}" href="javascript:;">我的考勤</a></li></shiro:hasPermission>--%>
<%--                </ul>--%>
<%--            </dd>--%>
<%--        </dl>--%>
<%--        </shiro:hasPermission>--%>
<%--        <shiro:hasPermission name="variation">--%>
<%--        <dl id="menu-emp">--%>
<%--            <dt><i class="Hui-iconfont">&#xe616;</i> 人员异动<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>--%>
<%--            <dd>--%>
<%--                <ul>--%>
<%--                    <shiro:hasPermission name="var:cont">--%>
<%--                    <li><a _href="contractController/getContractPage" href="javascript:void(0);">合同登记</a></li></shiro:hasPermission>--%>
<%--                    <shiro:hasPermission name="var:emp">--%>
<%--                    <li><a _href="empReController/getEmpRePage" href="javascript:;">员工档案</a></li></shiro:hasPermission>--%>
<%--                </ul>--%>
<%--            </dd>--%>
<%--        </dl>--%>
<%--        </shiro:hasPermission>--%>
        <shiro:hasPermission name="system">
        <dl id="menu-article">
            <dt><i class="Hui-iconfont">&#xe616;</i> 系统管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <shiro:hasPermission name="sys:role">
                    <li><a _href="roleController/getRoleList" href="javascript:void(0)">角色管理</a></li></shiro:hasPermission>
                    <shiro:hasPermission name="sys:auth">
                    <li><a _href="authController/toAuthPage" href="javascript:void(0)">授权管理</a></li></shiro:hasPermission>
<%--                    <shiro:hasPermission name="sys:org">--%>
<%--                    <li><a _href="authController/toAuthOrg" href="javascript:void(0)">机构授权</a></li></shiro:hasPermission>--%>
                </ul>
            </dd>
        </dl>
        </shiro:hasPermission>
    </div>
</aside>
<div class="dislpayArrow"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a></div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active"><span title="我的桌面" data-href="toWelcome">我的桌面</span><em></em></li>
            </ul>
        </div>
        <div class="Hui-tabNav-more btn-group"><a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a><a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a></div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="/toWelcome"></iframe>
        </div>
    </div>
</section>
<script type="text/javascript" src="../../../lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../../../lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="../../../js/H-ui.js"></script>
<script type="text/javascript" src="../../../js/H-ui.admin.js"></script>
<script type="text/javascript">
    /*资讯-添加*/
    function article_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*图片-添加*/
    function picture_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*产品-添加*/
    function product_add(title,url){
        var index = layer.open({
            type: 2,
            title: title,
            content: url
        });
        layer.full(index);
    }
    /*用户-添加*/
    function member_add(title,url,w,h){
        layer_show(title,url,w,h);
    }
</script>
<script type="text/javascript">
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        hm.src = "//hm.baidu.com/hm.js?080836300300be57b7f34f4b3e97d911";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s)})();
    var _bdhmProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
    document.write(unescape("%3Cscript src='" + _bdhmProtocol + "hm.baidu.com/h.js%3F080836300300be57b7f34f4b3e97d911' type='text/javascript'%3E%3C/script%3E"));
</script>
</body>
</html>
