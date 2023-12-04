<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@page import="java.text.*" %>
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

        .bold-text {
            font-size: 40px;
            font-weight: 700;
        }

        .content-text {
            font-size: 15px;
            font-weight: 400;
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
    <title>teamSearchPage</title>
    <a href="MainPage.jsp" class="main-button">메인 페이지</a>
    <a href="TeamPage.jsp" class="back-button">뒤로가기</a>
    <h1 class="bold-text">소속팀 검색 페이지</h1>
    <h1 class="content-text">내 소속 팀</h1>
</head>
<ul>
    <body>
    <%
        request.setCharacterEncoding("UTF-8");
        // DB연결에 필요한 변수 선언
        String URL = "jdbc:oracle:thin:@localhost:1521:xe"; //mac : xe
        String USER = "dbdbdeep";
        String PASSWORD = "comp322";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

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
            <td><%= rs.getString(1) %>
            </td>
            <td><%= rs.getString(2) %>
            </td>
            <td><%= rs.getString(3) %>
            </td>
            <td><%= rs.getString(4) %>
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
