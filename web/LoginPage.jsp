<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>로그인 페이지</title>
</head>
<body>
<%
    String serverIP = "localhost";
    String strSID = "orcl"; //mac:xe
    String portNum = "1521";
    String user = "university";
    String pass = "comp322";
    String url = "jdbc:oracle:thin:@" + serverIP + ":" + portNum + ":" + strSID;
    out.println("아오오오오오");
    Connection conn = null;
    PreparedStatement pstmt;
    ResultSet rs;
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url, user, pass);
    out.println("아오오오오오");
%>

<form action="LoginPage.jsp" method="post">
    <label for="userid">아이디:</label><br>
    <input type="text" id="userid" name="userid"><br>
    <label for="pwd">비밀번호:</label><br>
    <input type="password" id="pwd" name="pwd"><br>
</form>

<button onclick=checkUserId()>로그인</button>
<button onclick="location.href='SignUp.jsp'">회원가입</button>

<%--<button onclick="location.href='SignUp.jsp'" onsubmit="checkUserId()">로그인</button>--%>

<script>
    function checkUserId() {
        alert('A1');
        String: userId = document.getElementById("userid").value.toString();
        var userPwd = document.getElementById("pwd").value.toString();
        //Query1
        String: query1 = "SELECT e.NAME FROM USERP e" +
            " WHERE e.USER_ID =" + userId
            + " AND e.PHONE_NUMBER = " + userPwd;
        alert('A2');
        pstmt = conn.prepareStatement(query1);
        rs = pstmt.executeQuery();
        // ResultSetMetaData: rsmd = rs.getMetaData();
        //int: cnt = rsmd.getColumnCount();
        alert('A3');
        if (false) {
            // 아이디가 3이면 MainPage.jsp로 이동
            alert(userId+ '로그인 성공 장락영 멋있어');
            window.location.href = 'MainPage.jsp';
            return false; // 폼이 서버로 전송되지 않도록 false를 반환
        } else {
            // 아이디가 3이 아닐 경우 '귀찮다' 알림 출력
            alert(cnt);
            alert('아이디 틀렸다 장락영 바보');
            return false; // 폼이 서버로 전송되지 않도록 false를 반환
        }
    }
</script>

</body>
</html>