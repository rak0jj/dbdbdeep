<%--<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<!DOCTYPE html>--%>
<%--<html>--%>
<%--<head>--%>
<%--    <title>JSP - Hello World</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--<h1><%= "Hello World!" %>--%>
<%--</h1>--%>
<%--<br/>--%>
<%--<a href="hello-servlet">Hello Servlet</a>--%>
<%--</body>--%>
<%--</html>--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page language="java" import="java.text.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>COMP322: Introduction to Databases</title>
</head>
<body>
<h1>Lab #9: Repeating Lab #5-3 via JSP</h1>
<%
    String serverIP = "localhost";
    String strSID = "orcl"; //mac:xe
    String portNum = "1521";
    String user = "university";
    String pass = "comp322";
    String url = "jdbc:oracle:thin:@"+serverIP+":"+portNum+":"+strSID;

    //System.out.println(url);
    //out.println(url);
    Connection conn = null;
    PreparedStatement pstmt;
    ResultSet rs;
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection(url,user,pass);
    //Query1
    String pName1=request.getParameter("pName1");
    String dNum=request.getParameter("dNum");
    String Salary=request.getParameter("Salary");
    String query1 = "SELECT e.Fname, e.Lname, e.Salary FROM EMPLOYEE e, PROJECT p, WORKS_ON wo WHERE e.Dno ="+dNum
            +" AND e.Salary >= "+Salary
            +" AND e.Ssn = wo.Essn AND p.Pname = '"+pName1
            +"' AND p.Pnumber = wo.Pno ORDER BY e.Salary DESC";

    //Query2
    String Super_ssn1=request.getParameter("Super_ssn1");
    String Address=request.getParameter("Address");
    String query2 = "SELECT d.Dname, e.Ssn, e.Fname, e.Lname FROM DEPARTMENT d, EMPLOYEE e WHERE Address Like '%"+Address
            +"%' AND e.Super_ssn = '"+Super_ssn1
            +"' AND e.Dno = d.Dnumber";

    //Query3
    String pName2=request.getParameter("pName2");
    String Work_hours1=request.getParameter("Work_hours1");
    String query3 = "SELECT e.Fname, e.Lname, wo.Hours FROM EMPLOYEE e, WORKS_ON wo, PROJECT p WHERE p.Pname = '"+pName2
            +"' AND wo.Hours >= "+Work_hours1
            +" AND wo.Essn = e.Ssn AND wo.Pno = p.Pnumber ORDER BY wo.Hours";

    //Query4
    String pName3=request.getParameter("pName3");
    String Work_hours2=request.getParameter("Work_hours2");
    String query4 = "SELECT DISTINCT d.Dname, e.Fname, e.Lname FROM EMPLOYEE e, DEPARTMENT d, PROJECT p, WORKS_ON wo WHERE p.Pname LIKE '"+pName3
            +"%' AND wo.Hours >= "+Work_hours2
            +" AND wo.Pno = p.Pnumber AND wo.Essn = e.Ssn AND e.Dno = d.Dnumber ORDER BY e.Lname";

    //Query5
    String Super_ssn2=request.getParameter("Super_ssn2");
    String query5 = "SELECT d.Dname, e.Lname, e.Fname, dep.Dependent_name FROM EMPLOYEE e, DEPARTMENT d, DEPENDENT dep WHERE e.Super_ssn = '"
            +Super_ssn2+"' AND dep.Relationship = 'Spouse' AND dep.Essn = e.Ssn AND e.Dno = d.Dnumber";

    //out.println(query);
    //System.out.println(query);
%>

<h4>------ Q1 Result --------</h4>
<%
    pstmt = conn.prepareStatement(query1);
    rs = pstmt.executeQuery();
    out.println("<table border=\"1\">");
    ResultSetMetaData rsmd = rs.getMetaData();
    int cnt = rsmd.getColumnCount();
    for(int i =1;i<=cnt;i++){
        out.println("<th>"+rsmd.getColumnName(i)+"</th>");
    }
    while(rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString(1)+"</td>");
        out.println("<td>"+rs.getString(2)+"</td>");
        out.println("<td>"+rs.getDouble(3)+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");
    rs.close();
    pstmt.close();
%>

<h4>------ Q2 Result --------</h4>
<%
    pstmt = conn.prepareStatement(query2);
    rs = pstmt.executeQuery();
    out.println("<table border=\"1\">");
    rsmd = rs.getMetaData();
    cnt = rsmd.getColumnCount();
    for(int i =1;i<=cnt;i++){
        out.println("<th>"+rsmd.getColumnName(i)+"</th>");
    }
    while(rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString(1)+"</td>");
        out.println("<td>"+rs.getString(2)+"</td>");
        out.println("<td>"+rs.getString(3)+"</td>");
        out.println("<td>"+rs.getString(4)+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");
    rs.close();
    pstmt.close();
%>

<h4>------ Q3 Result --------</h4>
<%
    pstmt = conn.prepareStatement(query3);
    rs = pstmt.executeQuery();
    out.println("<table border=\"1\">");
    rsmd = rs.getMetaData();
    cnt = rsmd.getColumnCount();
    for(int i =1;i<=cnt;i++){
        out.println("<th>"+rsmd.getColumnName(i)+"</th>");
    }
    while(rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString(1)+"</td>");
        out.println("<td>"+rs.getString(2)+"</td>");
        out.println("<td>"+rs.getString(3)+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");
    rs.close();
    pstmt.close();
%>

<h4>------ Q4 Result --------</h4>
<%
    pstmt = conn.prepareStatement(query4);
    rs = pstmt.executeQuery();
    out.println("<table border=\"1\">");
    rsmd = rs.getMetaData();
    cnt = rsmd.getColumnCount();
    for(int i =1;i<=cnt;i++){
        out.println("<th>"+rsmd.getColumnName(i)+"</th>");
    }
    while(rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString(1)+"</td>");
        out.println("<td>"+rs.getString(2)+"</td>");
        out.println("<td>"+rs.getString(3)+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");
    rs.close();
    pstmt.close();
%>

<h4>------ Q5 Result --------</h4>
<%
    pstmt = conn.prepareStatement(query5);
    rs = pstmt.executeQuery();
    out.println("<table border=\"1\">");
    rsmd = rs.getMetaData();
    cnt = rsmd.getColumnCount();
    for(int i =1;i<=cnt;i++){
        out.println("<th>"+rsmd.getColumnName(i)+"</th>");
    }
    while(rs.next()){
        out.println("<tr>");
        out.println("<td>"+rs.getString(1)+"</td>");
        out.println("<td>"+rs.getString(2)+"</td>");
        out.println("<td>"+rs.getString(3)+"</td>");
        out.println("<td>"+rs.getString(4)+"</td>");
        out.println("</tr>");
    }
    out.println("</table>");
    rs.close();
    pstmt.close();
    conn.close();
%>
</body>
</html>