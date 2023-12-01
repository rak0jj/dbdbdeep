//package dbdbdeep;

import java.sql.*;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;
import java.util.regex.Pattern;


public class Main {
    public static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
    public static final String USER = "dbdbdeep";
    public static final String PASSWORD = "comp322";

//public static final String TABLE_NAMES[] = {"DEPARTMENT", "EMPLOYEE", "DEPT_LOCATIONS", "PROJECT", "WORKS_ON", "DEPENDENT"};
    //장락영 바보
    public static final String phoneNumberRegex = "\\d{3}-\\d{4}-\\d{4}";

    static List<String> location = Arrays.asList("서울특별시", "부산광역시", "대구광역시", "울산광역시", "광주광역시", "인천광역시", "대전광역시", "세종특별자치시", "제주특별자치도", "경기도", "경상북도", "경상남도", "충청북도", "충청남도", "전라북도", "전라남도", "강원도");

    static class User {
        public String id;
        public String name;
        public String sex;
        public int age;
        public int height;
        public String phone_number;
        public String address;

        public User(String id, String name, String sex, int age, int height, String phone_number, String address) {
            this.id = id;
            this.name = name;
            this.sex = sex;
            this.age = age;
            this.height = height;
            this.phone_number = phone_number;
            this.address = address;
        }
    }

    static User user;

    public static void main(String[] args) {

        Connection conn = null;
        try {
            // JDBC 드라이버 로딩
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("\nDriver loading: Success!");

            // 데이터베이스 연결
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Oracle Connected.\n");
            conn.setAutoCommit(false);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return;
        }
        Scanner scanner = new Scanner(System.in);
        boolean login_success = false;

        while (!login_success) {
            System.out.println("<< 스포츠 매칭 서비스 >>");
            System.out.println("-- 로그인 및 회원가입 --\n");
            System.out.println("1. 회원 가입");
            System.out.println("2. 로그인");

            System.out.print("카테고리 선택: ");
            int category = scanner.nextInt();
            scanner.nextLine();
            System.out.println();

            if (category == 1) {
                while (true) {
                    System.out.println("회원가입");
                    System.out.println("[주의사항] 아이디는 8자리 내로 만들어주시고, 비밀번호는 전화번호 형식(010-xxxx-xxxx)으로 만들어주세요!");
                    System.out.print("사용자 id: ");
                    String userid = scanner.nextLine();

                    System.out.print("비밀번호: ");
                    String password = scanner.nextLine();
                    System.out.println();

                    if (!userid.matches("\\d+") || userid.length() > 8 || !Pattern.matches(phoneNumberRegex, password)) {
                        System.out.println("ID혹은 비밀번호가 조건을 충족하지 않습니다");
                        continue;
                    }
                    if (signup(scanner, userid, password, conn)) {
                        System.out.println("가입을 축하드립니다! 로그인하고 서비스를 사용해주시기 바랍니다.\n");
                        break;
                    } else {
                        System.out.println("회원가입 실패. 다른 사용자의 아이디와 동일합니다.\n");
                    }
                }
            } else if (category == 2) {
                while (true) {
                    System.out.println("로그인");

                    System.out.print("사용자 id: ");
                    String userid = scanner.nextLine();

                    System.out.print("비밀번호: ");
                    String password = scanner.nextLine();

                    if (login(userid, password, conn)) {
                        System.out.println("로그인 성공!\n");

                        login_success = true;
                        break;
                    } else {
                        System.out.println("로그인 실패. 사용자 이름 또는 비밀번호가 잘못되었습니다.\n");
                    }
                }
            } else {
                System.out.println("1 또는 2의 값을 입력해주세요...");
            }
        }

        // 메인 기능
        boolean button_out = false;
        while (!button_out) {
            System.out.println("<< 스포츠 매칭 서비스 >>");
            System.out.println("---- 메인 화면 ----\n");
            System.out.println("1. 유저 관련 기능");
            System.out.println("2. 팀 관련 기능");
            System.out.println("3. 구장 관련 기능");
            System.out.println("4. 강사 관련 기능");
            System.out.println("5. 경기 관련 기능");
            System.out.println("6. 심판 관련 기능");
            System.out.println("7. 개인 정보 변경");
            System.out.println("8. 탈퇴하기");
            System.out.println("9. 프로그램 종료");

            System.out.print("카테고리 선택: ");
            int category = scanner.nextInt();
            scanner.nextLine();
            System.out.println();

            switch (category) {
                case 1:
                    userFunction(scanner, conn);
                    break;
                case 2:
                    teamFunction(scanner, conn);
                    break;
                case 3:
                    placeFunction(scanner, conn);
                    break;
                case 4:
                    instructorFunction(scanner, conn);
                    break;
                case 5:
                    matchFunction(scanner, conn);
                    break;
                case 6:
                    refereeFunction(scanner, conn);
                    break;
                case 7:
                    personalInfoChange(scanner, conn);
                    break;
                case 8:
                    if (signout(conn)) {
                        System.out.println("탈퇴 완료\n");
                    } else {
                        System.out.println("탈퇴 실패\n");
                    }
                    break;
                case 9:
                    button_out = true;
                    break;
                default:
                    System.out.println("1~9 사이의 숫자를 입력해주세요!");
            }
        }

        try {
            conn.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        // 스캐너 닫기
        scanner.close();
    }


    private static boolean login(String userid, String password, Connection conn) {

        try {
            if (conn == null) {
                System.out.println("데이터베이스 연결이 실패했습니다.");
                return false;
            }

            String sql = "SELECT * " + "FROM userp " + "WHERE user_id = ? " + "AND phone_number = ?";
            //String newuserid ='\''+userid+'\'';
            //String newpassword='\''+password+'\'';
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userid);
            pstmt.setString(2, password);
            ResultSet res = pstmt.executeQuery();

            // 쿼리 실행 및 결과 확인
            if (res.next()) { // 결과가 있으면 로그인 성공
//                user.id = res.getString(1);
//                user.name = res.getString(2);
//                user.sex = res.getString(3);
//                user.age = res.getInt(4);
//                user.height = res.getInt(5);
//                user.phone_number = res.getString(6);
//                user.address = res.getString(7);

                user = new User(
                        res.getString(1),
                        res.getString(2),
                        res.getString(3),
                        res.getInt(4),
                        res.getInt(5),
                        res.getString(6),
                        res.getString(7)
                );
                res.close();
//                conn.commit();
                return true;
            }
            res.close();
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private static boolean signup(Scanner scanner, String userid, String password, Connection conn) {
        // id 겹치는지 확인 -> 겹치면 다시 받기
        String sql = "SELECT * FROM userp WHERE user_id = ?";
        try {

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userid);
            ResultSet res = pstmt.executeQuery();
            if (res.next()) {
                return false;
            }
            String user_id, username, sex, phone_number, address, ageString, heightString;
            int age, height;
            while (true) {
                // id 안 겹치면 회원가입!
                user_id = userid;
                System.out.print("사용자 이름: ");
                username = scanner.nextLine();
                System.out.print("성별(M/F): ");
                sex = scanner.nextLine();
                System.out.print("나이: ");
                ageString = scanner.nextLine();
                System.out.print("신장: ");
                heightString = scanner.nextLine();
                phone_number = password;
                System.out.print("주소(도로명 주소): ");
                address = scanner.nextLine();

                String[] city = address.split("\\s+");
                if (!sex.equals("M") && !sex.equals("F")) {
                    System.out.println("성별은 'M'혹은 'F'로 입력해주세요");
                    continue;
                } else if (!ageString.matches("\\d+") || !heightString.matches("\\d+")) {
                    System.out.println("나이와 키는 숫자로 입력해주세요");
                    continue;
                } else {
                    age = Integer.parseInt(ageString);
                    height = Integer.parseInt(heightString);
                    if (age < 0 || age > 130 || height < 1 || height > 300 || !location.contains(city[0])) {
                        System.out.println("이상한 값이 있습니다");
                        continue;
                    }
                    break;
                }
            }

            sql = "INSERT INTO userp VALUES(?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, user_id);
            pstmt.setString(2, username);
            pstmt.setString(3, sex);
            pstmt.setInt(4, age);
            pstmt.setInt(5, height);
            pstmt.setString(6, phone_number);
            pstmt.setString(7, address);

            pstmt.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    private static boolean signout(Connection conn) {
        // SQL 쿼리 작성
        String sql = "DELETE FROM userp WHERE user_id = ?";

        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.id);
            try {
                pstmt.executeUpdate();
            } catch (Exception ex) {
                System.out.println(ex.getMessage());
                return false;
            }
            conn.commit();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }

    private static void personalInfoChange(Scanner scanner, Connection conn) {
        try {
            System.out.println("---- 메인 화면 ----\n");
            System.out.println("1. 연락처 변경");
            System.out.println("2. 주소 변경");
            System.out.println("3. 뒤로가기");

            System.out.print("카테고리 선택: ");
            int category = scanner.nextInt();
            scanner.nextLine();
            System.out.println();

            String sql;
            PreparedStatement pstmt = null;
            switch (category) {
                case 1:
                    String phone_number;
                    while (true) {
                        System.out.print("변경할 연락처: ");
                        phone_number = scanner.nextLine();
                        if (Pattern.matches(phoneNumberRegex, phone_number)) {
                            break;
                        } else {
                            System.out.println("전화번호가 조건을 충족하지 않습니다.");
                        }
                    }
                    sql = "UPDATE userp SET phone_number = ? WHERE user_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, phone_number);
                    pstmt.setString(2, user.id);
                    user.phone_number = phone_number;
                    break;
                case 2:
                    String address;
                    while (true) {
                        System.out.println("변경할 주소: ");
                        address = scanner.nextLine();
                        String[] city = address.split("\\s");
                        if (location.contains(city[0])) {
                            break;
                        } else {
                            System.out.println("주소가 조건을 충족하지 않습니다.");
                        }
                    }
                    sql = "UPDATE userp SET address = ? WHERE user_id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, user.id);
                    pstmt.setString(1, address);
                    user.address = address;
                    break;
                case 3:
                    return;
                default:
                    System.out.println("1~3 사이의 값을 선택해주세요\n");
            }

            if (pstmt != null) {
                pstmt.executeUpdate();
                conn.commit();
            }
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

    private static void userFunction(Scanner scanner, Connection conn) {
        try {

            System.out.println("-- 다른 유저 정보 검색\n");
            System.out.println("검색을 원하는 유저의 이름을 입력해주세요.");
            System.out.print("이름: ");
            String name = scanner.nextLine();

            String sql = "SELECT user_id, sex, age, height, phone_number\r\n" + "FROM UserP \r\n" + "WHERE name = ?";
            ResultSet res = null;

            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);

            // 쿼리 실행 및 결과 확인
            res = pstmt.executeQuery();
            System.out.println("검색 결과: '" + name + "'님의 정보");
            while (res.next()) {
                String user_id = res.getString(1);
                String sex = res.getString(2);
                int age = res.getInt(3);
                int height = res.getInt(4);
                String phone_number = res.getString(5);
                System.out.println("아이디: " + user_id + ", 성별: " + sex + ", 나이: " + age + ", 키: " + height + ", 연락처: " + phone_number);
            }
            res.close();
            System.out.println();
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

    private static void teamFunction(Scanner scanner, Connection conn) {
        try {

            System.out.println("-- 팀 관련 기능");
            System.out.println("실행할 기능 목록");
            System.out.println("1. 팀 가입");
            System.out.println("2. 소속 팀 검색");
            System.out.println("3. 소속 팀 탈퇴");
            System.out.println("4. 뒤로가기");
            System.out.print("카테고리 선택: ");
            int category = scanner.nextInt();
            scanner.nextLine();
            System.out.println();

            String sql;
            PreparedStatement pstmt = null;
            switch (category) {
                case 1:
                    System.out.print("가입할 팀 id: ");
                    String team_id = scanner.nextLine();
                    sql = "INSERT INTO participate VALUES(?,?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, user.id);
                    pstmt.setString(2, team_id);
                    pstmt.executeUpdate();
                    conn.commit();
                    break;
                case 2:
                    System.out.println("나의 소속 팀");
                    sql = "SELECT U.name, T.team_id, T.sports, T.captain_id\r\n"
                            + "FROM UserP U, team T, participate P\r\n"
                            + "WHERE U.user_id = P.puser_id AND P.pteam_id = T.team_id AND U.name = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, user.name);

                    ResultSet res = pstmt.executeQuery();
                    System.out.println("당신의 소속팀 정보");
                    while (res.next()) {
                        String name = res.getString(1);
                        String teamID = res.getString(2);
                        String sports = res.getString(3);
                        String captainID = res.getString(4);
                        System.out.println("이름: " + name + ", 소속 팀 id: " + teamID + ", 종목: " + sports + ", 팀 주장 id: " + captainID);
                    }
                    res.close();
                    System.out.println();
                    break;
                case 3:
                    sql = "DELETE FROM participate WHERE puser_id = ? and pteam_id = ?";

                    System.out.print("탈퇴할 팀 id: ");
                    team_id = scanner.nextLine();
                    try {
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, user.id);
                        pstmt.setString(2, team_id);
                        try {
                            pstmt.executeUpdate();
                            conn.commit();
                            System.out.println(team_id + "팀에서 탈퇴하였습니다.");
                        } catch (Exception ex) {
                            System.out.println(ex.getMessage());
                            return;
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        return;
                    }
                    return;
                case 4:
                    return;
                default:
                    System.out.println("1~3 사이의 값을 선택해주세요\n");
            }
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }


    private static void placeFunction(Scanner scanner, Connection conn) {
        try {

            System.out.println("-- 구장 관련 기능");
            System.out.println("실행할 기능 목록");
            System.out.println("1. 내 주변 구장 목록");
            System.out.println("2. 지역별 구장 수");
            System.out.println("3. 뒤로가기");
            System.out.print("카테고리 선택: ");
            int category = scanner.nextInt();
            scanner.nextLine();
            System.out.println();

            String sql = "";
            PreparedStatement pstmt = null;
            ResultSet res = null;
            switch (category) {
//                case 1:
//                    String[] addressList = user.name.split("\\s");
//                    String city = addressList[0] + '%';
//
//                    System.out.println("내 주변 구장 목록");
                case 1:
                    String[] addressList = user.address.split("\\s");
                    String city = addressList[0] + '%';

                    System.out.println("내 주변 구장 목록");

                    sql = "SELECT Place_id, Location\r\n" + "FROM place\r\n" + "WHERE Place_id IN (\r\n" + "         SELECT Mplace_id\r\n" + "         FROM game\r\n" + "         WHERE Mplace_id IN (\r\n" + "                  SELECT Place_id\r\n" + "                  FROM place\r\n" + "                  WHERE Location LIKE ?\r\n" + "         )\r\n" + ")";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, city);
                    res = pstmt.executeQuery();

                    while (res.next()) {
                        String placeID = res.getString(1);
                        String location = res.getString(2);
                        System.out.println("구장 id: " + placeID + ", 위치: " + location);
                    }
                    res.close();
                    System.out.println();
                    break;
                case 2:
                    //총 17개
                    System.out.println("지역별 구장 수");
//                    for (int i = 0; i < 16; i++) {
//                        sql += "SELECT ? AS Location, COUNT(*) AS StadiumCount\r\n" + "FROM place\r\n" + "WHERE Location LIKE ?\r\n" + "UNION";
//                    }
//                    sql += "SELECT ? AS Location, COUNT(*) AS StadiumCount\r\n" + "FROM place\r\n" + "WHERE Location LIKE ?";

                    for (int i = 0; i < 16; i++) {
                        sql += "SELECT ? AS Location, COUNT(*) AS StadiumCount\r\n"
                                + "FROM place\r\n"
                                + "WHERE Location LIKE ?\r\n"
                                + "UNION\r\n";
                    }
                    sql += "SELECT ? AS Location, COUNT(*) AS StadiumCount\r\n"
                            + "FROM place\r\n"
                            + "WHERE Location LIKE ?";

                    pstmt = conn.prepareStatement(sql);
                    for (int i = 0; i < 17; i++) {
                        String cityname = location.get(i);
                        pstmt.setString(i * 2 + 1, cityname);
                        pstmt.setString(i * 2 + 2, cityname + '%');
                    }

                    res = pstmt.executeQuery();
                    while (res.next()) {
                        String cityname = res.getString(1);
                        int stadiumNum = res.getInt(2);
                        System.out.println("지역명: " + cityname + ", 구장 수: " + stadiumNum);
                    }
                    res.close();
                    System.out.println();
                    break;
                case 3:
                    return;
                default:
                    System.out.println("1~3 사이의 값을 선택해주세요\n");
            }
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

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

            String sql = "";
            PreparedStatement pstmt = null;
            ResultSet res = null;
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
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

    private static void matchFunction(Scanner scanner, Connection conn) {
        try {
            System.out.println("-- 경기 관련 기능");
            System.out.println("실행할 기능 목록");
            System.out.println("1. 월별 경기 정보");
            System.out.println("2. 지역별 경기 정보");
            System.out.println("3. 뒤로가기");
            System.out.print("카테고리 선택: ");
            int category = scanner.nextInt();
            scanner.nextLine();
            System.out.println();

            String sql = "";
            PreparedStatement pstmt = null;
            ResultSet res = null;
            switch (category) {
                case 1:
                    System.out.println("월별 경기 정보");
                    System.out.print("종목: ");
                    String sports = scanner.nextLine();
                    System.out.print("월(ex. 01, ...,12): ");
                    String month = scanner.nextLine();
                    sql = "SELECT game_id, win_team, lose_team\r\n" + "FROM GAME\r\n" + "WHERE sports=? and to_date(game_date) LIKE ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, sports);
                    pstmt.setString(2, "23/" + month + "%");
                    res = pstmt.executeQuery();

                    while (res.next()) {
                        String gameid = res.getString(1);
                        String winteam = res.getString(2);
                        String loseteam = res.getString(3);
                        System.out.println("경기 id: " + gameid + ", 이긴 팀 id: " + winteam + ", 진 팀 id: " + loseteam);
                    }
                    res.close();
                    System.out.println();
                case 2:
                    System.out.println("지역별 경기 정보");
                    System.out.print("종목: ");
                    String sport = scanner.nextLine();
                    System.out.print("지역: ");
                    String location = scanner.nextLine();
                    System.out.println();

                    sql = "SELECT g.game_id, g.win_team, g.lose_team\r\n" + "FROM Game g, (SELECT *\r\n" + "              FROM Place p\r\n" + "              WHERE p.location LIKE ? and p.sports=?) pl\r\n" + "WHERE g.mplace_id=pl.place_id";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, sport);
                    pstmt.setString(2, location);
                    res = pstmt.executeQuery();

                    while (res.next()) {
                        String gameid = res.getString(1);
                        String winteam = res.getString(2);
                        String loseteam = res.getString(3);
                        System.out.println("경기 id: " + gameid + ", 이긴 팀 id: " + winteam + ", 진 팀 id: " + loseteam);
                    }
                    res.close();
                    System.out.println();
                case 3:
                    return;
                default:
                    System.out.println("1~3 사이의 값을 선택해주세요\n");
            }
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }

    private static void refereeFunction(Scanner scanner, Connection conn) {
        try {
            System.out.println("-- 심판 관련 기능");
            System.out.println("종목 & 월급 -> 심판 검색");
            System.out.print("종목: ");
            String sports = scanner.nextLine();
            System.out.print("월급: ");
            int salary = scanner.nextInt();
            scanner.nextLine();
            System.out.println();

            String sql = "(SELECT referee_id, name, phone_number, sports, salary\r\n" + "FROM REFEREE\r\n" + "WHERE sports=?)\r\n" + "INTERSECT\r\n" + "(SELECT referee_id, name, phone_number, sports, salary\r\n" + "FROM REFEREE\r\n" + "WHERE salary=?)";
            PreparedStatement pstmt = null;
            ResultSet res = null;

            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, sports);
            pstmt.setInt(2, salary);
            res = pstmt.executeQuery();

            while (res.next()) {
                String refereeid = res.getString(1);
                String name = res.getString(2);
                String phone_number = res.getString(3);
                String sport = res.getString(4);
                int salary2 = res.getInt(5);
                System.out.println("심판 id: " + refereeid + ", 이름: " + name + ", 연락처: " + phone_number + ", 종목: " + sport + ", 월급: " + salary2);
            }
            res.close();
            System.out.println();
            return;
        } catch (SQLException e) {
            e.printStackTrace();
            return;
        }
    }
}