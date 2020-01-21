<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>

<%
    try{
        String name = request.getParameter("name");

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
        System.out.println("Connected with mySQL!");
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM new_schema.product WHERE product='"+name+"' ");

        String price = request.getParameter("bidPrice");

        if(rs.getString(8) == null) {
            int i = st.executeUpdate("UPDATE new_schema.product SET history='"+price+"' ");
        }

        else if(rs.getString(9) == null) {
            int i = st.executeUpdate("UPDATE new_schema.product SET history2='"+price+"' ");
        }

        else if(rs.getString(10) == null) {
            int i = st.executeUpdate("UPDATE new_schema.product SET history3='"+price+"' ");
        }

        else {
            int i = st.executeUpdate("UPDATE new_schema.product SET history='"+price+"' ");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>