<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>

<%
    try{
        System.out.println("buy");
        String name = request.getParameter("id");
        System.out.println(name);
        String sold = "sold";
        String str = "UPDATE new_schema.product SET status=? WHERE product=?";
        String redirectUrl = "index.jsp?error=login-failed..";

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
        System.out.println("Connected with mySQL!");
        PreparedStatement st = conn.prepareStatement(str);
        st.setString(1,sold);
        st.setString(2,name);

        int i = st.executeUpdate();

%>
<script>
    alert("구매했습니다.");
</script>
<%
        //String redirectURL = "product_page_buyer.jsp";
        //response.sendRedirect(redirectURL);

    } catch (Exception e) {
        e.printStackTrace();
    }
%>