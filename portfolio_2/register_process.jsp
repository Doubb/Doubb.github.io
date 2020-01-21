<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import = "java.security.MessageDigest"%>
<%@ page import = "java.security.NoSuchAlgorithmException"%>
<%!
    public String testMD5(String str){

        String MD5 = "";

        try{
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(str.getBytes());
            byte byteData[] = md.digest();
            StringBuffer sb = new StringBuffer();
            for(int i = 0 ; i < byteData.length ; i++){
                sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
            }
            MD5 = sb.toString();
        }catch(NoSuchAlgorithmException e){
            e.printStackTrace();
            MD5 = null;
        }
        return MD5;
    }
%>
<%
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306?serverTimezone=UTC","root","dnjs0306");
        System.out.println("Connected with mySQL!");
        Statement st = conn.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM new_schema.user");
        int num = 0;

        String id = request.getParameter("id");
        String pw = testMD5(request.getParameter("pw"));
        String last = request.getParameter("last");
        String first = request.getParameter("first");
        String email = request.getParameter("email");
        String people = request.getParameter("people");

        if(people.equals("1")) {
            people = "Buyer";
        }

        else if(people.equals("2")) {
            people = "Seller";
        }

        String redirectUrl = "index.jsp?id=" + id;

        while(rs.next()) {
            String userid=rs.getString(1);
            String mail=rs.getString(5);

            if(id.equals(userid) || email.equals(mail)) {
                num = 1;
                break;


            }
        }

        if(num == 1) {
            redirectUrl = "login.jsp?error=register failed..";
            response.sendRedirect(redirectUrl);

        }

        else {
            int i = st.executeUpdate("INSERT INTO new_schema.user(username, password, first_name, last_name, email, people,numOfTry)values('"+id+"','"+pw+"','"+first+"','"+last+"','"+email+"', '"+people+"',0)");
            response.sendRedirect(redirectUrl);

        }

    } catch (Exception e) {
        e.printStackTrace();
    }
%>
