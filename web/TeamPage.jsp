<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>TeamPage</title>

    <%
        request.setCharacterEncoding("UTF-8");
        String error1 = request.getParameter("param1");

        if(error1!=null) {
            Integer EN1 = Integer.parseInt(error1);
            if (EN1 == 1) {
    %>
    <script>
        alert("팀 가입이 완료되었습니다.\n소속팀을 소속팀검색에서 확인해보세요.");
    </script>
    <%
            }
            else if (EN1 == 2) {
    %>
    <script>
        alert("인터넷 혹은 서버 오류가 있습니다.");
    </script>
    <%
            }
            else if (EN1 == 3) {
    %>
    <script>
        alert("팀 탈퇴에 성공하셨습니다.");
    </script>
    <%
            }
        }
    %>

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
            color: white;
            transition: background-color 0.3s;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
            font-size: 12px;
            border: 2px solid #F3B234;;
        }

        .back-button:hover {
            background-color: white;
            color: #F3B234;
        }

        .content-button-style {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px;
            background-color: #3A3D92;
            color: #FFFFFF;
            transition: background-color 0.3s;
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
    <a href="MainPage.jsp" class="back-button">뒤로가기</a>
    <h1>팀 페이지</h1>
    <a href="teamInsertPage.html" class="content-button-style">1. 팀 가입</a>
    <a href="teamSearchPage.jsp" class="content-button-style">2. 소속 팀 검색</a>
    <a href="teamDeletePage.html" class="content-button-style">3. 소속 팀 탈퇴</a>
</form>
</body>
</html>
