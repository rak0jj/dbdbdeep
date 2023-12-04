<%--
  Created by IntelliJ IDEA.
  UserRepository.User: jfkrd
  Date: 2023-12-03
  Time: 오후 2:14
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*" %>
<%@page import="java.text.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        .back-button {
            display: inline-block;
            justify-content: center;
            padding: 8px;
            background-color: #F3B234;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 12px;
        }

        .back-button:hover {
            background-color: #F3B234;
        }
    </style>
    <title>Title</title>
</head>
<body>
<a href="MatchPage.jsp" class="back-button">뒤로가기</a><br/>
<%
    request.setCharacterEncoding("UTF-8");

    String sports = request.getParameter("sports");
    String month = request.getParameter("month");
    String URL = "jdbc:oracle:thin:@localhost:1521:xe"; //mac : xe
    String USER = "dbdbdeep";
    String PASSWORD = "comp322";

    Connection conn = null;
    PreparedStatement pstmt;
    ResultSet rs;
    String sql = "SELECT game_id, win_team, lose_team\r\n"
            + "FROM GAME\r\n"
            + "WHERE sports = ? and to_date(game_date) LIKE ?";
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");

        conn = DriverManager.getConnection(URL, USER, PASSWORD);

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, sports);
        pstmt.setString(2, "23/" + month + "%");

        rs = pstmt.executeQuery();
        out.println("<table border=\"1\">");
        ResultSetMetaData rsmd = rs.getMetaData();
        int cnt = rsmd.getColumnCount();
        for (int i = 1; i <= cnt; i++) {
            out.println("<th>" + rsmd.getColumnName(i) + "</th>");
        }
        while (rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString(1) + "</td>");
            out.println("<td>" + rs.getString(2) + "</td>");
            out.println("<td>" + rs.getString(3) + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");

        conn.close();
        pstmt.close();
        rs.close();
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("matchMonthlyInfo.html");
    }
%>
</body>
</html>
