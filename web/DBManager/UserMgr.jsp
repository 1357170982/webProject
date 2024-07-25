<%@ page import="java.sql.ResultSet" %>
<%@ page import="static java.lang.Math.round" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="static java.lang.Math.ceil" %><%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-23
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>UserMgr</title>
</head>
<jsp:useBean id="db" class="nefu.db.conndb"></jsp:useBean>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    try {
        if (request.getParameter("register") != null) {
            int i;
            ResultSet rs = db.query("select * from web.user where user = '" + username + "'");
            if (rs.next()) {
                out.print("<script>alert('用户名已存在')</script>");
            } else {
                i = db.update("INSERT INTO web.user (user, password) VALUES ('" + username + "', '" + password + "');");
                out.print("<script>alert('成功添加" + i + "名用户')</script>");
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<body>

<script>
    function delf() {
        return confirm('确认删除');
    }
</script>
<a href="addUser.jsp">添加新用户</a>
<table border=1>
    <tr>
        <th>用户名</th>
        <th>密码</th>
        <th>修改</th>
        <th>删除</th>
    </tr>

    <%
        int nowpage = 1;
        int pagesize = 5;
        int totalpage = 1;
        int totalnumber = 1;
        ResultSet rs;
        if (request.getParameter("del") != null) {
            db.update("DELETE FROM web.user WHERE (user = '" + request.getParameter("del") + "');");
        }
        String sql = "select * from web.user";
        String sql1 = "select count(*) as total from web.user";
        if (request.getParameter("pagesize") != null) {
            pagesize = Integer.parseInt(request.getParameter("pagesize"));
        }
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
        <td><%=rs.getString(1)%>
        </td>
        <td><%=rs.getString(2)%>
        </td>
        <td><a href="userinfo.jsp?uid=<%=rs.getRow()%>">修改</a></td>
        <td><a href="UserMgr.jsp?del=<%=rs.getString(1)%>&nowpage=<%=nowpage%>&pagesize=<%=pagesize%>"
               onclick="return delf()">删除</a></td>
    </tr>
    <%

                if (!rs.next()) {
                    break;
                }
            }
            db.dbclose();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</table>
<form action="#" method="get">
    跳转至<input type="text" name="nowpage" size=1>
    <input type="submit" value="Go"><br>
    <%
        if (nowpage == 1) {
            out.print("<a href=UserMgr.jsp?nowpage=" + (nowpage + 1) + "&pagesize=" + pagesize + ">下一页</a>");
            out.print("<a href=UserMgr.jsp?nowpage=" + totalpage + "&pagesize=" + pagesize + ">尾页</a>");
        } else if (nowpage == totalpage) {
            out.print("<a href=UserMgr.jsp?pagesize=" + pagesize + ">首页</a>");
            out.print("<a href=UserMgr.jsp?nowpage=" + (nowpage - 1) + "&pagesize=" + pagesize + ">上一页</a>");
        } else {
            out.print("<a href=UserMgr.jsp?pagesize=" + pagesize + ">首页</a>");
            out.print("<a href=UserMgr.jsp?nowpage=" + (nowpage - 1) + "&pagesize=" + pagesize + ">上一页</a>");
            out.print("<a href=UserMgr.jsp?nowpage=" + (nowpage + 1) + "&pagesize=" + pagesize + ">下一页</a>");
            out.print("<a href=UserMgr.jsp?nowpage=" + totalpage + "&pagesize=" + pagesize + ">尾页</a>");
        }
    %><br>
    共<%=totalnumber%>条数据，当前为第<%=nowpage%>页，共<%=totalpage%>页<br>
    页面大小&emsp;<a href="UserMgr.jsp?pagesize=3">[3]</a>&emsp;<a href="UserMgr.jsp?pagesize=5">[5]</a>&emsp;<a
        href="UserMgr.jsp?pagesize=10">[10]</a>
</form>
<a href="index.jsp">返回</a>
</body>
</html>
