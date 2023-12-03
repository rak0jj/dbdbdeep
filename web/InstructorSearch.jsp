<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Instructor Search Page</title>
</head>
<h2>강사 정보 조회하기</h2>
<form action="InstructorSearch.jsp" method="post">
    <input type="text" id="sport" name="sport" placeholder="종목">
    <input type="text" id="salaries" name="salaries" placeholder="월급">
    <input type="submit" value="검색">
</form>
<ul>
    <body>
    <%
        request.setCharacterEncoding("UTF-8");
        String URL = "jdbc:oracle:thin:@localhost:1521:xe"; //mac : xe
        String USER = "dbdbdeep";
        String PASSWORD = "comp322";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "SELECT instructor_id, name, phone_number, salary FROM INSTRUCTOR WHERE sports=? and salary=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, request.getParameter("sport"));
            pstmt.setString(2, request.getParameter("salaries"));
            rs = pstmt.executeQuery();
            int list_number = 0;
    %>

    <table border="1">
        <h2>강사 정보</h2>
        <tr>
            <th></th>
            <th>강사 ID</th>
            <th>이름</th>
            <th>연락처</th>
            <th>월급</th>
        </tr>
        <%
            while (rs.next()) {
                list_number++;
        %>
        <tr>
            <td><%=list_number%>
            </td>
            <td><%= rs.getString(1) %>
            </td>
            <td><%= rs.getString(2) %>
            </td>
            <td><%= rs.getString(3) %>
            </td>
            <td><%= rs.getString(4) %>원
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (rs != null) try {
                    rs.close();
                } catch (Exception e) {
                }
                if (pstmt != null) try {
                    pstmt.close();
                } catch (Exception e) {
                }
                if (conn != null) try {
                    conn.close();
                } catch (Exception e) {
                }
            }
        %>
    </table>
    </body>
</ul>
</html>
