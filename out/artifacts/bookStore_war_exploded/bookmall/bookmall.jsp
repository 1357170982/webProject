<%@ page import="java.util.Enumeration" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-26
  Time: 10:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=utf-8"/>
    <title>小书店</title>
    <meta name="keywords" content=""/>
    <meta name="description" content=""/>
    <link href="templatemo_style.css" rel="stylesheet" type="text/css"/>
</head>
<jsp:useBean id="db" class="nefu.db.conndb"/>

<%
    String id = request.getParameter("bookid");
    if (id != null) {
        if (session.getAttribute(id) != null) {
            session.setAttribute(id, Integer.parseInt(session.getAttribute(id).toString()) + 1);
        } else {
            session.setAttribute(id, 1);
        }
    }

    String delb = request.getParameter("delall");
    if (delb != null) {
        Enumeration<?> sess = session.getAttributeNames();
        while (sess.hasMoreElements()) {
            String name = sess.nextElement().toString();
            if (name != "key") {
                session.removeAttribute(name);
            }
        }
    }

    Enumeration<String> bookenum = request.getParameterNames();
    while (bookenum.hasMoreElements()) {
        String bookid = bookenum.nextElement();
        String bid = bookid.substring(bookid.length() - 1);
        if (bookid.contains("sumOfBook")) {
            session.setAttribute(bid, request.getParameter(bookid));
        }
    }
%>

<body>
<script>
    function searchb() {
        location.href = "bookmall.jsp?search=" + document.getElementById('search').value;
    }
</script>
<div id="templatemo_container">
    <div id="templatemo_menu">
        <ul>
            <li><a href="bookmall.jsp" class="current">首页</a></li>
            <li>
                <a href="/bookStore/login/loginservlet?exit=true">欢迎您，<%=session.getAttribute("username")%>，退出登录</a></li>
            <li><a href="../cart/shoppingCart.jsp">购物车</a></li>
            <li>
                <form><input type="text" id="search" size="20"><a onclick="searchb()">搜索图书</a></form>
            </li>
        </ul>
    </div>

    <div id="templatemo_header">
        <div id="templatemo_special_offers">
            <p>
                欢迎光临小书城，本店提供多种学习参考书籍
            </p>
            <a href="#" style="margin-left: 50px;">Read more...</a>
        </div>


        <div id="templatemo_new_books">
            <ul>
                <li>重构</li>
                <li>深度学习</li>
                <li>机器学习</li>
            </ul>
            <a href="#" style="margin-left: 50px;">Read more...</a>
        </div>
    </div>

    <div id="templatemo_content">

        <div id="templatemo_content_left">
            <div class="templatemo_content_left_section">
                <h1>类别</h1>
                <ul>
                    <li><a href="#">小说</a></li>
                    <li><a href="#">儿童读物</a></li>
                    <li><a href="#">非小说类</a></li>
                    <li><a href="#">专业书</a></li>
                    <li><a href="#">工具书</a></li>
                    <li><a href="#">手册</a></li>
                    <li><a href="#">剧本</a></li>
                    <li><a href="#">摄影绘画集</a></li>
                    <li><a href="#">程序类</a></li>
                </ul>
            </div>
            <div class="templatemo_content_left_section">
                <h1>畅销书</h1>
                <ul>
                    <li><a href="#">C++程序设计</a></li>
                    <li><a href="#">鸟哥的Linux私房菜</a></li>
                    <li><a href="#">机器学习</a></li>
                    <li><a href="#">深度学习</a></li>
                    <li><a href="#">数据结构与算法之美</a></li>
                    <li><a href="#">数学之美 第三版</a></li>
                    <li><a href="#">C Primer Plus 第6版 中文版</a></li>
                    <li><a href="#">重构 改善既有代码的设计（第2版 平装版）</a></li>
                    <li><a href="#">Python编程快速上手 让繁琐工作自动化 第2版</a></li>
                </ul>
            </div>
        </div>

        <div id="templatemo_content_right">

            <%
                String bookname;
                String price;
                String imgurl;
                ResultSet rs;
                String searchBook = request.getParameter("search");
                try {
                    int x = 1;

                    if (searchBook!=null && !searchBook.isEmpty()){
                        rs = db.query("select * from web.bookinfo where bookname like '%"+request.getParameter("search")+"%';");

                    } else {
                        rs = db.query("select * from web.bookinfo;");
                    }
                    while (rs.next()) {
                        x++;
                        bookname = rs.getString(1);
                        price = rs.getString(2);
                        imgurl = rs.getString(3);
            %>

            <div class="templatemo_product_box">
                <h1><%=bookname%>
                </h1>
                <img src="<%=imgurl%>" alt="image"/>
                <div class="product_info">
                    <p style="font-size: 20px">价格</p>
                    <h3>￥<%=price%>
                    </h3>
                    <div class="buy_now_button"><a href="bookmall.jsp?bookid=<%=rs.getRow()%>">Buy Now</a></div>
                    <div class="detail_button"><a href="#">Detail</a></div>
                </div>
                <div class="cleaner">&nbsp;</div>
            </div>
            <%
                if (x % 2 == 0) {
            %>
            <div class="cleaner_with_width">&nbsp;</div>

            <% } else {%>
            <div class="cleaner_with_height">&nbsp;</div>
            <%
                        }
                    }


                    db.dbclose();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            %>
            </ul>

            <a href="#"><img src="images/templatemo_ads.png" alt="ads"/></a>
        </div>

        <div class="cleaner_with_height">&nbsp;</div>
    </div>
    <script>
        var list = document.getElementsByClassName('buy_now_button');
        for (var i in list) {
            list[i].onclick = function () {
                alert('已添加至购物车');
            }
        }
    </script>
    <div id="templatemo_footer">
        <a href="#">Home</a> | <a href="#">Search</a> | <a href="#">Books</a> | <a href="#">New Releases</a> | <a
            href="#">FAQs</a> | <a href="#">Contact Us</a><br/>
        Copyright © 2024 <a href="#"><strong>H_TF</strong></a>
    </div>
</div>
</body>
</html>