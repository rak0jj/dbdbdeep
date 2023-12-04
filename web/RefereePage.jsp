<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@page import="java.text.*" %>
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
    </style>
    <title>RefereePage</title>
    <a href="MainPage.jsp" class="back-button">뒤로가기</a><br/>
    <h1>심판 정보 검색 페이지</h1>
    <form action="RefereePage.jsp" method="post">
        <h3>종목, 월급 입력란</h3></br>
        <input type="text" id="sports" name="sports" placeholder="종목">
        <input type="text" id="salary" name="salary" placeholder="월급">
        <input type="submit" value="검색">
    </form>
</head>
<ul>
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
            String sql = "(SELECT referee_id, name, phone_number, sports, salary\r\n"
                    + "FROM REFEREE\r\n"
                    + "WHERE sports=?)\r\n"
                    + "INTERSECT\r\n"
                    + "(SELECT referee_id, name, phone_number, sports, salary\r\n"
                    + "FROM REFEREE\r\n"
                    + "WHERE salary=?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, request.getParameter("sports"));
            pstmt.setInt(2, Integer.parseInt(request.getParameter("salary")));
            rs = pstmt.executeQuery();
    %>
    <table border="1">
        <tr>
            <th>심판 ID</th>
            <th>이름</th>
            <th>연락처</th>
            <th>종목</th>
            <th>월급</th>
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
            <td><%= rs.getInt(5) %>원</td>
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
