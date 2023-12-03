<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입란</title>

    <%
        request.setCharacterEncoding("UTF-8");
        String param1 = request.getParameter("param1");
        String error1 = request.getParameter("error1");
        if(param1!=null) {
            Integer cd1 = Integer.parseInt(param1);
            if(cd1==1){
                %>
    <script>
        alert("이건 1이야");
    </script>
    <%
            }
    %>
    <script>
        alert("아이디가 중복되거나 조건이 충족 되지 않습니다");
    </script>
    <%
        }
        if(error1!="0" && error1!=null){
    %>
    <script>
        alert("성별은 'M'혹은 'F'로 입력해주세요");
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
        <input type="submit" value="로그인">
    </fieldset>
</form>
</body>
</html>