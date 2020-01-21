<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.lang.System.*" %>

<%
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
        System.out.println("Connected with mySQL!");
        Statement st = conn.createStatement();

        for(int j=0; j<10; j++) {
            String id_origin = "id";
            String pw_origin = "pw";
            String first_origin = "first";
            String last_origin = "last";
            String email_origin = "email";
            String bs_origin = "bs";

            id_origin += Integer.toString(j);
            pw_origin += Integer.toString(j);
            first_origin += Integer.toString(j);
            last_origin += Integer.toString(j);
            email_origin += Integer.toString(j);
            bs_origin += Integer.toString(j);

            String id = request.getParameter(id_origin);
            String pw = request.getParameter(pw_origin);
            String first = request.getParameter(first_origin);
            String last = request.getParameter(last_origin);
            String email = request.getParameter(email_origin);
            String bs = request.getParameter(bs_origin);

            int i = st.executeUpdate("UPDATE new_schema.user SET username='" + id + "', password='" + pw + "', first_name='" + first + "', last_name='" + last + "', email='" + email + "', people='" + bs + "' WHERE email='" + email + "' ");
        }
        %>
<script>
    alert("수정했습니다");
</script>
<%

    } catch (Exception e) {
        e.printStackTrace();
    }
%>