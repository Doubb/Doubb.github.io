<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="utf-8" import="java.sql.*"%>
<%request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
String url = "jdbc:mysql://localhost:3306/new_schema?useUnicode=true&characterEncoding=EUC-KR&serverTimezone=UTC";
try{
	String[] values = request.getParameterValues("productName");
	conn = DriverManager.getConnection(url, "root", "dnjs0306");
	String sqlstring = "DELETE FROM wishlist WHERE productName = ?";
	PreparedStatement ps = conn.prepareStatement(sqlstring);
	
	if(request.getParameter("action").equals("delete")){
	    if(values != null){
	        for(int i=0; i<values.length; i++){
	        	ps.setString(1,values[i]);
	        	ps.executeUpdate();
	        }
	    }
	}
	else if(request.getParameter("action").equals("purchase")){
		
		String sql = "UPDATE product SET status = 'sold' WHERE product = ?";
		if(values != null){
	        for(int i=0; i<values.length; i++){
	        	ps.setString(1,values[i]);
	        	ps.executeUpdate();
	        	
	        	String name = request.getParameter("name");
	        	PreparedStatement ps2 = conn.prepareStatement(sql);
	        	ps2.setString(1,name);
	        	ps2.executeUpdate();
	        }
	    }
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
<script>
	location.href="wishlist.jsp?id=<%=request.getParameter("id")%>"
</script>
</body>
</html>