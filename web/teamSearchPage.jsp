<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@page import="java.text.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>UserPage</title>
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
            width: 400px;
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
        .main-button2 {
            display: inline-block;
            justify-content: center;
            padding: 8px;
            background-color: #FFFFFF;
            color: #2d2d82;
            transition: background-color 0.3s;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 12px;
        }

        .main-button2:hover {
            background-color: #3A3D92;
            color: #FFFFFF;
        }
    </style>
</head>
<body>
<header>
    <div>
        <span style="font-family: 굴림체; font-size: 30px; text-align: center;">소속 팀 검색 페이지</span>
    </div>
</header>
<a href="MainPage.jsp" class="main-button2" style="float: right; position:fixed; margin-left: 90%; margin-top: 0.7%;">메인 페이지</a>
<div class="container">
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
</div>
</body>
</html>