<%--
  Created by IntelliJ IDEA.
  User: seakim
  Date: 12/2/23
  Time: 4:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
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
</head>
<body>

<%=session.getAttribute("user_id") %>님 안녕하세요


<a href="logout.jsp">로그아웃</a><br/>
<a href="getInfo.jsp">정보수정</a><br/>
<a href="delete_ok.jsp">회원탈퇴</a><br/>

<a class="button-style">1</a>
<a class="button-style">2</a>
<a class="button-style">3</a>
<a class="button-style">4</a>
<a class="button-style">5</a>
<a class="button-style">6</a>
<a class="button-style">7</a>


</body>
</html>