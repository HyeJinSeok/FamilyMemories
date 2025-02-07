package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.Post;
import utils.DBConnection;

public class PostRepository {

    public boolean insertPost(String title, String description, String startDate, String endDate, String location, String imgsrc, int fid, int uid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            
            String sql = "INSERT INTO Post (title, description, start_date, end_date, location, imgsrc, fid, uid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, description);
            pstmt.setString(3, startDate);
            pstmt.setString(4, endDate);
            pstmt.setString(5, location);
            pstmt.setString(6, imgsrc);
            pstmt.setInt(7, fid);
            pstmt.setInt(8, uid);
            
            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.close(conn, pstmt);
        }
    }
    
	// 사용자 ID로 해당 사용자가 작성한 게시글 가져오기
	public List<Post> getPostsByUserId(int userId) {
		List<Post> postList = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = DBConnection.getConnection();
			String sql = "SELECT * FROM Post WHERE uid = ? ORDER BY start_date DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, userId);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Post post = new Post();
				post.setPid(rs.getInt("pid"));
				post.setTitle(rs.getString("title"));
				post.setDescription(rs.getString("description"));
				post.setStartDate(rs.getDate("start_date"));
				post.setEndDate(rs.getDate("end_date"));
				post.setLocation(rs.getString("location"));
				post.setImgsrc(rs.getString("imgsrc"));
				post.setFid(rs.getInt("fid"));
				postList.add(post);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DBConnection.close(conn, pstmt, rs);
		}
		return postList;
	}
}

