<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<html>
<head>
    <style>
        body {
            background-color: #fff;
        }

        form {
            background-color: #fff;
        }

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

        .bold-text {
            font-size: 40px;
            font-weight: 700;
        }

        .content-text {
            font-size: 15px;
            font-weight: 400;
        }

    </style>
    <body>
    <title>UserPage</title>
    <a href="MainPage.jsp" class="main-button">메인 페이지</a>
    <h1 class="bold-text">유저 정보 검색 페이지</h1>
    <form action="UserPage.jsp" method="post">
        <h1 class="content-text">검색을 원하는 사용자 이름을 입력하세요</h1>
        <input type="text" id="name" name="name" placeholder="이름">
        <input type="submit" value="검색">
    </form>
<ul>

    <%
        request.setCharacterEncoding("UTF-8");
        // DB연결에 필요한 변수 선언
        String URL = "jdbc:oracle:thin:@localhost:1521:xe"; //mac : xe
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
    <form>
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
    </form>
    </body>
</ul>
</head>
</html>
