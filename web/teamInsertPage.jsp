<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>팀 가입</title>
</head>
<body>
<%
        request.setCharacterEncoding("UTF-8");

        String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
        String USER = "dbdbdeep";
        String PASSWORD = "comp322";

        Connection conn = null;
        PreparedStatement pstmt;

    try {
        String user_id = (String) session.getAttribute("user_id");
        String team_id = request.getParameter("team_id");
        if(checkTeam(team_id)){
            response.sendRedirect("teamInsertPage.html");
        }
        else {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            conn.setAutoCommit(false);
            String sql = "INSERT INTO participate VALUES(?,?)";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user_id);
            pstmt.setString(2, team_id);
            pstmt.executeUpdate();
            conn.commit();

            response.sendRedirect("TeamPage.jsp");
            conn.close();
            pstmt.close();
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<%!
    private static boolean checkTeam(String teamId) {
        try {
            String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
            String USER = "dbdbdeep";
            String PASSWORD = "comp322";

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            conn.setAutoCommit(false);

            String sql = "select * from team where team_id = ?";
            PreparedStatement pstmt = null;

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, teamId);
            ResultSet res = pstmt.executeQuery();

            conn.close();
            pstmt.close();
            if (!res.next()) {
                return true;
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            return false;
        }
    }
%>
<a href="TeamPage.jsp" class="back-button">뒤로가기</a>
</body>
</html>