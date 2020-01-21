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

        String productName = request.getParameter("productName");
        String productPrice = request.getParameter("productPrice");
        String sellerName = request.getParameter("sellerName");
        String phoneNumber = request.getParameter("phoneNumber");
        String tradePlace = request.getParameter("tradePlace");
        String type = request.getParameter("productType");
        String image = request.getParameter("image");

        int auction = 0;
        int wishperson = 0;
        String status = "not sold";

        if(type.equals("auction")) {
            auction = 1;
            status = "auction";
        }

        int i = st.executeUpdate("INSERT INTO new_schema.product(product, price, place, phone, seller, picture, auction, wishperson, status)VALUES('"+productName+"', '"+productPrice+"', '"+tradePlace+"', '"+phoneNumber+"', '"+sellerName+"', '"+image+"', '"+auction+"', '"+wishperson+"', '"+status+"' )");

        %>
        <script>
            alert("상품이 등록되었습니다.");
        </script>
<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>