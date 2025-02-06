package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import utils.DBConnection;

public class PostRepository {

    public boolean insertPost(String title, String description, String startDate, String endDate, String location, String imgsrc, int fid) {
        Connection conn = null;
            String sql = "INSERT INTO Post (title, description, start_date, end_date, location, imgsrc, fid) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, description);
            pstmt.setString(3, startDate);
            pstmt.setString(4, endDate);
            pstmt.setString(5, location);
            pstmt.setString(6, imgsrc);
            pstmt.setInt(7, fid);
            
            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DBConnection.close(conn, pstmt);
        }
    }
}
