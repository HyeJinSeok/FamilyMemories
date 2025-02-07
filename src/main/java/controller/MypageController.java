package controller;

import java.io.IOException;
import java.util.List;

import domain.Family;
import domain.Post;
import domain.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import repository.FamilyRepository;
import repository.PostRepository;
import repository.UserRepository;

@WebServlet("/mypage")
public class MypageController extends HttpServlet {
    private PostRepository postRepository;
    private FamilyRepository familyRepository;
    private UserRepository userRepository;

    public MypageController() {
        this.postRepository = new PostRepository();
        this.familyRepository = new FamilyRepository();
        this.userRepository = new UserRepository();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 세션 가져오기
        HttpSession session = request.getSession(false); // 세션이 없으면 null 반환

        // 세션이 없거나 userId가 설정되지 않은 경우 로그인 페이지로 리디렉트
        if (session == null || session.getAttribute("userId") == null) {
        	response.sendRedirect(request.getContextPath() + "/views/jsp/login.jsp"); // 로그인 페이지로 이동
            return;
        }
    	
    	// 현재 로그인한 사용자의 ID 및 가족 그룹 ID 가져오기
        int userId = (int) request.getSession().getAttribute("userId");
        int fid = (int) request.getSession().getAttribute("fid");

        // 해당 사용자의 정보 조회
        User userInfo = userRepository.getUserById(userId);

        // 해당 사용자의 게시글 조회
        List<Post> myPosts = postRepository.getPostsByUserId(userId);
        
        // 해당 사용자의 가족 정보 조회
        Family family = familyRepository.getFamilyById(fid);
        
        // 같은 가족 그룹(fId)에 속하는 사용자 목록 조회
        List<User> familyMembers = userRepository.getUsersByFamilyId(fid);

        // 조회한 데이터를 request에 저장
        request.setAttribute("userInfo", userInfo);
        request.setAttribute("myPosts", myPosts);
        request.setAttribute("family", family);
        request.setAttribute("familyMembers", familyMembers);

        // mypage.jsp로 포워딩
        request.getRequestDispatcher("/views/jsp/mypage.jsp").forward(request, response);
        
        try {
            request.getRequestDispatcher("/views/jsp/mypage.jsp").forward(request, response); //
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
}
