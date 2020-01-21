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
        ResultSet rs = st.executeQuery("SELECT * FROM new_schema.user");

        String id = request.getParameter("id");
        int num = 0;

        while(rs.next()) {
            String userid = rs.getString(1);

            if(id.equals(userid)) {
                num = 1;
                break;
            }
        }

        if(num == 1) {
            out.println("<script>alert('중복된 아이디 입니다.');history.back();</script>");
        }

        else {
            out.println("<script>alert('사용 가능한 아이디 입니다.');history.back();</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>