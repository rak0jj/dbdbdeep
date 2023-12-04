<%--
  Created by IntelliJ IDEA.
  UserRepository.User: jfkrd
  Date: 2023-12-03
  Time: 오후 4:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<html>
<head>
    <title>teamSearchPage</title>
    <h1>소속팀 검색 페이지</h1>
    <button onclick="location.href='TeamPage.jsp'">메인 페이지</button>
    <h4>내 소속 팀</h4>
</head>
<ul>
    <body>
    <%
        request.setCharacterEncoding("UTF-8");
        // DB연결에 필요한 변수 선언
        String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
        String USER = "dbdbdeep";
        String PASSWORD = "comp322";

        Connection conn = null;
        PreparedStatement pstmt=null;
        ResultSet rs=null;

        try {
            String name = (String) session.getAttribute("user_name");
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "SELECT U.name, T.team_id, T.sports, T.captain_id\r\n"
                    + "FROM UserP U, team T, participate P\r\n"
                    + "WHERE U.user_id = P.puser_id AND P.pteam_id = T.team_id AND U.name = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();
    %>
    <table border="1">
        <tr>
            <th>사용자 이름</th>
            <th>팀 id</th>
            <th>종목</th>
            <th>주장 id</th>
        </tr>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString(1) %></td>
            <td><%= rs.getString(2) %></td>
            <td><%= rs.getString(3) %></td>
            <td><%= rs.getString(4) %></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try { rs.close(); } catch(Exception e) {}
                if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
                if (conn != null) try { conn.close(); } catch(Exception e) {}
            }
        %>
    </table>
    </body>
</ul>
</html>
