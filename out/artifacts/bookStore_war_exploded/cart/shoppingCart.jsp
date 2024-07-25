<%--
  Created by IntelliJ IDEA.
  User: FLC
  Date: 2023-11-18
  Time: 17:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>购物车</title>

    <!-- For-Mobile-Apps -->
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="keywords" content="购物车" />
    <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
    <!-- //For-Mobile-Apps -->

    <!-- Custom-Theme-Files -->
    <link rel="stylesheet" href="./css/style.css" type="text/css" media="all" />
    <!-- //Custom-Theme-Files -->

    <!-- Remove-Item-JavaScript -->
    <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>

    <!-- //Remove-Item-JavaScript -->

</head>
<script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
<%
    if (request.getParameter("delbook")!=null){
        session.removeAttribute(request.getParameter("delbook"));
    }
%>
<!-- Body-Starts-Here -->
<body>
<h1>购物车</h1>

<!-- Content-Starts-Here -->
<div class="container">
    <!-- Mainbar-Starts-Here -->
    <div class="main-bar">
        <div class="product">
            <h3>商品</h3>
        </div>
        <div class="quantity">
            <h3>数量</h3>
        </div>
        <div class="price">
            <h3>价格</h3>
        </div>
        <div class="clear"></div>
    </div>
    <!-- //Mainbar-Ends-Here -->
    <!-- Items-Starts-Here -->
    <div class="items">
        <!-- Item1-Starts-Here -->
        <form action="#" id="form1" name="form1">
        <jsp:useBean id="db" class="nefu.db.conndb"></jsp:useBean>
        <%
            boolean a = false;
            ResultSet rs;
            rs = db.query("select count(*) from web.bookinfo;");
            try {
                rs.next();
                int numOfBook = rs.getInt(1);
                for (int i = 1; i <= numOfBook; i++) {
                    if(session.getAttribute(String.valueOf(i))!=null){
                        a = true;
                        rs = db.query("select * from web.bookinfo;");
                        rs.absolute(i);
                        String bookname = rs.getString(1);
                        String price = rs.getString(2);
                        String imgurl = rs.getString(3);
        %>

        <script>
            $(document).ready(function(c) {
                $('.alert-close<%=i%>').on('click', function(c){
                    $('.close<%=i%>').fadeOut('slow', function(c){
                        $('.close<%=i%>').remove();
                        location.assign("http://localhost:8080/bookStore/cart/shoppingCart.jsp?delbook="+<%=i%>);
                    });
                });
            });
        </script>
        <div class="item1">
            <div class="close<%=i%>">
                <!-- Remove-Item -->
                <div class="alert-close<%=i%>" style="
                background: url('./images/close1.png') no-repeat 0px 0;
                cursor: pointer;
                height: 22px;
                width: 22px;
                position: absolute;
                right: 0;
                top: 20px;
                -webkit-transition: color 0.2s ease-in-out;
                -moz-transition: color 0.2s ease-in-out;
                -o-transition: color 0.2s ease-in-out;
                transition: color 0.2s ease-in-out;">
                </div>
                <!-- //Remove-Item -->
                <div class="image1">
                    <img src="../bookmall/<%=imgurl%>" alt="item1">
                </div>
                <div class="title1">
                    <p><%=bookname%></p>
                </div>
                <div class="quantity1">
                        <input type="button" value="-" onclick="minus(<%=i%>)">
                        <input type="text" id="sumOfBook<%=i%>" name="sumOfBook<%=i%>" value="<%=session.getAttribute(String.valueOf(i))%>" size="1">
                        <input type="button" value="+" onclick="plus(<%=i%>)">
                </div>
                <div class="price1">
                    <p>RMB <%=price%></p>
                </div>
                <div class="clear"></div>
            </div>
        </div>

        <!-- //Item-Ends-Here -->
        <%
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            if(!a){
                out.print("<p style=\"color: #8d8d8d\">购物车为空</p>");
            }
        %>
        </form>
        <script>
            function plus(x){
                var num = document.getElementById("sumOfBook"+x).value;
                num ++;
                document.getElementById("sumOfBook"+x).value = num;
            }
            function minus(x){
                var num = document.getElementById("sumOfBook"+x).value;
                if (num > 1){
                    num --;
                    document.getElementById("sumOfBook"+x).value = num;
                } else {
                    alert("数量至少为1！");
                }
            }
        </script>
    </div>
    <!-- //Items-Ends-Here -->
    <div class="total">
        <div class="clear"></div>
    </div>
    <script>
        function submitFrom(mets,path){
            $("#form1").attr("action",path);
            $("#form1").attr("method",mets);
            $("#form1").submit();
        }
    </script>
    <!-- Checkout-Starts-Here -->
    <div class="checkout">
<%--        <div class="discount">--%>
<%--            <span>Apply Discount Code</span> <input type="text">--%>
<%--        </div>--%>
        <div class="checkout-btn">
            <a onclick="submitFrom('get','purchase.jsp')">确认支付</a>
        </div>
    <br>
    <br>
        <div class="clear"></div>
        <div class="checkout-btn">
            <a onclick="submitFrom('get','../bookmall/bookmall.jsp')">继续购物</a>
        </div>
        <div class="clear"></div>
    </div>

    <!-- //Checkout-Ends-Here -->

</div>
<!-- Content-Ends-Here -->
</body>
<!-- Body-Ends-Here -->

</html>
