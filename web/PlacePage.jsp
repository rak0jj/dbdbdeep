<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Place Page</title>
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
        .main-button {
            display: inline-block;
            justify-content: center;
            padding: 5px;
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
    </style>
</head>
<body>
<header>
    <div>
        <span style="font-family: 굴림체; font-size: 30px; text-align: center;">구장 페이지</span>
    </div>
</header>
<a href="MainPage.jsp" class="main-button2" style="float: right; position:fixed; margin-left: 90%; margin-top: 0.7%;">메인 페이지</a>
<div class="container">
    <h2>1. 지역 별 구장 정보</h2>
    <form action="PlacePage.jsp" method="post">
        <input type="text" id="place" name="place" placeholder="지역" style="padding:3px; font-size:15px; width:130px">
        <input type="submit" value="검색" class="main-button" style="font-size:18px; width:60px; margin-left:10px"><br>
    </form>
    <br/>
    <%
        request.setCharacterEncoding("UTF-8");
        String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
        String USER = "dbdbdeep";
        String PASSWORD = "comp322";

        Connection conn = null;
        PreparedStatement pstmt = null, countPstmt = null, nearbyPstmt = null;
        ResultSet rs = null, countRs = null, nearbyRs = null;

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
            <th>종목</th>
            <th>시간 당 비용</th>
        </tr>
            <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString(1) %>
            </td>
            <td><%= rs.getString(2).substring(0, 2) %>
            </td>
            <td><%= rs.getString(3) %>
            </td>
            <td><%= rs.getString(4) %>원</td>
        </tr>
            <%
            }

            String countSql = "SELECT SUBSTR(Location, 1, 2) AS ShortLocation, COUNT(*) AS StadiumCount FROM place GROUP BY SUBSTR(Location, 1, 2)";
            countPstmt = conn.prepareStatement(countSql);
            countRs = countPstmt.executeQuery();
        %>
        <table border="1"><br>
            <h2>2. 지역 별 구장 수</h2>
            <tr>
                <th>지역</th>
                <th>구장 수</th>
            </tr>
                <%
            while (countRs.next()) {
        %>
            <tr>
                <td><%= countRs.getString(1) %>
                </td>
                <td><%= countRs.getString(2) %>
                </td>
            </tr>
                <%
                }

        String userAddress = (String) session.getAttribute("user_address");
        String[] addressList = userAddress.split("\\s");
        String city = addressList[0] + '%';
        String nearbySql = "SELECT Place_id, Location\r\n"
                     + "FROM place\r\n"
                     + "WHERE Place_id IN (\r\n"
                     + "         SELECT Mplace_id\r\n"
                     + "         FROM game\r\n"
                     + "         WHERE Mplace_id IN (\r\n"
                     + "                  SELECT Place_id\r\n"
                     + "                  FROM place\r\n"
                     + "                  WHERE Location LIKE ?\r\n"
                     + "         )\r\n" + ")";

        nearbyPstmt = conn.prepareStatement(nearbySql);
        nearbyPstmt.setString(1, city);
        nearbyRs = nearbyPstmt.executeQuery();
        %>
            <table border="1"><br>
                <h2>3. 내 주변 구장</h2>
                <tr>
                    <th>내 주변 구장 ID</th>
                    <th>위치</th>
                </tr>
                <%
                    while (nearbyRs.next()) {
                %>
                <tr>
                    <td><%= nearbyRs.getString(1) %>
                    </td>
                    <td><%= nearbyRs.getString(2) %>
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
                        if (countRs != null) try {
                            countRs.close();
                        } catch (Exception e) {
                        }
                        if (countPstmt != null) try {
                            countPstmt.close();
                        } catch (Exception e) {
                        }
                        if (nearbyRs != null) try {
                            nearbyRs.close();
                        } catch (Exception e) {
                        }
                        if (nearbyPstmt != null) try {
                            nearbyPstmt.close();
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