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

    <style>
        h2 {
            margin-top: 70px;
            margin-left: 43%;
            color: orange;
        }

        .button {
            background-color: orange;
            border: none;
            padding: 7px;
            color: white;
            display: inline-block;
            margin: 15px;
            width: 100px;
            font-size: 15px;
        }

        #buttons {
            text-align: center;
        }

        #list {
            text-align: center;
            margin: 30px auto 50px;
            border: 2px solid;
            font-family: Helvetica, Arial, sans-serif;
            font-size: 14px;
            line-height: 20px;
            font-weight: 400;
            width: 640px;
            border-collapse: collapse;
            border-spacing: 0;
        }

        td, th {
            border: 1px solid #CCC;
            height: 30px;
        }

        th {
            background: #F3F3F3;
            font-weight: bold;
        }

        td {
            background: #FAFAFA;
            text-align: center;
        }

    </style>
</head>

<script>
    function mod() {
        let url = "admin_list_modify.jsp";
        window.open(url);
    }

    function del() {
        let url = "admin_list_delete.jsp";
        window.open(url);
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
<h2>Administrator List</h2>

<form name="admin_list_form">
    <div id="buttons">
    <input type="button" onclick="mod()" value="modify" class="button"> <input type="button" onclick="del()" value="delete" class="button">
    </div>

    <table border="1" id="list">

        <div id="row_header2">
        <tr>
            <th>ID</th>
            <th>Password</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Email</th>
            <th>Buy/Sell</th>
        </tr>
        </div>

        <%
            try{
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
                System.out.println("Connected with mySQL!");
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM new_schema.user");

                while(rs.next()) {
        %>
        <tr>
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(2)%></td>
            <td><%=rs.getString(3)%></td>
            <td><%=rs.getString(4)%></td>
            <td><%=rs.getString(5)%></td>
            <td><%=rs.getString(6)%></td>
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
</form>
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