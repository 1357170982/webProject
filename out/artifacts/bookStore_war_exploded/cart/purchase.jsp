<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-23
  Time: 14:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:useBean id="db" class="nefu.db.conndb"></jsp:useBean>
<%
    int sum = 0;
    ResultSet rs = db.query("select * from web.bookinfo");
    Enumeration<String> bookenum = request.getParameterNames();
    while (bookenum.hasMoreElements()) {
        String bookid = bookenum.nextElement();
        String bid = bookid.substring(bookid.length()-1);
        try {
            rs.absolute(Integer.parseInt(bid));
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        sum += rs.getInt(2) * Integer.parseInt(request.getParameter("sumOfBook"+bid));
    }
    db.dbclose();
%>
<html>
<head>
    <title>购买</title>
</head>
<body>
<h1>共计<%=sum%>元<br>
<img src="./images/erweima.png"><br>
<p>推荐使用支付宝扫码付款</p>
    <a href="../bookmall/bookmall.jsp">返回</a>
</body>
</html>
