<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.sql.*" %>
<%@page import="java.text.*" %>
<html>
<head>
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
            width: 800px;
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
    </style>
    <title>심판 정보</title>
</head>
<body>
<header>
    <div>
        <span style="font-family: 굴림체; font-size: 30px; text-align: center;">심판 정보 검색 페이지</span>
        <div>
            <a href="MainPage.jsp" class="main-button" style="float: right;">메인 페이지</a>
        </div>
    </div>
</header>
<div class="container">
    <form action="RefereePage.jsp" method="post">
        <h3>종목, 월급 입력란</h3></br>
        <input type="text" id="sports" name="sports" placeholder="종목">
        <input type="text" id="salary" name="salary" placeholder="월급">
        <input type="submit" value="검색">
    </form>
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
