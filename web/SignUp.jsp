<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입란</title>
</head>
<body>
<form name = "frm" action="SignUp.jsp" method="post" onsubmit = "return formCheck()">
    <fieldset>
        <table>
            <tr>
                <td><label for="id">아이디</label></td>
                <td><input type="text" name="id" id="id" /></td>
            </tr>
            <tr>
                <td><label for="Pwd2">비밀번호</label></td>
                <td><input type="password" name="Pwd" id="Pwd2" /></td>
            </tr>
            <tr>
                <td><label for="userName">사용자 이름</label></td>
                <td><input type="text" name="userName" id="userName" /></td>
            </tr>
            <tr>
                <td><label for="Gender">성별(M/F)</label></td>
                <td><input type="text" name="Gender" id="Gender" /></td>
            </tr>
            <tr>
                <td><label for="Age">나이</label></td>
                <td><input type="text" name="Age" id="Age" /></td>
            </tr>
            <tr>
                <td><label for="Height">신장</label></td>
                <td><input type="text" name="Height" id="Height" /></td>
            </tr>
            <tr>
                <td><label for="Address">주소(도로명 주소)</label></td>
                <td><input type="text" name="Address" id="Address" /></td>
            </tr>
        </table>
    </fieldset>
    <input type ="" value = "회원가입"><br>
</form>
    <label for="userid"></label><br>
    <input type="text" id="userid" name="userid" placeholder="아이디"><br>
    <label for="pwd"></label><br>
    <input type="password" id="pwd" name="pwd" placeholder="전화번호(비밀번호)"><br>
    <input type="submit" value="로그인">

    <button onclick="showAlert()">알림 보이기</button>

</body>

<script>
    function showAlert() {
        alert("알림: 버튼을 클릭했습니다!");
        out.print("흠");
    }
</script>


</html>