<%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-23
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="nefu.db.conndb"></jsp:useBean>
<html>
<head>
    <title>控制台</title>
</head>
<body>
登录key:<%=session.getAttribute("key")%><br><br>
<a href="UserMgr.jsp">用户管理</a><br>
<a href="BookMgr.jsp">书库管理</a><br><br>
<a href="/bookStore/login/loginservlet?exit=true">退出</a>
</body>
</html>
