package utils;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    private static String URL;
    private static String USER ;
    private static String PASSWORD;
    private static String Driver;
    
    static {
        try {
            Properties properties = new Properties();
            // 설정 파일 로드
            properties.load(new FileInputStream("????/resources/dbconfig.properties"));

            URL = properties.getProperty("db.url");
            USER = properties.getProperty("db.username");
            PASSWORD = properties.getProperty("db.password");
            Driver = properties.getProperty("db.driver");

            // JDBC 드라이버 로드
            Class.forName(Driver);
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            throw new RuntimeException("DB 로드 실패");
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

	public static void close(Connection conn, PreparedStatement pstmt) {
		// TODO Auto-generated method stub
		
	}
}
