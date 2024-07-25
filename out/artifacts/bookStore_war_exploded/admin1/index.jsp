<%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-26
  Time: 21:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>超级管理员后台系统</title>
    <meta http-equiv="Cache-Control" content="no-cache"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="shortcut icon" href="/favicon.ico" type="image/x-icon" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="stylesheet" href="./css/x-admin.css" media="all">
    <script src="./js/jquery.min.js" ></script>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header header header-demo" >
        <div class="layui-main" >
            <div>
                <span >超级管理员系统</span>
                <a class="logo" href="./index.jsp">
                </a>
            </div>
            <ul class="layui-nav" lay-filter="" id="ulicon">

                <li class="layui-nav-item" id="liicon">
                    <a href="javascript:;" >当前登陆：<span id="roleName" style="font-size:14px"><%=session.getAttribute("username").toString()%></span></a>
                </li>
                <script>
                    function exit(){
                        return confirm("确认退出？");
                    }
                </script>
                <li class="layui-nav-item x-index" id="liicon2"><a href="/bookStore/login/loginservlet?exit=true" onclick="return exit()">退出登陆</a></li>
            </ul>
        </div>
    </div>
    <div class="layui-side layui-bg-black x-side">
        <div class="layui-side-scroll">
            <ul  class="layui-nav layui-nav-tree site-demo-nav" lay-filter="side">
                <!--书籍管理-->
                <li class="layui-nav-item">
                    <a class="javascript:;" href="javascript:;" _href="BookMgr.jsp">
                        <cite>书籍管理</cite>
                    </a>

                </li>
                <!--用户管理-->
                <li class="layui-nav-item">
                    <a class="javascript:;" href="javascript:;" _href="UserMgr.jsp">
                        <cite>用户管理</cite>
                    </a>
                </li>
            </ul>
        </div>

    </div>
    <div class="layui-tab layui-tab-card site-demo-title x-main" lay-filter="x-tab" lay-allowclose="true">
        <div class="x-slide_left"></div>
        <ul class="layui-tab-title">
<%--            <li class="layui-this">--%>
<%--                书籍管理--%>
<%--                <i class="layui-icon layui-unselect layui-tab-close">ဆ</i>--%>
<%--            </li>--%>
        </ul>
        <div class="layui-tab-content site-demo site-demo-body">
<%--            <div class="layui-tab-item layui-show">--%>
<%--                <iframe frameborder="0" src="BookMgr.jsp" class="x-iframe" scrolling="auto" style="transform: scale(0.9)"></iframe>--%>
<%--            </div>--%>
        </div>
    </div>
    <div class="site-mobile-shade">
    </div>
</div>
<script src="./lib/layui/layui.js" charset="utf-8"></script>
<script src="./js/x-admin.js"></script>
<script src="./js/x-layui.js" charset="utf-8"></script>
<script>
    var _hmt = _hmt || [];
    (function() {
        var hm = document.createElement("script");
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
    })();

    layui.use(['form'], function(){
        form = layui.form();//弹出层
    })
    // 修改
    function updatePwd(title,url,id,w,h) {
        x_admin_show(title,url,w,h);
    }
</script>

</body>
</html>