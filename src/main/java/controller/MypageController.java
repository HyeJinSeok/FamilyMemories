package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import domain.Post;
import repository.PostRepository;

@WebServlet("/mypage")
public class MypageController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 현재 로그인한 사용자의 ID 가져오기 (세션에서 userId 값 사용)
        int userId = (int) request.getSession().getAttribute("userId"); 

        // 해당 사용자의 게시글 조회
        List<Post> myPosts = postRepository.getPostsByUserId(userId);

        // 조회한 게시글 리스트를 request에 저장
        request.setAttribute("myPosts", myPosts);

        // mypage.jsp로 포워딩
        request.getRequestDispatcher("/views/jsp/mypage.jsp").forward(request, response);
    }
}
