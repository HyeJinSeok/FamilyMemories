package utils;

import org.mindrot.jbcrypt.BCrypt;

public class SecurityUtil {

    // 비밀번호 해싱
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    // 비밀번호 검증
    public static boolean checkPassword(String inputPassword, String hashedPassword) {
        return BCrypt.checkpw(inputPassword, hashedPassword);
    }
}
