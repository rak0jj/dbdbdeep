<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
            margin-bottom: 8px;
        }

        input {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            margin-bottom: 16px;
        }

        table td {
            padding: 8px;
        }
    </style>
    <title>dbdbDeep 회원가입</title>


    <%
        request.setCharacterEncoding("UTF-8");
        String error1 = request.getParameter("error1");

        if(error1!=null) {
            Integer EN1 = Integer.parseInt(error1);
            if (EN1 == 1) {
    %>
    <script>
        alert("성별은 'M'혹은 'F'로 입력해주세요");
    </script>
    <%
            } else if (EN1 == 2) {
    %>
    <script>
        alert("나이와 키는 숫자로 입력해주세요");
    </script>
    <%
            } else if (EN1 == 3) {
    %>
    <script>
        alert("정상적이지 않은 값이 있습니다");
    </script>
    <%
            } else if (EN1 == 4) {
    %>
    <script>
        alert("아이디가 중복됩니다");
    </script>
    <%
            }
            %>
    <script>
        alert(ENCODE);
    </script>
    <%
        }
    %>
</head>

<body>
<form name="frm" action="SignUpCheck.jsp" method="post">
    <fieldset>
        <table>
            <tr>
                <td><label for="userId">아이디</label></td>
                <td><input type="text" name="userId" id="userId" placeholder="2023117089" /></td>
            </tr>
            <tr>
                <td><label for="Pwd2">비밀번호</label></td>
                <td><input type="password" name="Pwd2" id="Pwd2" placeholder="010-1234-5678"/></td>
            </tr>
            <tr>
                <td><label for="userName">사용자 이름</label></td>
                <td><input type="text" name="userName" id="userName" placeholder="장락영"/></td>
            </tr>
            <tr>
                <td><label for="sex">성별(M/F)</label></td>
                <td><input type="text" name="sex" id="sex" placeholder="M"/></td>
            </tr>
            <tr>
                <td><label for="age">나이</label></td>
                <td><input type="text" name="age" id="age" placeholder="24"/></td>
            </tr>
            <tr>
                <td><label for="height">신장</label></td>
                <td><input type="text" name="height" id="height" placeholder="173" /></td>
            </tr>
            <tr>
                <td><label for="address">주소(도로명 주소)</label></td>
                <td><input type="text" name="address" id="address" placeholder="대구광역시 뽀로로 금은동"/></td>
            </tr>
        </table>
        <input type="submit" value="회원가입">
    </fieldset>
</form>
</body>
</html>