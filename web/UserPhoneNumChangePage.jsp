<%--
  Created by IntelliJ IDEA.
  User: jfkrd
  Date: 2023-12-04
  Time: 오전 2:30
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.regex.Pattern" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>연락처 변경</title>
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
        String phone_number = request.getParameter("phone_number");
        String phoneNumberRegex = "\\d{3}-\\d{4}-\\d{4}";
        if (!Pattern.matches(phoneNumberRegex, phone_number)) {
            response.sendRedirect("UserPhoneNumChangePage.html");
        } else {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            conn.setAutoCommit(false);
            String sql = "UPDATE userp SET phone_number = ? WHERE user_id = ?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, phone_number);
            pstmt.setString(2, user_id);
            pstmt.executeUpdate();
            conn.commit();
            response.sendRedirect("UserInfoChangePage.jsp");

            conn.close();
            pstmt.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
</body>
</html>
