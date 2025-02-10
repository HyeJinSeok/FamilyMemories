package domain;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Scheduler {
    private int sid;          // 일정 ID (Primary Key)
    private String title;     // 일정 제목
    private Date startDate;   // 시작 날짜
    private Date endDate;     // 종료 날짜
    private String location;  // 위치 (여행 장소)
    private int fid;          // 가족 ID (외래키)
    private int uid;          // 사용자 ID (외래키)
}