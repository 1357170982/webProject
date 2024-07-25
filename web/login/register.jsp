<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-26
  Time: 0:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zxx">

<head>
    <title>注册</title>

    <!-- Meta tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- CSS Stylesheet -->
    <link rel="stylesheet" href="css/style.css" type="text/css" media="all"/>

</head>
<jsp:useBean id="db" class="nefu.db.conndb"/>
<%
    if (request.getParameter("user") != null) {
        String user;
        String ps;
        ResultSet rs;
        user = request.getParameter("user");
        ps = request.getParameter("ps1");

        rs = db.query("select * from web.user where user='" + user + "';");
        if (rs.next()) {
            out.print("<script>alert('用户名已存在')</script>");
        } else {
            int i = db.update("insert into web.user values('" + user + "','" + ps + "');");
            if (i == 1) {
                out.print("<script>alert('注册成功!')</script>");
            }
        }
    }
%>
<script>
    function reg() {
        if (document.getElementById('user').value === "") {
            alert('用户名不能为空')
            return false;
        } else if (document.getElementById('ps1').value === "") {
            alert('密码不能为空')
            return false;
        } else if (document.getElementById('ps1').value === document.getElementById('ps2').value) {
            return true;
        } else {
            alert('两次输入的密码不一致');
            return false;
        }
    }
</script>
<body>
<div class="signinform">
    <h1>注册</h1>
    <!-- container -->
    <div class="container">
        <!-- main content -->
        <div class="form-info">
            <div class="finfo">
                <h2>用户注册</h2>
                <form action="#" method="get">
                    <div class="input-group">
                        <span><i class="fas fa-user" aria-hidden="true"></i></span>
                        <input type="text" id="user" name="user" placeholder="用户名" required="">
                    </div>
                    <div class="input-group">
                        <span><i class="fas fa-key" aria-hidden="true"></i></span>
                        <input type="Password" id="ps1" name="ps1" placeholder="密码" required="">
                    </div>
                    <div class="input-group">
                        <span><i class="fas fa-key" aria-hidden="true"></i></span>
                        <input type="Password" id="ps2" name="ps1" placeholder="确认密码" required="">
                    </div>
                    <button class="btn btn-primary btn-block" type="submit" onclick="return reg()">注册</button>
                </form>
                <a href="index.jsp">返回登录</a>
            </div>

        </div>
        <!-- //main content -->
    </div>
    <!-- //container -->
    <!-- footer -->
    <div class="footer">
        <p>&copy; 2023 All Rights Reserved | Design by HTF</p>
    </div>
    <!-- footer -->
</div>

<!-- fontawesome v5-->
<script src="js/fontawesome.js"></script>

</body>

</html>