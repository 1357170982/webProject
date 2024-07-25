<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="static java.lang.Math.ceil" %><%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-23
  Time: 15:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html><head>
    <title>BookMgr</title>
</head>
<link rel="stylesheet" href="css/tablecss.css">
<jsp:useBean id="db" class="nefu.db.conndb"></jsp:useBean>
<%
    String bookname = request.getParameter("bookname");
    String price = request.getParameter("price");
    String imgurl = request.getParameter("imgurl");
    try {
        if (bookname != null) {
            int i;
            ResultSet rs = db.query("select * from web.bookinfo where bookname='" + bookname + "';");
            if (rs.next()) {
                out.print("<script>alert('书籍已存在')</script>");
            } else {
                i = db.update("INSERT INTO web.bookinfo (bookname, bookprice, imageurl) VALUES ('" + bookname + "', '" + price + "', '" + imgurl + "');");
                out.print("<script>alert('成功添加" + i + "本书籍')</script>");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<body>
<script>
    function delf() {
        return confirm('确认删除?');
    }
</script>
<a href="addBook.jsp">添加书籍</a>
<table>
    <tr>
        <th>书籍</th>
        <th>书名</th>
        <th>价格</th>
        <th>管理</th>
        <th>删除</th>
    </tr>
    <%
        int nowpage = 1;
        int pagesize = 3;
        int totalpage = 1;
        int totalnumber = 1;

        if (request.getParameter("del") != null) {
            db.update("DELETE FROM web.bookinfo WHERE (bookname = '" + request.getParameter("del") + "');");
        }

        if (request.getParameter("pagesize") != null) {
            pagesize = Integer.parseInt(request.getParameter("pagesize"));
        }

        ResultSet rs;
        String sql = "select * from web.bookinfo";
        String sql1 = "select count(*) as total from web.bookinfo";
        try {
            rs = db.query(sql1);
            rs.next();
            totalnumber = rs.getInt(1);

            totalpage = (int) ceil((double) totalnumber /pagesize);

            rs = db.query(sql);
            try {
                nowpage = Integer.parseInt(request.getParameter("nowpage"));
            } catch (Exception e) {
                nowpage = 1;
            }

            if (nowpage > totalpage) {
                nowpage = totalpage;
            } else if (nowpage < 1) {
                nowpage = 1;
            }

            rs.absolute((nowpage - 1) * pagesize + 1);
            for (int i = 0; i < pagesize; i++) {
    %>

    <tr>
        <td><img src="../bookmall/<%=rs.getString(3)%>"></td>
        <td><%=rs.getString(1)%>
        </td>
        <td><%=rs.getString(2)%>
        </td>
        <td><a href="bookinfo.jsp?bookid=<%=rs.getRow()%>">详情</a></td>
        <td><a href="BookMgr.jsp?del=<%=rs.getString(1)%>&nowpage=<%=nowpage%>&pagesize=<%=pagesize%>"
               onclick="return delf()">删除</a></td>
    </tr>
    <%
                if (!rs.next()) {
                    break;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            db.dbclose();
        }
    %>

</table>
<form action="#" method="get">
    跳转至<input type="text" name="nowpage" size=1>
    <input type="submit" value="Go"><br>
    <%
        if (nowpage == 1) {
            out.print("&emsp;&emsp;&emsp;&emsp;<a href=BookMgr.jsp?nowpage=" + (nowpage + 1) + "&pagesize=" + pagesize + ">下一页</a>");
            out.print("<a href=BookMgr.jsp?nowpage=" + totalpage + "&pagesize=" + pagesize + ">尾页</a>");
        } else if (nowpage == totalpage) {
            out.print("<a href=BookMgr.jsp?pagesize=" + pagesize + ">首页</a>");
            out.print("<a href=BookMgr.jsp?nowpage=" + (nowpage - 1) + "&pagesize=" + pagesize + ">上一页</a>");
        } else {
            out.print("<a href=BookMgr.jsp?pagesize=" + pagesize + ">首页</a>");
            out.print("<a href=BookMgr.jsp?nowpage=" + (nowpage - 1) + "&pagesize=" + pagesize + ">上一页</a>");
            out.print("<a href=BookMgr.jsp?nowpage=" + (nowpage + 1) + "&pagesize=" + pagesize + ">下一页</a>");
            out.print("<a href=BookMgr.jsp?nowpage=" + totalpage + "&pagesize=" + pagesize + ">尾页</a>");
        }
    %><br>
    共<%=totalnumber%>条数据，当前为第<%=nowpage%>页，共<%=totalpage%>页<br>
    页面大小<a href="BookMgr.jsp?pagesize=3">[3]</a>&emsp;<a href="BookMgr.jsp?pagesize=5">[5]</a>&emsp;<a
        href="BookMgr.jsp?pagesize=10">[10]</a>
</form>
</body>
</html>
