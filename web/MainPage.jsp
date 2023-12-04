<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>메인 화면</title>
    <style>
        body {
            background-color: #f4f4f4;
        }

        form {
            background-color: #fff;
            padding: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
        }

        content-body {
            padding: 30px;
            display: flex;
            flex-direction: column;
        }

        .button-style {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px;
            background-color: #FFFFFF;
            color: #6EA9F7;
            text-decoration: none;
            border-radius: 5px;
            border: 2px solid #6EA9F7;
        }

        .button-style:hover {
            background-color: #5a9bf5;
            color: #FFFFFF;
        }


        .content-button-style {
            width:30%;
            height:40px;
            font-size: 20px;
            display: inline-block;
            padding: 10px 20px;
            margin: 5px;
            background-color: #6EA9F7;
            color: #FFFFFF;
            text-decoration: none;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .content-button-style:hover {
            background-color: #FFFFFF;
            color: #5a9bf5;
        }

        .right-align {
            text-align: right;
        }

        .bold-text {
            font-size: 20px;
            font-weight: 600;
        }

        .medi-text {
            font-size: 20px;
            font-weight: 400;
        }
        #toptext1 {
            position:fixed;
            width:260px;
            margin-top:0.23%;
            margin-left:0.35%;
            font-size: 32px;
            font-weight: 400;
            color:#6EA9F7;
            display: flex;
            flex-direction: column;
        }
    </style>
<body>
<form>
    <a id="toptext1">디비디비스포츠</a>
    <div class="right-align">
        <%
            String userId = String.valueOf(session.getAttribute("user_name"));
            if (userId == null) {
                userId = "null";
            }
        %>
        <span class="bold-text"><%=userId%></span><span class="medi-text">님 안녕하세요</span>
        <a href="logout.jsp" class="button-style">로그아웃</a>
        <a href="UserInfoChangePage.jsp" class="button-style">정보수정</a>
        <a href="delete_ok.jsp" class="button-style">회원탈퇴</a>
    </div>
</form>
<content-body>
    <a href="UserPage.jsp" class="content-button-style">> 다른 유저</a>
    <a href="TeamPage.jsp" class="content-button-style">> 팀</a>
    <a href="PlacePage.jsp" class="content-button-style">> 구장</a>
    <a href="InstructorPage.jsp" class="content-button-style">> 강사</a>
    <a href="MatchPage.jsp" class="content-button-style">> 경기 정보</a>
    <a href="RefereePage.jsp" class="content-button-style">> 심판 정보</a>
</content-body>
</body>
</html>