<%--
  Created by IntelliJ IDEA.
  User: seakim
  Date: 12/2/23
  Time: 9:04 PM
  To change this template use File | Settings | File Templates.
--%>

<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Place Page</title>
</head>
<h1>구장 페이지</h1>
<form action="PlacePage.jsp" method="post">
    <label for="place">지역 검색</label>
    <input type="text" id="place" name="place">
    <input type="submit" value="검색">
</form>
<button onclick="location.href='MainPage.jsp'">메인 페이지</button>
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
        String sql = "SELECT Place_id, Location, Sports, Price_per_time FROM place WHERE Location LIKE ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, request.getParameter("place") + "%");
        rs = pstmt.executeQuery();
        %>
        <table border="1">
            <tr>
                <th>구장 ID</th>
                <th>지역</th>
                <th>스포츠</th>
                <th>시간 당 비용</th>
            </tr>
            <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString(1) %></td>
            <td><%= rs.getString(2).substring(0, 2) %></td>
            <td><%= rs.getString(3) %></td>
            <td><%= rs.getString(4) %>원</td>
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