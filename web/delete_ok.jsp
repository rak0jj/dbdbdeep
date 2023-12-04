<%--
  Created by IntelliJ IDEA.
  User: jfkrd
  Date: 2023-12-04
  Time: 오전 6:21
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원 탈퇴</title>
</head>
<body>
<%
        request.setCharacterEncoding("UTF-8");
        String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
        String USER = "dbdbdeep";
        String PASSWORD = "comp322";

        Connection conn = null;
        PreparedStatement pstmt = null;

    try {
        String user_id = (String) session.getAttribute("user_id");
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(URL, USER, PASSWORD);
        conn.setAutoCommit(false);
        String sql = "DELETE FROM userp WHERE user_id = ?";

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, user_id);
        pstmt.executeUpdate();
        conn.commit();

        session.invalidate();
        response.sendRedirect("LoginPage.jsp");
        conn.close();
        pstmt.close();
    } catch (SQLException e) {
    e.printStackTrace();
    }
%>
<a href="MatchPage.jsp">뒤로가기</a><br/>
</body>
</html>
