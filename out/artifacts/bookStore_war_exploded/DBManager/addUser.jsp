<%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-23
  Time: 21:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加用户</title>
</head>
<body>
<form action="UserMgr.jsp" method="post">
    用户名:<input type="text" name="username"><br>
    密码:<input type="text" name="password"><br>
    <input type="submit" value="注册" name="register">
</form>
<a href="UserMgr.jsp">返回</a>
</body>
</html>
