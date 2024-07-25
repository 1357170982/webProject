<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-23
  Time: 20:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>用户信息</title>
</head>
<jsp:useBean id="db" class="nefu.db.conndb"></jsp:useBean>
<%
    String username = null;
    String password = null;
    ResultSet rs;
    try {
        rs = db.query("select * from web.user");
        String uid = request.getParameter("uid");
        rs.absolute(Integer.parseInt(uid));
        username = rs.getString(1);
        password = rs.getString(2);
    } catch (SQLException e){
        e.printStackTrace();
    }
%>
<body>
<form action="#" method="post">
    <p>用户信息</p><br>
    用户名:<input type="text" name="username" value="<%=username%>"><br>
    密码:<input type="text" name="password" value="<%=password%>"><br>
    <input type="submit" value="修改">
</form>
<a href="UserMgr.jsp">返回</a><br>
<%
    String cUsername;
    String cPassword;
    int i;
    cUsername = request.getParameter("username");
    cPassword = request.getParameter("password");
    if (cUsername!= null){
        i=db.update("UPDATE web.user SET user = '"+cUsername+"', password = '"+cPassword+"' WHERE (user = '"+username+"');");
        out.print("成功修改"+i+"条数据");
    }
%>
<%db.dbclose();%>
</body>
</html>
