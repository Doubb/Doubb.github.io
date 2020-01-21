<%--
  Created by IntelliJ IDEA.
  User: doube
  Date: 2019-11-25
  Time: 오전 10:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  Hello world!

  <% double num = Math.random();
    if(num >= 0.95) {
  %>
  <h2>You are lucky</h2>
  <p>Your number is <%=num%></p>

  <%
    } else {
  %>

  <h2>You are the best</h2>
  <p>Your number is <%=num%></p>
  <%
    }
  %>

  <a href="<%=request.getRequestURL()%>">Try Again</a>
  </body>
</html>
