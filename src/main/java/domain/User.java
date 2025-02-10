package domain;

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
public class User {
    private int uid;       // Primary Key(순서)
    private String name;   // 사용자 이름
    private String id;     // 로그인 ID 
    private String pw;     // 비밀번호 (해싱된 형태로 저장해야 함)
    private String email;  // 이메일
    private int fid;       // 가족 그룹 ID (Foreign Key)
}
