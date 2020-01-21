<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="navi_footer.css">
        <link href="css/font-awesome.min.css" rel="stylesheet">
    </head>

    <body>

    <%
        String type = request.getParameter("type");

        if(type.equals("buy")) {

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC", "root", "dnjs0306");
            System.out.println("Connected with mySQL!");
            Statement st2 = conn2.createStatement();
            String sold = "sold";
            String name = request.getParameter("productName");

            int i = st2.executeUpdate("UPDATE new_schema.product SET status='" + sold + "' WHERE product='" + name + "' ");

        }
        else {
            String name2 = request.getParameter("productName");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn3 = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
            System.out.println("Connected with mySQL!");
            Statement st3 = conn3.createStatement();
            ResultSet rs2 = st3.executeQuery("SELECT * FROM new_schema.product WHERE product='"+name2+"' ");

            String wishperson = null;
            String productName2 = null;
            String price = null;
            String auction = null;
            String userName = request.getParameter("id");
            if(rs2.next()) {
            wishperson = rs2.getString(7);
                productName2 = rs2.getString(1);
                price = rs2.getString(2);
                auction = rs2.getString(12);
            }
            int num = Integer.parseInt(wishperson);
            num++;
            wishperson = String.valueOf(num);

            int j = st3.executeUpdate("UPDATE new_schema.product SET wishperson='"+wishperson+"' WHERE product='"+name2+"' ");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn4 = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
            System.out.println("Connected with mySQL!");
            Statement st4 = conn4.createStatement();

            int k = st4.executeUpdate("INSERT INTO new_schema.wishlist(productName, userName, price, auction)VALUES('"+productName2+"', '"+userName+"', '"+price+"', '"+auction+"')");
            }
    %>
    <script>
        alert("완료했습니다.");
    </script>
    </body>
</html>