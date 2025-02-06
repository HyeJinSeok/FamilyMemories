package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBConnection {
    // DataSource를 클래스 레벨의 정적 멤버로 선언
    private static DataSource ds;

    // static 초기화 블록
    static {
        try {
            Context initContext = new InitialContext();
            Context envContext  = (Context) initContext.lookup("java:/comp/env");
            ds = (DataSource) envContext.lookup("jdbc/fisaDB");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // DB 연결을 가져오는 메소드
    public static Connection getConnection() throws SQLException {
        return ds.getConnection();
    }

    // Connection과 Statement를 닫는 메소드
    public static void close(Connection con, Statement stmt) {
        try {
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
    }

    // Connection, Statement, ResultSet을 닫는 메소드
    public static void close(Connection con, Statement stmt, ResultSet rset) {
        try {
            if (rset != null) {
                rset.close();
            }
            if (stmt != null) {
                stmt.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
    }

	public static void close(Connection conn, PreparedStatement pstmt) {
		// TODO Auto-generated method stub
		
	}
}
