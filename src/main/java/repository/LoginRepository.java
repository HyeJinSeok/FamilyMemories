package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import domain.User;
import utils.DBConnection;

public class LoginRepository {
    
    // DB에서 사용자 인증
    public User validateUser(String id, String pw) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        
        User user = null;
        
        //boolean isValid = false;

        try {
            conn = DBConnection.getConnection(); // DB 연결
            String sql = "SELECT * FROM User WHERE id = ? AND pw = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, pw);
            rs = pstmt.executeQuery();

            if (rs.next()) {
				user = new User();
				
				int i1 = rs.getInt("uid");
				user.setUid(i1);
				
				String i2 =rs.getString("name");
				user.setName(i2);
						
				String i3 = rs.getString("id");
				user.setId(i3);
				
				String i4 = rs.getString("pw");
				user.setPw(i4);
				
				String i5 = rs.getString("email");
				user.setEmail(i5);
				
				int i6 = rs.getInt("fid");
				user.setFid(i6);
				
				
			}else {
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
//        return isValid;
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
