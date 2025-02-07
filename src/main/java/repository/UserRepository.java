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
				user.setId(rs.getInt("id"));
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
				user.setId(rs.getInt("id"));
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

}
