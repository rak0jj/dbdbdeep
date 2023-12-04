<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Instructor Page</title>
</head>
<h1>강사 페이지</h1>
<body>
<%
    request.setCharacterEncoding("UTF-8");
    // DB연결에 필요한 변수 선언
    String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
    String USER = "dbdbdeep";
    String PASSWORD = "comp322";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(URL, USER, PASSWORD);
        String sql = "SELECT i.Name AS InstructorName, t.Team_id AS TeamID\r\n FROM instructor i, teach te, team t\r\n WHERE i.Instructor_id = te.Tinstructor_id AND te.Tteam_id = t.Team_id";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        int list_number=0;
%>
<table border="1">
    <h3>강의 중인 강사</h3>
    <a href="InstructorSearch.jsp">강사 검색하기</a><br/>
    <tr>
        <th></th>
        <th>강사명</th>
        <th>맡은 팀 ID</th>
    </tr>
    <%
        while (rs.next()) {
            list_number++;
    %>
    <tr>
        <td><%= list_number %></td>
        <td><%= rs.getString(1) %>
        </td>
        <td><%= rs.getString(2) %>
        </td>
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
    <button onclick="location.href='MainPage.jsp'">메인 페이지</button>
</table>
</body>
</html>