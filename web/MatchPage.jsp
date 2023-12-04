<%--
  Created by IntelliJ IDEA.
  UserRepository.User: seakim
  Date: 12/2/23
  Time: 9:04 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
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
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .back-button {
            display: inline-block;
            justify-content: center;
            padding: 8px;
            background-color: #F3B234;
            color: #fff;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 12px;
        }

        .back-button:hover {
            background-color: #F3B234;
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
    <title>MatchPage</title>
</head>
<body>
<form>
    <a href="MainPage.jsp" class="back-button">뒤로가기</a>
    <h1>경기 정보 페이지</h1>
    <a href="matchMonthlyInfo.html" class="content-button-style">1. 월별 경기 정보</a>
    <a href="matchRegionalInfo.html" class="content-button-style">2. 지역별 경기 정보</a><br/>
</form>
</body>
</html>
