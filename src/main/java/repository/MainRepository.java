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

    //가족에 속한 모든 게시글 조회
    public static List<Post> getPostsByFamilyId(int fid) {
        List<Post> postList = new ArrayList<>();
        String sql = "SELECT * FROM Post WHERE fid = ? ORDER BY start_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, fid);
            ResultSet rs = stmt.executeQuery();

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
