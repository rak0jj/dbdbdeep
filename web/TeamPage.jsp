<%--
  Created by IntelliJ IDEA.
  UserRepository.User: seakim
  Date: 12/2/23
  Time: 9:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>TeamPage</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            width: 300px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .content-button-style {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px;
            background-color: #3A3D92;
            color: #FFFFFF;
            text-decoration: none;
            border-radius: 5px;
            border: 2px solid #3A3D92;
        }

        .content-button-style:hover {
            background-color: #FFFFFF;
            color: #3A3D92;
        }
    </style>
</head>

<body>

<form>
    <h1>팀 페이지</h1>
    <a href="teamInsertPage.html" class="content-button-style">1. 팀 가입</a>
    <a href="teamSearchPage.jsp" class="content-button-style">2. 소속 팀 검색</a>
    <a href="teamDeletePage.html" class="content-button-style">3. 소속 팀 탈퇴</a>
    <a href="MainPage.jsp" class="content-button-style">4. 뒤로가기</a>
</form>
</body>
</html>
