<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>

<%
    try{
        String id = request.getParameter("id");

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
        System.out.println("Connected with mySQL!");
        Statement st = conn.createStatement();

        String str = "sold";

        int k = st.executeUpdate("UPDATE new_schema.product SET status='"+str+"' WHERE seller='"+id+"' AND auction=1 ");
        int j = st.executeUpdate("UPDATE new_schema.product SET auction=0 WHERE seller='"+id+"' AND auction=1 ");

        %>
<script>
    alert("마감되었습니다.");
</script>
<%


    } catch (Exception e) {
        e.printStackTrace();
    }
%>