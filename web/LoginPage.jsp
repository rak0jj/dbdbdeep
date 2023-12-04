<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>dbdbDeep 로그인페이지</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            height: 100vh;
        }

        label {
            display: block;
            margin-bottom: 15px;
        }

        #topform1 {
            width:98%;
            height:50px;
            margin-top:0.5%;
            padding-left:1%;
            padding-top:13px;
            padding-bottom:13px;
            font-size: 32px;
            font-weight: 400;
            background-color: #c1d5f0;
            color:black;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
        }

        #centerform1 {
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            position:absolute;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        input {
            width: 100%;
            padding: 5px;
            margin-bottom: 15px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            margin-left:5%;
            width: 90%;
            padding: 6px;
            margin-bottom:3px;
            background-color: #6EA9F7;
            color: #ffffff;
            cursor: pointer;
            font-size: 20px;
        }

        input[type="submit"]:hover {
            background-color: #5a9bf5;
        }

        input[type="action"] {
            width: 25%;
            margin-left:70%;
            margin-bottom: 3px;
            padding: 6px;
            background-color: #ffffff;
            color: #1414ff;
            border: white;
            cursor: pointer;
            text-align: right;
            font-size: 12px;
        }

        input[type="action"]:hover {
            text-decoration: underline;
        }

        table {
            width: 100%;
            margin-bottom: 16px;
        }

        table td {
            padding: 8px;
        }

        h1{
            margin-left: 10px;
        }
        h2{
            width:100%;
        }
    </style>

    <%
        request.setCharacterEncoding("UTF-8");
        String error1 = request.getParameter("param1");

        if(error1!=null) {
            Integer EN1 = Integer.parseInt(error1);
            if (EN1 == 1) {
                %>
    <script>
        alert("존재하지 않는 아이디거나 비밀번호가 틀렸습니다.");
    </script>
    <%
            }
            else {
    %>
    <script>
        alert("인터넷 혹은 서버 오류가 있습니다.");
    </script>
    <%
            }
        }
    %>

</head>
<body>
<form id="topform1">
    <div>
        <span>디비디비스포츠</span>
    </div>
</form>
<form id="centerform1" action="LoginCheck.jsp" method="post">
    <fieldset>
        <h1>로그인</h1>
        <table>
            <tr>
                <td><label for="userid">아이디</label></td>
                <td><input type="text" name="userid" id="userid" placeholder="2023117089" /></td>
            </tr>
            <tr>
                <td><label for="pwd">비밀번호</label></td>
                <td><input type="password" name="pwd" id="pwd" placeholder="010-1234-5678"/></td>
            </tr>
        </table>
        <input type="submit" id="login1" value="로그인">
        <input type="action" id="signup1" onclick="window.location.href='SignupPage.jsp'" value="회원가입">
    </fieldset>
</form>
</body>
</html>
