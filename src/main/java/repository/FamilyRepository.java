package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import domain.Family;
import utils.DBConnection;

public class FamilyRepository {

    public Family getFamilyById(int fid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Family family = null;

        try {
            conn = DBConnection.getConnection();
            String sql = "SELECT * FROM Family WHERE fid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, fid);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                family = new Family(
                    rs.getInt("fid"),
                    rs.getString("fname"),
                    rs.getString("fdescription")
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DBConnection.close(conn, pstmt, rs);
        }

        return family;
    }
}
