<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.lang.System.*" %>

<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
        System.out.println("Connected with mySQL!");
        Statement st = conn.createStatement();
        PreparedStatement pst = null;
        ResultSet rs = st.executeQuery("SELECT * FROM new_schema.user");

        String i = request.getParameter("del");
        int num = Integer.parseInt(i);
        String str = null;
        System.out.println(num);

        for(int j=0; j<num; j++) {
            if(rs.next()) {
                str = rs.getString(1);
            }
        }
        if(rs.next()) {
            str = rs.getString(1);
        }
        System.out.println(str);

        pst = conn.prepareStatement("DELETE FROM new_schema.user WHERE username=?");
        pst.setString(1, str);
        pst.executeUpdate();
        %>
<script>
    alert("삭제했습니다");
</script>
<%

    } catch (Exception e) {
        e.printStackTrace();
    }
%>