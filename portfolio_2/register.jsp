<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = null;
    ResultSet rs = null;
    Statement stmt = null;
    String url = "jdbc:mysql://localhost:3306/new_schema?useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <link rel="stylesheet" href="register.css">
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="navi_footer.css">
    <link href="css/font-awesome.min.css" rel="stylesheet">

    <style>
        #lower {
            margin-bottom: 200px;
        }
    </style>
</head>

<script>
    function test() {
        let ff = document.form1;

        let url = "duplicate_check.jsp?id=" + ff.id.value;
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
                <a href="index.jsp" id="skku_logo"><img src="skku_logo.jpg" alt="home"></a>
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
                            String userId = request.getParameter("id");
                            String people ="";
                            conn = DriverManager.getConnection(url, "root", "dnjs0306");
                            String sqlstring = "SELECT * FROM user WHERE username = ?";
                            PreparedStatement ps = conn.prepareStatement(sqlstring);
                            ps.setString(1,userId);
                            rs = ps.executeQuery();


                            if(rs!=null){
                                while(rs.next()){
                                    people = rs.getString("people");
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
                            if(rs!=null)
                                try {rs.close();}
                                catch (SQLException ex) {}
                            if(stmt!=null)
                                try {stmt.close();}
                                catch (SQLException ex) {}
                            if(conn!=null)
                                try {conn.close();}
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

<div class="main">
    <% if (request.getParameter("error") == null) { %>
    <h1>Please sign up..</h1>
    <% } else { %>
    <h1><%= request.getParameter("error") %></h1>
    <% } %>

    <form action="register_process.jsp" method="post" name="form1">
        <label>ID</label>
        <input class="space1" name="id" type="text" pattern="[a-z]{1,15}" title="ID should only contain lowercase letters.">
        <input class="button" type="button" onclick="test()" value="duplicate"> <br><br>

        <label>Password</label>
        <input class="space2" name="pw" type="password" pattern="[0-9]{4,15}" title="Password should only contain numbers at least 4 characters."><br><br>

        <label>Last name</label>
        <input class="space3" name="last" type="text" pattern="[A-z]{1,15}" title="Last name should only contain letters."> <br><br>

        <label>First name</label>
        <input class="space4" name="first" type="text" pattern="[A-z]{1,15}" title="First name should only contain letters."> <br><br>

        <label>Email</label>
        <input class="space5" name="email" type="email"> <br><br>

        <div id="lower">
            <label>Buyer</label>
            <input name="people" type="checkbox" value="1"> <br><br>

            <label>Seller</label>
            <input name="people" type="checkbox" value="2"> <br><br>

            <input class="button" type="submit" value="가입">
        </div>
    </form>
</div>

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