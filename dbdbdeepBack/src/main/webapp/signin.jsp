<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입하기</title>
</head>
<body>
	<h3>가입하기</h3>
<%
	String serverIP = "localhost";
	String strSID = "orcl";
	String portNum = "1521";
	String user = "dbdbdeep";
	String pass = "comp322";
	String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;
	
	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection(url,user,pass);
	
	String userid = request.getParameter("id");
	String name = request.getParameter("name");
	String sex = request.getParameter("sex");
	String age = request.getParameter("age");
	String height = request.getParameter("height");
	String phone_num = request.getParameter("phonenum");
	String address = request.getParameter("address");
	String personalAgree = request.getParameter("personaladdress");
	
	
%>
<%!
	public void winopen(){
		
	}
%>
</body>
</html>