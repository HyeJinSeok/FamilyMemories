package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import domain.Post;
import domain.User;
import utils.DBConnection;

public class UserRepository {

	// 사용자 ID로 사용자 정보 가져오기
	public User getUserById(int userId) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		User user = null;

		try {
			conn = DBConnection.getConnection();
			String sql = "SELECT * FROM User WHERE uid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				user = new User();
				user.setUid(rs.getInt("uid"));
				user.setName(rs.getString("name"));
				user.setId(rs.getString("id"));
				user.setPw(rs.getString("pw"));
				user.setEmail(rs.getString("email"));
				user.setFid(rs.getInt("fid"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(conn, pstmt, rs);
		}
		return user;
	}

	// 특정 가족 그룹의 사용자 목록 가져오기
	public List<User> getUsersByFamilyId(int fid) {
		List<User> userList = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();
			String sql = "SELECT * FROM User WHERE fid = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, fid);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				User user = new User();
				user.setUid(rs.getInt("uid"));
				user.setName(rs.getString("name"));
				user.setId(rs.getString("id"));
				user.setPw(rs.getString("pw"));
				user.setEmail(rs.getString("email"));
				user.setFid(rs.getInt("fid"));
				userList.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(conn, pstmt, rs);
		}
		return userList;
	}

	    // 사용자 회원 가입 
	    public boolean registerUser(User user) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        try {
	            conn = DBConnection.getConnection();
	            String sql = "INSERT INTO User (id, name, pw, email, fid) VALUES (?, ?, ?, ?, ?)";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, user.getId()); // 아이디 저장
	            pstmt.setString(2, user.getName());
	            pstmt.setString(3, user.getPw()); // 해싱된 비밀번호 저장
	            pstmt.setString(4, user.getEmail());
	            pstmt.setInt(5, user.getFid());
	            
	            int rowsInserted = pstmt.executeUpdate();
	            return rowsInserted > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	            return false;
	        } finally {
	            DBConnection.close(conn, pstmt);
	        }
	    }
	    
	    public boolean isIdDuplicate(String id) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        try {
	            conn = DBConnection.getConnection();
	            String sql = "SELECT COUNT(*) FROM User WHERE id = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, id);
	            rs = pstmt.executeQuery();

	            if (rs.next() && rs.getInt(1) > 0) {
	                return true; // 중복 있음
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            DBConnection.close(conn, pstmt, rs);
	        }
	        return false; // 중복 없음
	    }

	    public boolean isEmailDuplicate(String email) {
	        Connection conn = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        try {
	            conn = DBConnection.getConnection();
	            String sql = "SELECT COUNT(*) FROM User WHERE email = ?";
	            pstmt = conn.prepareStatement(sql);
	            pstmt.setString(1, email);
	            rs = pstmt.executeQuery();

	            if (rs.next() && rs.getInt(1) > 0) {
	                return true; // 중복 있음
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            DBConnection.close(conn, pstmt, rs);
	        }
	        return false; // 중복 없음
	    }

}