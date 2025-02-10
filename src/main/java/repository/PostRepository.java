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
        PreparedStatement pstmtPost = null;
        PreparedStatement pstmtScheduler = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false); // 트랜잭션 시작 (둘 중 하나라도 실패하면 롤백)

            // Post 테이블
            String sqlPost = "INSERT INTO Post (title, description, start_date, end_date, location, imgsrc, fid, uid) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmtPost = conn.prepareStatement(sqlPost);
            pstmtPost.setString(1, title);
            pstmtPost.setString(2, description);
            pstmtPost.setString(3, startDate);
            pstmtPost.setString(4, endDate);
            pstmtPost.setString(5, location);
            pstmtPost.setString(6, imgsrc);
            pstmtPost.setInt(7, fid);
            pstmtPost.setInt(8, uid);

            int postInserted = pstmtPost.executeUpdate();

            // Scheduler 테이블
            String sqlScheduler = "INSERT INTO Scheduler (title, start_date, end_date, location, fid, uid) VALUES (?, ?, ?, ?, ?, ?)";
            pstmtScheduler = conn.prepareStatement(sqlScheduler);
            pstmtScheduler.setString(1, title);
            pstmtScheduler.setString(2, startDate);
            pstmtScheduler.setString(3, endDate);
            pstmtScheduler.setString(4, location);
            pstmtScheduler.setInt(5, fid);
            pstmtScheduler.setInt(6, uid);

            int schedulerInserted = pstmtScheduler.executeUpdate();

            //둘 다 성공해야 커밋
            if (postInserted > 0 && schedulerInserted > 0) {
                conn.commit();
                return true;
            } else {
                conn.rollback(); // 하나라도 실패하면 롤백
                return false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // 예외 발생 시 롤백
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        } finally {
            DBConnection.close(conn, pstmtPost);
            DBConnection.close(null, pstmtScheduler);
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


