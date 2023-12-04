<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.Connection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Page</title>
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
            border: 1px solid #ccc;
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
            border: 1px solid #ccc;
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
        <span style="font-family: 굴림체; font-size: 30px; text-align: center;">강사 페이지</span>
    </div>
</header>
<a href="MainPage.jsp" class="main-button2" style="float: right; position:fixed; margin-left: 90%; margin-top: 0.7%;">메인 페이지</a>
<div class="container">
    <a href="InstructorSearch.jsp" class="main-button" style="font-size:15px; padding:8px">강사 정보 검색하기</a><br/><br/>
    <%
        request.setCharacterEncoding("UTF-8");
        String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
        String USER = "dbdbdeep";
        String PASSWORD = "comp322";

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            String sql = "SELECT i.Name AS InstructorName, t.Team_id AS TeamID\r\n FROM instructor i, teach te, team t\r\n WHERE i.Instructor_id = te.Tinstructor_id AND te.Tteam_id = t.Team_id";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            int list_number = 0;
    %>
    <table border="1">
        <a>아래는 현재 강의 중인 강사입니다</a>
        <tr>
            <th></th>
            <th>강사명</th>
            <th>맡은 팀 ID</th>
        </tr>
        <%
            while (rs.next()) {
                list_number++;
        %>
        <tr>
            <td><%= list_number %>
            </td>
            <td><%= rs.getString(1) %>
            </td>
            <td><%= rs.getString(2) %>
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