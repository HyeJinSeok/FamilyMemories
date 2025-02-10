package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.User;
import utils.DBConnection;
import utils.SecurityUtil;

public class LoginRepository {
    
    // DB에서 사용자 인증
    public User validateUser(String id, String pw) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM User WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("uid"),
                    rs.getString("name"),
                    rs.getString("id"),
                    rs.getString("pw"),
                    rs.getString("email"),
                    rs.getInt("fid")
                );
            } else {
                throw new IllegalArgumentException("찾는 사용자가 없습니다.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return user;
    }
    
    public boolean isUserIdExists(String id) throws Exception {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DBConnection.getConnection();

			pstmt = con.prepareStatement("SELECT * FROM User WHERE id = ? AND pw = ?");

			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next() && rs.getInt(1) > 0) {
				return true;
			}

		} finally {
			DBConnection.close(con, pstmt);
		}
		return false;
	}
    
    
    
}
