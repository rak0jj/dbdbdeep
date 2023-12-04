<%--
  Created by IntelliJ IDEA.
  User: jfkrd
  Date: 2023-12-04
  Time: 오전 12:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그아웃</title>
</head>
<body>
<%
    // 해당 session을 날려버림
    System.out.println(session.getAttribute("user_id"));
    session.invalidate();
    //다시 login.jsp 페이지로 응답
    response.sendRedirect("LoginPage.jsp");
%>

</body>
</html>
