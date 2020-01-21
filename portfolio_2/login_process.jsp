<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import ="javax.sql.*" %>
<%@ page import="java.lang.*" %>
<%@ page import = "java.security.MessageDigest"%>
<%@ page import = "java.security.NoSuchAlgorithmException"%>
<%request.setCharacterEncoding("EUC-KR"); %>
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
        ResultSet rs = st.executeQuery("SELECT username, password, numOfTry FROM new_schema.user");

        String id = request.getParameter("id");
        String pw = testMD5(request.getParameter("pw"));

        String redirectUrl = "login.jsp?error=login-failed..";

        while(rs.next()) {
            String userid=rs.getString(1);
            String passwrd=rs.getString(2);

            String sqlstring = "UPDATE new_schema.user SET numOfTry = ? WHERE username = ?";
            PreparedStatement ps = conn.prepareStatement(sqlstring);

            if(rs.getInt("numOfTry") >=5 ){
                redirectUrl = "login.jsp?error=You typed the wrong password more than 5 times. Contact the Admin.";
            }
            else if(id.equals(userid) && pw.equals(passwrd)) {
                ps.setInt(1,0);
                ps.setString(2,userid);
                ps.executeUpdate();
                redirectUrl = "index.jsp?id=" + id;
            }
            else if(id.equals(userid) && !pw.equals(passwrd)){
                int numOfTry = rs.getInt("numOfTry");
                numOfTry++;
                ps.setInt(1,numOfTry);
                ps.setString(2,userid);
                ps.executeUpdate();
            }
        }
        response.sendRedirect(redirectUrl);
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
