<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-23
  Time: 16:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>书籍信息</title>
</head>
<jsp:useBean id="db" class="nefu.db.conndb"></jsp:useBean>
<%
    String bookname = null;
    String price = null;
    String imgurl = null;
    ResultSet rs;
    try {
        rs = db.query("select * from web.bookinfo");
        String bid = request.getParameter("bookid");
        rs.absolute(Integer.parseInt(bid));
        bookname = rs.getString(1);
        price = rs.getString(2);
        imgurl = rs.getString(3);
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<body>
<form action="#" method="post">
    <p>书籍信息</p>
    <img src="../bookmall/<%=imgurl%>"><br>
    图片地址:<input type="text" name="imgurl" value="../bookmall/<%=imgurl%>"><br>
    书名:<input type="text" name="bookname" value="<%=bookname%>"><br>
    价格:<input type="text" name="price" value="<%=price%>"><br>
    <input type="submit" value="修改">
</form>
<a href="BookMgr.jsp">返回</a><br>
<%
    String cBookname;
    String cPrice;
    String cImgurl;
    int i;
    cBookname = request.getParameter("bookname");
    cPrice = request.getParameter("price");
    cImgurl = request.getParameter("imgurl");
    if(cBookname!=null){
        i = db.update("UPDATE web.bookinfo SET bookname = '"+cBookname+"',bookprice='"+cPrice+"',imageurl='"+cImgurl+"' WHERE (bookname = '"+bookname+"');");
        out.print("成功修改"+i+"条数据");
    }
%>
<%db.dbclose();%>

</body>
</html>
