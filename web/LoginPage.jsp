<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h1 {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        /*input {*/
        /*    width: 100%;*/
        /*    padding: 8px;*/
        /*    margin-bottom: 16px;*/
        /*    box-sizing: border-box;*/
        /*    border: 1px solid #ccc;*/
        /*    border-radius: 4px;*/
        /*}*/

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
            padding: 10px;
            border: none;
            border-radius: 4px;
            text-align: center;
        }

        /*input {*/
        /*    width: 100%;*/
        /*    padding: 8px;*/
        /*    margin-bottom: 16px;*/
        /*    box-sizing: border-box;*/
        /*    border: 1px solid #ccc;*/
        /*    border-radius: 4px;*/
        /*}*/

        /*input[type="submit"]:hover {*/
        /*    background-color: #45a049;*/
        /*}*/

        input[type="action"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
            padding: 10px;
            border: none;
            border-radius: 4px;
            text-align: center;
        }

        /*input[type="action"]:hover {*/
        /*    background-color: #45a049;*/
        /*    text-align: center;*/
        /*}*/
    </style>
</head>
<body>
<form action="LoginCheck.jsp" method="post">

    <form name="frm" action="SignupCheck.jsp" method="post">
        <fieldset>
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
</form>
</body>
</html>