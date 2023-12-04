<%--
  Created by IntelliJ IDEA.
  UserRepository.User: seakim
  Date: 12/2/23
  Time: 4:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 화면</title>
    <style>
        .button-style {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px 0;
            background-color: #FFFFFF;
            color: #3A923D;
            text-decoration: none;
            border-radius: 5px;
            border: 2px solid #3A923D;
        }

        .button-style:hover {
            background-color: #3A923D;
            color: #FFFFFF;
            /*border: #3A923D;*/
        }
    </style>

    <%
        request.setCharacterEncoding("UTF-8");
        String param1 = request.getParameter("param1");
        if(param1!=null) {
            out.println(param1);
        }
        else{
            //out.println("null이 반환됐다");
        }
    %>
</head>
<body>
<%
    String userId = String.valueOf(session.getAttribute("user_name"));
    if(userId==null) {
        userId="null";
    }
%>
<%=userId%>님 안녕하세요
<br/>

<a href="logout.jsp">로그아웃</a><br/>
<a href="UserInfoChangePage.jsp">정보수정</a><br/>
<a href="delete_ok.jsp">회원탈퇴</a><br/>

<a href="UserPage.jsp" class="button-style">1</a>
<a href="TeamPage.jsp" class="button-style">2</a>
<a href="PlacePage.jsp" class="button-style">3</a>
<a href="InstructorPage.jsp" class="button-style">4</a>
<a href="MatchPage.jsp" class="button-style">5</a>
<a href="RefereePage.jsp" class="button-style">6</a>


</body>
</html>