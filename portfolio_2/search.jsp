<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8" import="java.sql.*"%>
<%request.setCharacterEncoding("EUC-KR"); %>
    <%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String url = "jdbc:mysql://localhost:3306/new_schema?useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";
	
	int num = 0;
	int price = 0;
	String name = "";
	String picture ="";
	int auction = 0;
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
        <title>navigation/footer</title>
        <link rel="stylesheet" href="navi_footer.css">
        <link rel="stylesheet" href="search.css">
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
        <%
            try{
            	if(request.getParameter("name").equals("")){
            		%>
            		<h1>검색어를 입력해주세요.</h1>
            		<%
            	}
            	else{
            		String priceFrom = request.getParameter("priceFrom");
            		String priceTo = request.getParameter("priceTo");
            		String select =request.getParameter("search_select");
            		String nameofsearch = request.getParameter("name"); 
            		conn = DriverManager.getConnection(url, "root", "dnjs0306");
            		String sqlstring="";
            		PreparedStatement ps=null;
            		
            		if(priceFrom.equals("") && priceTo.equals("") && select.equals("productName")){ //가격 설정 x 상품명
            			sqlstring = "SELECT * FROM product WHERE product LIKE ?";
                		ps = conn.prepareStatement(sqlstring);
                		ps.setString(1,"%"+nameofsearch+"%");
                		System.out.println(nameofsearch);
            		}
            		else if(!priceFrom.equals("") && priceTo.equals("") && select.equals("productName")){ //from만 가격설정 상품명
            			int from = Integer.parseInt(priceFrom);
            			sqlstring = "SELECT * FROM product WHERE product LIKE ? AND price >= ?";
                		ps = conn.prepareStatement(sqlstring);
                		ps.setString(1,"%"+nameofsearch+"%");
                		ps.setInt(2,from);
            		}
            		else if(priceFrom.equals("") && !priceTo.equals("") && select.equals("productName")){ //to만 가격설정 상품명
            			int to = Integer.parseInt(priceTo);
            			sqlstring = "SELECT * FROM product WHERE product LIKE ? AND price <= ?";
                		ps = conn.prepareStatement(sqlstring);
                		ps.setString(1,"%"+nameofsearch+"%");
                		ps.setInt(2,to);
            		}
            		else if(!priceFrom.equals("") && !priceTo.equals("") && select.equals("productName")){//모두 가격설정 상품명
            			int from = Integer.parseInt(priceFrom);
            			int to = Integer.parseInt(priceTo);
            			sqlstring = "SELECT * FROM product WHERE product LIKE ? AND price >= ? AND price <= ?";
                		ps = conn.prepareStatement(sqlstring);
                		ps.setString(1,"%"+nameofsearch+"%");
                		ps.setInt(2,from);
                		ps.setInt(3,to);
            		}
            		else if(priceFrom.equals("") && priceTo.equals("") && select.equals("sellerName")){//가격 설정 x 판매자
            			sqlstring = "SELECT * FROM product WHERE seller LIKE ?";
                		ps = conn.prepareStatement(sqlstring);
                		ps.setString(1,"%"+nameofsearch+"%");
            		}
            		else if(!priceFrom.equals("") && priceTo.equals("") && select.equals("sellerName")){//from만 가격설정 판매자
            			int from = Integer.parseInt(priceFrom);
            			sqlstring = "SELECT * FROM product WHERE seller LIKE ? AND price >= ?";
                		ps = conn.prepareStatement(sqlstring);
                		ps.setString(1,"%"+nameofsearch+"%");
                		ps.setInt(2,from);
            		}
            		else if(priceFrom.equals("") && !priceTo.equals("") && select.equals("sellerName")){//to만 가격설정 판매자
            			int to = Integer.parseInt(priceTo);
            			sqlstring = "SELECT * FROM product WHERE seller LIKE ? AND price <= ?";
                		ps = conn.prepareStatement(sqlstring);
                		ps.setString(1,"%"+nameofsearch+"%");
                		ps.setInt(2,to);
            		}
            		else if(!priceFrom.equals("") && !priceTo.equals("") && select.equals("sellerName")){//모두 가격설정 판매자
            			int from = Integer.parseInt(priceFrom);
            			int to = Integer.parseInt(priceTo);
            			sqlstring = "SELECT * FROM product WHERE seller LIKE ? AND price >= ? AND price <= ?";
                		ps = conn.prepareStatement(sqlstring);
                		ps.setString(1,"%"+nameofsearch+"%");
                		ps.setInt(2,from);
                		ps.setInt(3,to);
            		}
            		rs = ps.executeQuery();
            		 %>
                     <div class="recommended">
                         <h2 style="color:orange;">검색 결과</h2>
                         <div class="items">
                         	<%
                                 if(rs!=null){
                                 	while(rs.next()){
                                 		num++;
                                 		price = Integer.parseInt(rs.getString("price"));
                                 		name = rs.getString("product");
                                 		picture = rs.getString("picture");
                                 		auction = Integer.parseInt(rs.getString("auction"));
                                 		
                                 		if(auction==0){
                                 			%>
                                             <div>
                                                 <a href="product_page_buyer.jsp?id=<%=request.getParameter("id")%>&productName=<%=name%>">
                                                     <img class='img' src="<%=picture %>" alt="">
                                                     <p class="name"><%=name %></p>
                                                 </a>
                                                 <p class="price"><%=price %> 원</p>
                                             </div>
                                             <%
                                 		}
                                 		else{
                                 			%>
                                             <div>
                                                 <a href="product_page_buyer_auction.jsp?id=<%=request.getParameter("id")%>&productName=<%=name%>">
                                                     <img class='img' src="<%=picture %>" alt="">
                                                     <p class="name"><%=name %></p>
                                                 </a>
                                                 <p class="price"><%=price %> 원</p>
                                             </div>
                                             <%
                                 		}
                              
         	                       }
         	                    }
                              %>
                         </div>
                     </div>	
                     </div>
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