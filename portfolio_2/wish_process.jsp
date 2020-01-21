<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>

<%
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
        System.out.println("Connected with mySQL!");
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM new_schema.wishlist");

        String id = request.getParameter("id");
        String productName = request.getParameter("name");
        String price = request.getParameter("price");

        int i = st.executeUpdate("INSERT INTO new_schema.wishlist(productName, userName, price)values('"+productName+"', '"+id+"', '"+price+"')");
        %>
        <script>
            alert("위시리스트에 추가되었습니다.");
        </script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>