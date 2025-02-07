package domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class Post {
    private int pid;            // 게시글 ID
    private String title;       // 제목
    private String description; // 설명
    private Date startDate;     // 시작 날짜
    private Date endDate;       // 끝 날짜
    private String location;    // 위치 정보
    private String imgsrc;      // 이미지 URL
    private int fid;            // 가족 그룹 ID

}
