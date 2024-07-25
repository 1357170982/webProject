<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-26
  Time: 0:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zxx">
<%

    if(session.getAttribute("key")!=null && session.getAttribute("key").toString().equals("2")){
        out.print("<script>alert('用户名或密码错误')</script>");
    }
%>
<head>
    <title>登录</title>

    <!-- Meta tags -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <!-- CSS Stylesheet -->
    <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />

</head>
<%
    Cookie[] cookies;
    cookies = request.getCookies();
    String user = "";
    String pwd = "";
    if (cookies != null) {
        for (Cookie c : cookies) {
            if (c.getName().equals("user")) {
                user = c.getValue();
            } else if (c.getName().equals("pwd")) {
                pwd = c.getValue();
            }
        }
    }
%>
<body>
<div class="signinform">
    <h1>网上小书城</h1>
    <!-- container -->
    <div class="container">
        <!-- main content -->
        <div class="form-info">
            <div class="finfo">
                <h2>用户登录</h2>
                <form action="loginservlet" method="post">
                    <div class="input-group">
                        <span><i class="fas fa-user" aria-hidden="true"></i></span>
                        <input type="text" name="user" placeholder="用户名" required="" value="<%=user%>">
                    </div>
                    <div class="input-group">
                        <span><i class="fas fa-key" aria-hidden="true"></i></span>
                        <input type="Password" name="ps" placeholder="密码" required="" value="<%=pwd%>">
                    </div>
                    <div class="form-row bottom">
                        <div class="form-check">
                            <input type="checkbox" id="remember-me" name="remember-me" value="true">
                            <label for="remember-me">记住密码</label>
                        </div>
                    </div>
                    <button class="btn btn-primary btn-block" type="submit">登录</button>
                </form>
                <p class="continue"><span>通过其他账户登录</span></p>
                <div class="social-login">
                    <a href="#">
                        <div class="facebook">
                            <span class="fab fa-facebook-f" aria-hidden="true"></span>

                        </div>
                    </a>
                    <a href="#">
                        <div class="twitter">
                            <span class="fab fa-twitter" aria-hidden="true"></span>
                        </div>
                    </a>
                    <a href="#">
                        <div class="google">
                            <span class="fab fa-google" aria-hidden="true"></span>
                        </div>
                    </a>
                </div>
                <p class="account"><a href="register.jsp">没有账户？</a></p>
            </div>
        </div>
        <!-- //main content -->
    </div>
    <!-- //container -->
    <!-- footer -->
    <div class="footer">
        <p>&copy; 2024 All Rights Reserved | Design by CluoGp</p>
    </div>
    <!-- footer -->
</div>

<!-- fontawesome v5-->
<script src="js/fontawesome.js"></script>

</body>

</html>