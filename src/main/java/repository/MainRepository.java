package repository;

import utils.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class MainRepository {

    // 게시글 수 가져오기 예제
    public int getPostCount() {
        int postCount = 0;
        String sql = "SELECT COUNT(*) FROM Post";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                postCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return postCount;
    }

    // 사용자 수 가져오기 예제
    public int getUserCount() {
        int userCount = 0;
        String sql = "SELECT COUNT(*) FROM User";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            if (rs.next()) {
                userCount = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userCount;
    }
}