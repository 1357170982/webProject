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
    <title>添加书籍信息</title>
</head>
<body>
<form action="BookMgr.jsp" method="get">
    书名:<input type="text" name="bookname"><br>
    价格:<input type="text" pattern="\d*" name="price">(数字)<br>
    图片链接:<input type="text" name="imgurl" value="images/no_picture.png"><br>
    <input type="submit" name="addbook" value="添加书籍">
</form>
<a href="BookMgr.jsp">返回</a>
</body>
</html>
