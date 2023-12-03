<%--
  Created by IntelliJ IDEA.
  User: seakim
  Date: 12/2/23
  Time: 9:04 PM
  To change this template use File | Settings | File Templates.
--%>


<%--
private static void placeFunction(Scanner scanner, Connection conn) {
        try {
            System.out.println("-- 구장 관련 기능");
            System.out.println("실행할 기능 목록");
            System.out.println("1. 내 주변 구장 목록");
            System.out.println("2. 지역별 구장 수");
            System.out.println("3. 뒤로가기");
            System.out.print("카테고리 선택: ");
            int category = scanner.nextInt();
            scanner.nextLine();
            System.out.println();

            String sql = "";
            PreparedStatement pstmt;
            ResultSet res;
            switch (category) {
//                case 1:
//                    String[] addressList = user.name.split("\\s");
//                    String city = addressList[0] + '%';
//
//                    System.out.println("내 주변 구장 목록");
                case 1:
                    String[] addressList = user.address.split("\\s");
                    String city = addressList[0] + '%';

                    System.out.println("내 주변 구장 목록");

                    sql = "SELECT Place_id, Location\r\n" + "FROM place\r\n" + "WHERE Place_id IN (\r\n" + "         SELECT Mplace_id\r\n" + "         FROM game\r\n" + "         WHERE Mplace_id IN (\r\n" + "                  SELECT Place_id\r\n" + "                  FROM place\r\n" + "                  WHERE Location LIKE ?\r\n" + "         )\r\n" + ")";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, city);
                    res = pstmt.executeQuery();

                    while (res.next()) {
                        String placeID = res.getString(1);
                        String location = res.getString(2);
                        System.out.println("구장 id: " + placeID + ", 위치: " + location);
                    }
                    res.close();
                    System.out.println();
                    break;
                case 2:
                    //총 17개
                    System.out.println("지역별 구장 수");
//                    for (int i = 0; i < 16; i++) {
//                        sql += "SELECT ? AS Location, COUNT(*) AS StadiumCount\r\n" + "FROM place\r\n" + "WHERE Location LIKE ?\r\n" + "UNION";
//                    }
//                    sql += "SELECT ? AS Location, COUNT(*) AS StadiumCount\r\n" + "FROM place\r\n" + "WHERE Location LIKE ?";

                    for (int i = 0; i < 16; i++) {
                        sql += "SELECT ? AS Location, COUNT(*) AS StadiumCount\r\n"
                                + "FROM place\r\n"
                                + "WHERE Location LIKE ?\r\n"
                                + "UNION\r\n";
                    }
                    sql += "SELECT ? AS Location, COUNT(*) AS StadiumCount\r\n"
                            + "FROM place\r\n"
                            + "WHERE Location LIKE ?";

                    pstmt = conn.prepareStatement(sql);
                    for (int i = 0; i < 17; i++) {
                        String cityname = location.get(i);
                        pstmt.setString(i * 2 + 1, cityname);
                        pstmt.setString(i * 2 + 2, cityname + '%');
                    }

                    res = pstmt.executeQuery();
                    while (res.next()) {
                        String cityname = res.getString(1);
                        int stadiumNum = res.getInt(2);
                        System.out.println("지역명: " + cityname + ", 구장 수: " + stadiumNum);
                    }
                    res.close();
                    System.out.println();
                    break;
                case 3:
                    return;
                default:
                    System.out.println("1~3 사이의 값을 선택해주세요\n");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
--%>

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
    <label for="place">지역 검색</label>
    <input type="text" id="place" name="place">
    <input type="submit" value="검색">
</form>
<ul>
    <body>
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
            <td><%= rs.getString("Place_id") %></td>
            <td><%= rs.getString("Location").substring(0, 2) %></td>
            <td><%= rs.getString("Sports") %></td>
            <td><%= rs.getString("Price_per_time") %>원</td>
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
    </body>
</html>