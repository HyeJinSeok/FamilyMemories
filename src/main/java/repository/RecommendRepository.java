package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import domain.Recommend;
import utils.DBConnection;

public class RecommendRepository {
	public static ArrayList<Recommend> getRecommend() throws Exception{
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<Recommend> all = null;
		try {
			con = DBConnection.getConnection();
			pstmt = con.prepareStatement("select * from Recommend");
			rs = pstmt.executeQuery();
			
			all = new ArrayList<>();
			while(rs.next()) {
				all.add(new Recommend(rs.getString("title"), rs.getString("description"),rs.getInt("priority")));
			}
			return all;
		}finally {
			DBConnection.close(con, pstmt, rs);
		}
	}

}
