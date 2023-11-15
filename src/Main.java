import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Main {
    // 오라클 데이터베이스 접속 정보
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static final String USER = "university";
    private static final String PASSWORD = "comp322";

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        while(true) {
            System.out.println("로그인");
            System.out.print("사용자 이름: ");
            String username = scanner.nextLine();

            System.out.print("비밀번호: ");
            String password = scanner.nextLine();

            if (login(username, password)) {
                System.out.println("로그인 성공!");
                break;
            } else {
                System.out.println("로그인 실패. 사용자 이름 또는 비밀번호가 잘못되었습니다.");
            }
        }
        // 스캐너 닫기
        scanner.close();
    }

    private static boolean login(String username, String password) {
        try {
            // JDBC 드라이버 로딩
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // 데이터베이스 연결
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);

            // SQL 쿼리 작성
            String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
            try (PreparedStatement preparedStatement = conn.prepareStatement(sql)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);

                // 쿼리 실행 및 결과 확인
                try (ResultSet res = preparedStatement.executeQuery()) {
                    return res.next(); // 결과가 있으면 로그인 성공
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
