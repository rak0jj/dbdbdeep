<%--
  Created by IntelliJ IDEA.
  UserRepository.User: bmj20
  Date: 2023-12-03
  Time: 오후 2:22
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.sql.*"%>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String userId = request.getParameter("userId");
    String Pwd = request.getParameter("Pwd2");
    String userName = request.getParameter("userName");
    String sex = request.getParameter("sex");
    String ageString = request.getParameter("age");
    String heightString = request.getParameter("height");
    String address = request.getParameter("address");
    Integer age=100, height=100;

    List<String> location = Arrays.asList("서울특별시", "부산광역시", "대구광역시", "울산광역시", "광주광역시",
            "인천광역시", "대전광역시", "세종특별자치시", "제주특별자치도",
            "경기도", "경상북도", "경상남도", "충청북도", "충청남도", "전라북도", "전라남도", "강원도");



    String[] city = address.split("\\s+");
    Integer stopFlag=0;
    if (!sex.equals("M") && !sex.equals("F")) {
        stopFlag = 1;//"성별은 'M'혹은 'F'로 입력해주세요";
    } else if (!ageString.matches("\\d+") || !heightString.matches("\\d+")) {
        stopFlag=2;//"나이와 키는 숫자로 입력해주세요";
    } else {
        age = Integer.parseInt(ageString);
        height = Integer.parseInt(heightString);
        if (age < 0 || age > 130 || height < 1 || height > 300 || !location.contains(city[0])) {
            stopFlag = 3;//"정상적이지 않은 값이 있습니다";
        }
    }
    if(stopFlag>0) {
        response.sendRedirect("SignupPage.jsp?error1=" + stopFlag);
        return;
    }


    // DB연결에 필요한 변수 선언
    String URL = "jdbc:oracle:thin:@localhost:1521:orcl"; //mac : xe
    String USER = "dbdbdeep";
    String PASSWORD = "comp322";

    Connection conn = null;
    PreparedStatement pstmt;
    ResultSet rs;
    String sql = "SELECT * " + "FROM userp " + "WHERE user_id = ?";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(URL, USER, PASSWORD);
        conn.setAutoCommit(false);
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);

        // sql실행
        rs = pstmt.executeQuery();
        String nextPage = null;
        if (rs.next()) { // 중복 아이디 존재
            nextPage = "SignupPage.jsp?error1=4";
        } else {// 회원가입 성공
            sql = "INSERT INTO userp VALUES(?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, userId);
            pstmt.setString(2, userName);
            pstmt.setString(3, sex);
            pstmt.setInt(4, age);
            pstmt.setInt(5, height);
            pstmt.setString(6, Pwd);
            pstmt.setString(7, address);

            pstmt.executeUpdate();
            conn.commit();

            nextPage = "LoginPage.jsp?param1=" + userId;
        }
        conn.close();
        pstmt.close();
        rs.close();
        response.sendRedirect(nextPage);
    }
    catch(Exception e) {
        e.printStackTrace();
        response.sendRedirect("LoginPage.jsp"); // 에러가 난 경우도 리다이렉트
    }
%>
