<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="java.sql.*"%>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String url = "jdbc:mysql://localhost:3306/new_schema?useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";
	
	int num = 0;
	int price = 0;
	String name = "";
	String userId ="";
	int totalPrice = 0;
	int auction = 0;
	
	if(request.getParameter("id") != null){
		userId = request.getParameter("id");
	}
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
        <title>navigation/footer</title>
        <link rel="stylesheet" href="navi_footer.css">
        <link rel="stylesheet" href="wishlist.css">
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
        		conn = DriverManager.getConnection(url, "root", "dnjs0306");
        		String sqlstring = "SELECT * FROM user WHERE userName = ?";
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
		
		<%
		try{
			conn = DriverManager.getConnection(url, "root", "dnjs0306");
			String sqlstring = "SELECT * FROM wishlist WHERE userName = ?";
			PreparedStatement ps = conn.prepareStatement(sqlstring);
			ps.setString(1,userId);
			rs = ps.executeQuery();
		%>
		<form name="wishlist" method="post" action="wishAction.jsp?id=<%=request.getParameter("id")%>">
        <div class="main">
            <div class="title">
                <h1>WISHLIST</h1>
                <img src="wish.png" alt="">
            </div>
			
			
            <div class="main_box">
                <ul>
                    <div class="main_meta">
                        <p class="choose"><b>선택</b></p>
                        <p class="num"><b>#</b></p>
                        <p class="name"><b>상품명</b></p>
                        <p class="price"><b>가격</b></p>
                        
                    </div>
                    
                    <%
                        if(rs!=null){
                        	while(rs.next()){
                        		num++;
                        		price = Integer.parseInt(rs.getString("price"));
                        		name = rs.getString("productName");
                        		totalPrice+=price;
                        		auction = Integer.parseInt(rs.getString("auction"));
                        		
                        		if(auction==0){
                     %>
                     <li>

                     	<a href="product_page_buyer.jsp?id=<%=request.getParameter("id")%>&productName=<%=name%>">
                            <div><input class="choose" type="checkbox" name="productName" value="<%=name%>" id="<%=name%>" onclick="totalPrice(<%=price%>,'<%=name%>');"></div>
                            <p class="num"><%=num%></p>
                            <p class="name" name="name"><%=name%></p>
                            <p class="price"><%=price%></p>
                     	</a>
                     </li>
                     <%
                        		}
                        		else{
                        			%>
                        			<li>
                     	<a href="product_page_buyer_auction.jsp?id=<%=request.getParameter("id")%>&productName=<%=name%>">
                     		<div><input class="choose" type="checkbox" name="productName" value="<%=name%>" id="<%=name%>" onclick="totalPrice(<%=price%>,'<%=name%>');"></div>
                            <p class="num"><%=num%></p>
                            <p class="name" name="name"><%=name%></p>
                            <p class="price"><%=price%></p>
                     	</a>
                     </li>
                        			<%
                        		}
	                       }
	                    }
                     %>
                </ul>
            </div>
            <br>
            <button type="submit" name="action" value="delete" id="delete">삭제</button>
            <button type="submit" name="action" value="purchase" id="add_to_cart">구매</button>
            <p id='totalPrice'></p>
        </div>
        </form>
        
        <%
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
        <script type="text/javascript">
        let tp = 0;
        function totalPrice(price,product='') {
	        var check = document.getElementById(product).checked;
	
	    	if(check){
	    		tp+=price;
	        	
	    	}
	    	else{
	    		tp-=price;
	    	}
	        	document.getElementById('totalPrice').innerHTML = "선택한 상품 총 가격:\ " + tp +"원";
        }
        </script>
</body>
</html>