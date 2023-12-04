<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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
        if(checkTeam(team_id, user_id)){
            response.sendRedirect("teamInsertPage.html?param1=1");
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
            conn.close();
            pstmt.close();
            response.sendRedirect("TeamPage.jsp?param1=1");
        }
    } catch (SQLException e) {
        response.sendRedirect("TeamPage.jsp?param1=2");
        e.printStackTrace();
    }
%>
<%!
    private static boolean checkTeam(String teamId, String userId) {
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
            boolean boolFlag=false;
            if (!res.next()) {
                boolFlag = true;
            }

            sql = "SELECT *\r\nFROM UserP U, team T, participate P\r\n"
                    + "WHERE P.puser_id =? AND P.pteam_id =?";

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userId);
            pstmt.setString(2, teamId);
            res = pstmt.executeQuery();
            if (res.next()) {
                boolFlag = true;
            }
            conn.close();
            pstmt.close();
            res.close();
            return boolFlag;
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