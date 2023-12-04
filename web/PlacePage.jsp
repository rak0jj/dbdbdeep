<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Place Page</title>
</head>
<h1>구장 페이지</h1>
<table border="1">
    <h2>지역 별 구장 정보</h2>
    <form action="PlacePage.jsp" method="post">
        <input type="text" id="place" name="place" placeholder="지역">
        <input type="submit" value="검색">
    </form><br/>
    <a href="MainPage.jsp">뒤로가기</a><br/>
    <ul>
        <body>
        <%
            request.setCharacterEncoding("UTF-8");
            // DB연결에 필요한 변수 선언
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

        <tr>
            <th>구장 ID</th>
            <th>지역</th>
            <th>스포츠</th>
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
            <h2>지역 별 구장 수</h2>
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
                <h2>내 주변 구장</h2>
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
        </body>
    </ul>
</html>
