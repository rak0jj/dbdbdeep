<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입란</title>

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
<form name = "frm" action="SignUpCheck.jsp" method="post">
    <fieldset>
        <table>
            <tr>
                <td><label for="userId">아이디</label></td>
                <td><input type="text" name="userId" id="userId" placeholder="장락영 바보" /></td>
            </tr>
            <tr>
                <td><label for="Pwd2">비밀번호</label></td>
                <td><input type="password" name="Pwd2" id="Pwd2" placeholder="전화번호 형식"/></td>
            </tr>
            <tr>
                <td><label for="userName">사용자 이름</label></td>
                <td><input type="text" name="userName" id="userName" /></td>
            </tr>
            <tr>
                <td><label for="sex">성별(M/F)</label></td>
                <td><input type="text" name="sex" id="sex" /></td>
            </tr>
            <tr>
                <td><label for="age">나이</label></td>
                <td><input type="text" name="age" id="age" /></td>
            </tr>
            <tr>
                <td><label for="height">신장</label></td>
                <td><input type="text" name="height" id="height" placeholder="ex.173cm" /></td>
            </tr>
            <tr>
                <td><label for="address">주소(도로명 주소)</label></td>
                <td><input type="text" name="address" id="address" /></td>
            </tr>
        </table>
        <input type="submit" value="회원가입">
    </fieldset>
</form>
</body>
</html>