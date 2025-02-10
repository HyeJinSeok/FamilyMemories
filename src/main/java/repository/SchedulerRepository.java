package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import domain.Scheduler;
import utils.DBConnection;

public class SchedulerRepository {

    // 가족 ID에 속한 모든 일정 가져오기
    public static List<Scheduler> getSchedulesByFamilyId(int fid) {
        List<Scheduler> scheduleList = new ArrayList<>();
        String sql = "SELECT * FROM Scheduler WHERE fid = ? ORDER BY start_date";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, fid);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Scheduler schedule = new Scheduler(
                        rs.getInt("sid"),
                        rs.getString("title"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getString("location"),
                        rs.getInt("fid"),
                        rs.getInt("uid")
                );
                scheduleList.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return scheduleList;
    }
}
