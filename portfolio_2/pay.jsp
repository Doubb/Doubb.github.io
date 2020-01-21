<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="navi_footer.css">
        <link href="css/font-awesome.min.css" rel="stylesheet">
    </head>

    <body>
        <header>
            <div class="header_top">
                <div>
                    <ul class="nav nav1">
                        <li><i class="fa fa-phone"></i>031-123-4567</li>
                        <li><i class="fa fa-envelope"></i>example@skku.edu</li>
                    </ul>
                </div>
            </div>
            <div class="header_middle">
                <div class="box">
                    <div>
                        <a href="index.jsp" id="skku_logo"><img src="skku_logo.jpg" alt="home"></a>
                    </div>
                    <div>
                        <ul class="nav nav2">
                            <li><a href=""><i class="fa fa-user"></i>Account</a></li>
                            <li><a href="wishlist.html"><i class="fa fa-star"></i>Wish List</a></li>
                            <li><a href=""><i class="fa fa-crosshairs"></i>Checkout</a></li>
                            <li><a href=""><i class="fa fa-lock"></i>Login</a></li>
                            <li><a href=""><i class="register"></i> Register</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <hr color="lightgrey" size="1px">
            <form name="search" method="post" action="search.jsp">
                <div class="header_bottom">

                    <div>
                        가격
                        <input type="text" name="priceFrom">
                        ~
                        <input type="text" name="priceTo">
                        <select name="search_select" id="">
                            <option value="productName">상품명</option>
                            <option value="sellerName">판매자</option>
                        </select>
                        <input type="text" placeholder="Search Here" name="name" id="search" class="search">
                        <button type="submit">검색</button>
                    </div>
                </div></form>
        </header>

        <form action="pay_process.jsp">
            <table border="1">
                <tr>
                    <th>Product</th>
                    <th>Price</th>
                </tr>

                <%
                    try{
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
                        System.out.println("Connected with mySQL!");
                        Statement st = conn.createStatement();
                        ResultSet rs = st.executeQuery("SELECT * FROM new_schema.cart");

                        while(rs.next()) {
                %>
                <tr>
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getString(3)%></td>
                </tr>

                <%
                        }
                    } catch (ClassNotFoundException e) {
                        e.printStackTrace();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </table>

            <input type="button" value="Buy!!">
        </form>
    </body>
</html>