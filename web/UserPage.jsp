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

        .main-button {
            display: inline-block;
            justify-content: center;
            padding: 8px;
            background-color: #3A3D92;
            color: #FFFFFF;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 12px;
        }

        .main-button:hover {
            background-color: #FFFFFF;
            color: #2d2d82;
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
</head>
<body>
<header>
    <div>
        <span style="font-family: 굴림체; font-size: 30px; text-align: center;">유저 정보 검색 페이지</span>
    </div>
</header>

<a href="MainPage.jsp" class="main-button2" style="float: right; position:fixed; margin-left: 90%; margin-top: 0.7%;">메인 페이지</a>

<div class="container">
    <form action="UserPage.jsp" method="post">
        <p>검색을 원하는 사용자 이름을 입력하세요</p>
        <input type="text" id="name" name="name" placeholder="이름" style="width: 80%; padding: 8px;">
        <br><br>
        <input type="submit" value="검색" class="main-button">
    </form>

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
            <td><%= (rs.getString(2).equals("M") ? "남자" : "여자") %></td>
            <td><%= rs.getInt(3) %>살</td>
            <td><%= rs.getInt(4) %>cm</td>
            <td><%= rs.getString(5) %></td>
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