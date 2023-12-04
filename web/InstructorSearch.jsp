<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <style>
        .main-button {
            display: inline-block;
            justify-content: center;
            padding: 8px;
            background-color: #3A3D92;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 12px;
        }

        .main-button:hover {
            background-color: #3A3D92;
        }

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
    <title>Instructor Search Page</title>
</head>
<a href="MainPage.jsp" class="main-button">메인 페이지</a>
<a href="InstructorPage.jsp" class="back-button">뒤로가기</a>
<h1>강사 정보 조회하기</h1>
<form action="InstructorSearch.jsp" method="post">
    <input type="text" id="sport" name="sport" placeholder="종목">
    <input type="text" id="salaries" name="salaries" placeholder="월급">
    <input type="submit" value="검색">
</form>
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
    <a>강사 정보</a>
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
</html>