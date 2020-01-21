<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>

<%
    try{
        String name = request.getParameter("id");
        String productName = request.getParameter("productName");

        String type = request.getParameter("type");

        if(type.equals("bid")) {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC", "root", "dnjs0306");
            System.out.println("Connected with mySQL!");
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM new_schema.product WHERE product='" + productName + "' ");

            String price = request.getParameter("bidPrice");
            price = name + ":" + price;

            if (rs.next()) {
                if (rs.getString(8) == null) {
                    int i = st.executeUpdate("UPDATE new_schema.product SET history='" + price + "' WHERE product='" + productName + "' ");
                    int j = st.executeUpdate("UPDATE new_schema.product SET price='" + price + "' WHERE product='" + productName + "' ");
                } else if (rs.getString(9) == null) {
                    int i = st.executeUpdate("UPDATE new_schema.product SET history2='" + price + "' WHERE product='" + productName + "'");
                    int j = st.executeUpdate("UPDATE new_schema.product SET price='" + price + "' WHERE product='" + productName + "' ");
                } else if (rs.getString(10) == null) {
                    int i = st.executeUpdate("UPDATE new_schema.product SET history3='" + price + "' WHERE product='" + productName + "'");
                    int j = st.executeUpdate("UPDATE new_schema.product SET price='" + price + "' WHERE product='" + productName + "' ");
                } else {
                    int i = st.executeUpdate("UPDATE new_schema.product SET history='" + price + "' WHERE product='" + productName + "'");
                    int j = st.executeUpdate("UPDATE new_schema.product SET price='" + price + "' WHERE product='" + productName + "' ");
                }
            }
        }

        else {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn3 = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
            System.out.println("Connected with mySQL!");
            Statement st3 = conn3.createStatement();
            ResultSet rs2 = st3.executeQuery("SELECT * FROM new_schema.product WHERE product='"+productName+"' ");

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

            int j = st3.executeUpdate("UPDATE new_schema.product SET wishperson='"+wishperson+"' WHERE product='"+productName2+"' ");

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn4 = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
            System.out.println("Connected with mySQL!");
            Statement st4 = conn4.createStatement();

            int k = st4.executeUpdate("INSERT INTO new_schema.wishlist(productName, userName, price, auction)VALUES('"+productName2+"', '"+userName+"', '"+price+"', '"+auction+"')");
        }
        %>
<script>
    alert("완료했습니다");
</script>
        <%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>