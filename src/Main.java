import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Main {
	
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:3orcl";
    private static final String USER = "university";
    private static final String PASSWORD = "comp322";
    public static final String TABLE_NAMES[] = {"DEPARTMENT","EMPLOYEE","DEPT_LOCATIONS","PROJECT","WORKS_ON","DEPENDENT"};

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        boolean login_success = false;
       
      while(!login_success) {
         System.out.println("  [스포츠 매칭 서비스]");
         System.out.println("-- 로그인 및 회원가입 --\n");
         System.out.println("1. 회원 가입");
         System.out.println("2. 로그인");
         
         System.out.print("카테고리 선택: ");
         int category = scanner.nextInt();
         
         if(category == 1) {
            while(true) {
               System.out.println("회원가입");
               System.out.println("주의사항- 아이디는 9자리 내로 만들어주시고, 비밀번호는 전화번호 형식(010-xxxx-xxxx)으로 만들어주세요!");
               System.out.print("사용자 이름: ");
                 String username = scanner.nextLine();

                 System.out.print("비밀번호: "); 
                 String password = scanner.nextLine();
                 
                 
                 if(signin(username,password)) {
                    System.out.println("가입을 축하드립니다! 로그인하고 서비스를 사용해주시기 바랍니다.\n");
                    break;
                 } else {
                    System.out.println("회원가입 실패... 아이디 또는 비밀번호 형식을 확인해주세요!\n");
                 }
            }
         }
         else if(category == 2) {
            while(true) {
               System.out.println("로그인");
                 
                 System.out.print("사용자 이름: ");
                 String username = scanner.nextLine();

                 System.out.print("비밀번호: "); 
                 String password = scanner.nextLine();

                 if (login(username, password)) {
                     System.out.println("로그인 성공!\n");
                     login_success = true;
                     break;
                 } else {
                     System.out.println("로그인 실패. 사용자 이름 또는 비밀번호가 잘못되었습니다.\n");
                 }
            }
         }
         else {
            
         }
        }

      // 스캐너 닫기
      scanner.close();
   }

   private static boolean login(String username, String password) {
      try {
         // JDBC 드라이버 로딩
            Class.forName("oracle.jdbc.driver.OracleDriver");
            System.out.println("Driver loading: Success!");
            // 데이터베이스 연결
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Oracle Connected.");
            conn.setAutoCommit(false);
            
            // SQL 쿼리 작성
            String sql = "SELECT * FROM userp WHERE user_id = ? AND phone_number = ?";
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
   
   private static boolean signin(String username, String password) {
      return true;
   }
}