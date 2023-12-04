<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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

        .content-button-style {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px;
            background-color: #3A3D92;
            color: #FFFFFF;
            text-decoration: none;
            border-radius: 5px;
            border: 2px solid #3A3D92;
        }

        .content-button-style:hover {
            background-color: #FFFFFF;
            color: #3A3D92;
        }
    </style>
    <title>Instructor Page</title>
</head>
<a href="MainPage.jsp" class="back-button">뒤로가기</a><br/>
<h1>강사 페이지</h1>
<a href="InstructorSearch.jsp" class="content-button-style">강사 정보 검색하기</a><br/><br/>
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
        String sql = "SELECT i.Name AS InstructorName, t.Team_id AS TeamID\r\n FROM instructor i, teach te, team t\r\n WHERE i.Instructor_id = te.Tinstructor_id AND te.Tteam_id = t.Team_id";
        pstmt = conn.prepareStatement(sql);
        rs = pstmt.executeQuery();
        int list_number = 0;
%>
<table border="1">
    <a>아래는 현재 강의 중인 강사입니다</a>
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
        <td><%= list_number %>
        </td>
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