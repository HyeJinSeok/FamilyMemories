package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import domain.Post;
import utils.DBConnection;

public class MainRepository {

    // 전체 게시글 조회 메서드
    public static List<Post> getAllPosts() {
        List<Post> postList = new ArrayList<>();
        String sql = "SELECT * FROM Post";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Post post = new Post(
                        rs.getInt("pid"),
                        rs.getString("title"),
                        rs.getString("description"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getString("location"),
                        rs.getString("imgsrc"),
                        rs.getInt("fid")
                );
                postList.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return postList;
    }
}