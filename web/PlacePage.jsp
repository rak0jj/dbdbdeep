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
<form action="PlacePage.jsp" method="post">
    <input type="text" id="place" name="place" placeholder="지역">
    <input type="submit" value="검색">
</form>
<button onclick="location.href='MainPage.jsp'">메인 페이지</button>
<ul>
    <body>
    <%
        request.setCharacterEncoding("UTF-8");
        // DB연결에 필요한 변수 선언
        String URL = "jdbc:oracle:thin:@localhost:1521:xe"; //mac : xe
        String USER = "dbdbdeep";
        String PASSWORD = "comp322";

        Connection conn = null;
        PreparedStatement pstmt=null, countPstmt=null, nearbyPstmt=null;
        ResultSet rs=null, countRs=null, nearbyRs=null;

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
            <th>스포츠</th>
            <th>시간 당 비용</th>
        </tr>
            <%
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString(1) %></td>
            <td><%= rs.getString(2).substring(0, 2) %></td>
            <td><%= rs.getString(3) %></td>
            <td><%= rs.getString(4) %>원</td>
        </tr>
            <%
                }

        String countSql = "SELECT SUBSTR(Location, 1, 2) AS ShortLocation, COUNT(*) AS StadiumCount FROM place GROUP BY SUBSTR(Location, 1, 2)";
        countPstmt = conn.prepareStatement(countSql);
        countRs = countPstmt.executeQuery();
        %>
        <table border="1"><br>
            <tr>
                <th>지역</th>
                <th>구장 수</th>
            </tr>
                <%
            while (countRs.next()) {
        %>
            <tr>
                <td><%= countRs.getString(1) %></td>
                <td><%= countRs.getString(2) %></td>
            </tr>
                <%
                }

        // 사용자 주소를 기반으로 주변의 구장을 조회하는 SQL 쿼리
        // 사용자의 주소는 'user.address'라는 가정 하에 작성되었습니다.
        // 실제로는 사용자의 주소를 얻는 방법을 적용해야 합니다.
        String userAddress = "user.address";
        String[] addressList = userAddress.split("\\s");
        String city = addressList[0] + '%';
        String nearbySql = "SELECT Place_id, Location " +
                           "FROM place " +
                           "WHERE Place_id IN ( " +
                           "  SELECT Mplace_id " +
                           "  FROM game " +
                           "  WHERE Mplace_id IN ( " +
                           "    SELECT Place_id " +
                           "    FROM place " +
                           "    WHERE Location LIKE ? " +
                           "  )" +
                           ")";
        nearbyPstmt = conn.prepareStatement(nearbySql);
        nearbyPstmt.setString(1, city);
        nearbyRs = nearbyPstmt.executeQuery();
        %>
            <table border="1"><br>
                <tr>
                    <th>내 주변 구장 ID</th>
                    <th>위치</th>
                </tr>
                <%
                    while (nearbyRs.next()) {
                %>
                <tr>
                    <td><%= nearbyRs.getString(1) %></td>
                    <td><%= nearbyRs.getString(2) %></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch(Exception e) {}
                        if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
                        if (countRs != null) try { countRs.close(); } catch(Exception e) {}
                        if (countPstmt != null) try { countPstmt.close(); } catch(Exception e) {}
                        if (nearbyRs != null) try { nearbyRs.close(); } catch(Exception e) {}
                        if (nearbyPstmt != null) try { nearbyPstmt.close(); } catch(Exception e) {}
                        if (conn != null) try { conn.close(); } catch(Exception e) {}
                    }
                %>
            </table>
    </body>
</ul>
</html>
