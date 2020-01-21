<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>

<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection connect = null;
    Statement stmt = null;
    ResultSet rst = null;
    String url = "jdbc:mysql://localhost:3306/new_schema?useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="navi_footer.css">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script class="jsbin" src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.0/jquery-ui.min.js"></script>

    <style>
        h2 {
            margin-top: 70px;
            margin-left: 43%;
            color: orange;
        }

        .texts {
            grid-column: 1 / 2;
            font-family: Helvetica, Arial, sans-serif;
            font-size: 20px;
            margin-left: 150px;
        }

        .imgs {
            margin-top: 40px;
            margin-bottom: 50px;
            margin-right: 100px;
            grid-column: 2 / 3;
        }

        .wrapper {
            display: grid;
        }

        .buttons {
            text-align: center;
        }

        input[type=submit] {
            background-color: orange;
            border: none;
            padding: 7px;
            color: white;
            display: inline-block;
            width: 100px;
            font-size: 15px;
            margin: 30px 15px 50px;
        }

    </style>
</head>

<script>
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#blah')
                    .attr('src', e.target.result);
            };

            reader.readAsDataURL(input.files[0]);
        }
    }
</script>

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
                <a href="index.jsp?id=<%=request.getParameter("id")%>" id="skku_logo"><img src="skku_logo.jpg" alt="home"></a>
            </div>
            <div>
                <ul class="nav nav2">

                    <%
                        if(request.getParameter("id") == null){
                    %>
                    <li><a href="login.jsp"><i class="fa fa-user"></i> Account</a></li>
                    <li><a href="login.jsp"><i class="fa fa-star"></i> Wish List</a></li>
                    <li><a href="register.jsp"><i class="fa fa-crosshairs"></i> Register</a></li>
                    <li><a href="login.jsp"><i class="fa fa-lock"></i> Login</a></li>
                    <%
                    }
                    else{
                    %>
                    <%
                        try{
                            String people ="";
                            connect = DriverManager.getConnection(url, "root", "dnjs0306");
                            String sqlstring = "SELECT * FROM user WHERE userName = ?";
                            PreparedStatement ps = connect.prepareStatement(sqlstring);
                            ps.setString(1,request.getParameter("id"));
                            rst = ps.executeQuery();


                            if(rst!=null){
                                while(rst.next()){
                                    people = rst.getString("people");
                                }
                            }

                            if(people.equals("Admin")){
                    %>
                    <li><a href="admin_list.jsp?id=<%=request.getParameter("id")%>"><i class="fa fa-user"></i> Account</a></li>
                    <%
                    }
                    else if(people.equals("Buyer")){
                    %>
                    <li><a href="buyer_list.jsp?id=<%=request.getParameter("id")%>"><i class="fa fa-user"></i> Account</a></li>
                    <%
                    }
                    else if(people.equals("Seller")){
                    %>
                    <li><a href="seller_list.jsp?id=<%=request.getParameter("id")%>"><i class="fa fa-user"></i> Account</a></li>
                    <%
                            }

                        }catch(SQLException sqlException){
                            System.out.println("sql exception");
                        } catch (Exception exception){
                            System.out.println("exception");
                        } finally{
                            if(rst!=null)
                                try {rst.close();}
                                catch (SQLException ex) {}
                            if(stmt!=null)
                                try {stmt.close();}
                                catch (SQLException ex) {}
                            if(connect!=null)
                                try {connect.close();}
                                catch (SQLException ex) {}
                        }
                    %>

                    <li><a href="wishlist.jsp?id=<%=request.getParameter("id")%>"><i class="fa fa-star"></i> Wish List</a></li>
                    <li><a href="register.jsp?id=<%=request.getParameter("id")%>"><i class="fa fa-crosshairs"></i> Register</a></li>
                    <li><a href="login.jsp"><i class="fa fa-lock"></i> Logout</a></li>
                    <%
                        }
                    %>
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
<%
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
        System.out.println("Connected with mySQL!");
        Statement st = conn.createStatement();

        %>

    <h2>Product Regristratoin</h2>
    <form action="product_register.jsp">
        <div class="wrapper">
        <div class="texts">
        <label>Product Name:</label>
        <input type="text" name="productName"> <br>

        <label>Product Price:</label>
        <input type="text" name="productPrice"> <br>

        <label>Seller Name:</label>
        <input type="text" name="sellerName"> <br>

        <label>Phone Number:</label>
        <input type="text" name="phoneNumber"> <br>

        <label>Trading Place:</label>
        <input type="text" name="tradePlace"> <br>

        <div id="lower">
            <label>Flea Market</label>
            <input type="checkbox" name="productType" value="fleaMarket"> <br>

            <label>Auction</label>
            <input type="checkbox" name="productType" value="auction"> <br>
        </div>
        </div>

        <div class="imgs">
        <input type="file" onchange="readURL(this);" name="image"/>
        <img src="http://placehold.it/180" alt="your image" id="blah"/>
        </div>
        </div>

        <div class="buttons">
        <input type="submit" value="Registration">
        </div>
    </form>

<%

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<footer>
    <div class="footer">
        <table>
            <tr>
                <td style=" border-right:1px solid black; padding-right:12px; text-align:justify">
                    <p><b>(주) 성균관 마켓</b></p>
                    <p>경기도 장안구 서부로 2066 성균관대학교</p>
                    <p>대표이사: 홍길동</p>
                    <p>사업자등록번호 : 123-12-123456</p>
                </td>
                <td style=" border-right:1px solid black; padding-right:12px; text-align:justify">
                    <p><b>전자금융 분쟁처리</b></p>
                    <p>Tel: 1588-1234 Fax: 031-123-1234</p>
                    <p>Email: mediation@skku.edu</p>
                    <p>통신판매업신고 : 경기 12345호</p>
                </td>
                <td>
                    <a href="http://www.ftc.go.kr/"><img src="공정위.png" alt=""></a>
                    <img src="획득.jpg" alt="">
                </td>
            </tr>
        </table>
    </div>
    <div class="copyright">
        <p>Copyright &copy; 2019 TEAM 14. All rights reserved. </p>
    </div>
</footer>
</body>
</html>