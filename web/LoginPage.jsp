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
            align-items: center;
            height: 100vh;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 15px;
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
            background-color: #c8d9f0;
            color: #ffffff;
            cursor: pointer;
            font-size: 20px;
        }

        input[type="submit"]:hover {
            background-color: #c1d5f0;
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
    </style>
</head>
<body>
<form action="LoginCheck.jsp" method="post">
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
