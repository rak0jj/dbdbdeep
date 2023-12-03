<%--
  Created by IntelliJ IDEA.
  User: bmj20
  Date: 2023-12-03
  Time: 오후 2:22
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");

    String userid = request.getParameter("userid");
    String pwd = request.getParameter("pwd");
    // DB연결에 필요한 변수 선언
    String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
    String USER = "dbdbdeep";
    String PASSWORD = "comp322";

    Connection conn = null;
    PreparedStatement pstmt;
    ResultSet rs;
    String sql = "SELECT * " + "FROM userp " + "WHERE user_id = ? " + "AND phone_number = ?";

    try {
        // 드라이버 호출
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // conn 생성
        conn = DriverManager.getConnection(URL, USER, PASSWORD);

        // pstmt 생성
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userid);
        pstmt.setString(2, pwd);

        // sql실행
        rs = pstmt.executeQuery();

        if (rs.next()) { // 로그인 성공(인증의 수단 session)
            session.setAttribute("user_id",userid);
            session.setAttribute("phone_number",pwd);
            response.sendRedirect("MainPage.jsp"); // 페이지이동
        } else { // 로그인 실패
            response.sendRedirect("LoginPage.html"); // 실패 페이지
        }
        conn.close();
        pstmt.close();
        rs.close();
    }
    catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("LoginPage.html"); // 에러가 난 경우도 리다이렉트
    }
%>
