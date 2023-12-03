<%--
  Created by IntelliJ IDEA.
  User: seakim
  Date: 12/2/23
  Time: 9:04 PM
  To change this template use File | Settings | File Templates.
--%>

<%--
 private static void instructorFunction(Scanner scanner, Connection conn) {
        try {
            System.out.println("-- 강사 관련 기능");
            System.out.println("실행할 기능 목록");
            System.out.println("1. 강의 중인 강사 정보 리스트");
            System.out.println("2. 종목 & 월급 -> 강사 검색");
            System.out.println("3. 뒤로가기");
            System.out.print("카테고리 선택: ");
            int category = scanner.nextInt();
            scanner.nextLine();
            System.out.println();

            String sql;
            PreparedStatement pstmt;
            ResultSet res;
            switch (category) {
                case 1:
                    System.out.println("강의 중인 강사 정보 리스트");
                    sql = "SELECT i.Name AS InstructorName, t.Team_id AS TeamID\r\n" + "FROM instructor i, teach te, team t\r\n" + "WHERE i.Instructor_id = te.Tinstructor_id AND te.Tteam_id = t.Team_id";
                    pstmt = conn.prepareStatement(sql);
                    res = pstmt.executeQuery();

                    while (res.next()) {
                        String instructorname = res.getString(1);
                        String teamid = res.getString(2);
                        System.out.println("강사명: " + instructorname + ", 맡은 팀 id: " + teamid);
                    }
                    res.close();
                    System.out.println();
                    break;
                case 2:
                    System.out.println("종목 & 월급 -> 강사 검색");
                    System.out.print("종목: ");
                    String sports = scanner.nextLine();
                    System.out.print("월급: ");
                    int salary = scanner.nextInt();
                    scanner.nextLine();
                    System.out.println();

                    sql = "SELECT instructor_id, name, phone_number, salary\r\n" + "FROM INSTRUCTOR\r\n" + "WHERE sports=? and salary=?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, sports);
                    pstmt.setInt(2, salary);
                    res = pstmt.executeQuery();

                    while (res.next()) {
                        String instructor_id = res.getString(1);
                        String name = res.getString(2);
                        String phone_number = res.getString(3);
                        int salary2 = res.getInt(4);
                        System.out.println("강사 id: " + instructor_id + ", 이름: " + name + ", 연락처: " + phone_number + ", 월급: " + salary2);
                    }
                    res.close();
                    System.out.println();
                    break;
                case 3:
                    return;
                default:
                    System.out.println("1~2 사이의 값을 선택해주세요\n");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
