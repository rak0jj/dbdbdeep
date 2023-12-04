<%--
  Created by IntelliJ IDEA.
  User: jfkrd
  Date: 2023-12-04
  Time: 오전 2:31
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*" %>
<%@page import="java.util.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>주소 변경</title>
</head>
<body>
    <a href="UserInfoChangePage.jsp">뒤로가기</a><br/>
    <%
        request.setCharacterEncoding("UTF-8");
        String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
        String USER = "dbdbdeep";
        String PASSWORD = "comp322";

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            String user_id = (String) session.getAttribute("user_id");
            String address = request.getParameter("address");
            List<String> location = Arrays.asList("서울특별시", "부산광역시", "대구광역시", "울산광역시", "광주광역시",
                    "인천광역시", "대전광역시", "세종특별자치시", "제주특별자치도",
                    "경기도", "경상북도", "경상남도", "충청북도", "충청남도", "전라북도", "전라남도", "강원도");

            String[] city = address.split("\\s");
            if (!location.contains(city[0])) {
                response.sendRedirect("UserAddressChangePage.html");
            } else {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection(URL, USER, PASSWORD);
                conn.setAutoCommit(false);
                String sql = "UPDATE userp SET address = ? WHERE user_id = ?";

                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, address);
                pstmt.setString(2, user_id);
                pstmt.executeUpdate();
                conn.commit();

                response.sendRedirect("UserInfoChangePage.jsp");
                conn.close();
                pstmt.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>
</body>
</html>
