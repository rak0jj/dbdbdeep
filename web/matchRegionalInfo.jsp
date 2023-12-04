<%--
  Created by IntelliJ IDEA.
  UserRepository.User: jfkrd
  Date: 2023-12-03
  Time: 오후 2:16
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <style>
        body {
            background-color: #f4f4f4;
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        header {
            background-color: #3A3D92;
            color: #fff;
            padding: 10px;
            text-align: center;
            width: 100%;
        }

        .container {
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-top: 20px;
            width: 800px;
            text-align: center;
        }

        .button-style {
            display: inline-block;
            padding: 10px;
            background-color: #3A3D92;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 16px;
            margin-bottom: 20px;
        }

        .main-button {
            display: inline-block;
            justify-content: center;
            padding: 8px;
            background-color: #c8d9f0;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 12px;
        }

        .main-button:hover {
            background-color: #c8d9f0;
        }

        h1 {
            font-size: 28px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        p {
            font-size: 14px;
            margin-bottom: 10px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #3A3D92;
            color: #fff;
        }
    </style>
    <title>지역별 경기 정보</title>
</head>
<body>
<header>
    <div>
        <span style="font-family: 굴림체; font-size: 30px; text-align: center;">지역별 경기 정보 검색 페이지</span>
        <div>
            <a href="MatchPage.jsp" class="main-button" style="float: right;">뒤로 가기</a>
        </div>
    </div>
</header>
<div class="container">
<%
    request.setCharacterEncoding("UTF-8");

    String sports = request.getParameter("sports");
    String region = request.getParameter("region");
    // DB연결에 필요한 변수 선언
    String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
    String USER = "dbdbdeep";
    String PASSWORD = "comp322";

    Connection conn = null;
    PreparedStatement pstmt=null;
    ResultSet rs=null;
    String sql = "SELECT g.game_id, g.win_team, g.lose_team\r\n"
                    + "FROM Game g, (SELECT *\r\n"
                    + "              FROM Place p\r\n"
                    + "              WHERE p.location LIKE ? and p.sports = ?) pl\r\n"
                    + "WHERE g.mplace_id=pl.place_id";
    try {
        // 드라이버 호출
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // conn 생성
        conn = DriverManager.getConnection(URL, USER, PASSWORD);

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, region + "%");
        pstmt.setString(2, sports);

        rs = pstmt.executeQuery();
%>
    <table border="1">
        <tr>
            <th>경기 ID</th>
            <th>승자 팀 ID</th>
            <th>패자 팀 ID</th>
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
</div>
</body>
</html>

