<%--
  Created by IntelliJ IDEA.
  UserRepository.User: seakim
  Date: 12/2/23
  Time: 9:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<html>
<head>
    <title>UserPage</title>
    <h1>유저 정보 검색 페이지</h1>
    <form action="UserPage.jsp" method="post">
        <h3>검색을 원하는 사용자 이름 입력</h3></br>
        <input type="text" id="name" name="name" placeholder="이름">
        <input type="submit" value="검색">
    </form>
    <button onclick="location.href='MainPage.jsp'">메인 페이지</button>
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
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "SELECT user_id, sex, age, height, phone_number\r\n"
                    + "FROM UserP \r\n"
                    + "WHERE name = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, request.getParameter("name"));
            rs = pstmt.executeQuery();
    %>
    <table border="1">
        <tr>
            <th>사용자 ID</th>
            <th>성별</th>
            <th>나이</th>
            <th>신장</th>
            <th>연락처</th>
        </tr>
        <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString(1) %></td>
            <td><%= (rs.getString(2)=="M"? "남자":"여자") %></td>
            <td><%= rs.getInt(3) %>살</td>
            <td><%= rs.getInt(4) %>cm</td>
            <td><%= rs.getString(5) %></td>
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
