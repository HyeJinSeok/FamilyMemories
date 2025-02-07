package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import domain.Post;
import repository.MainRepository;
import repository.PostRepository;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.List;

@WebServlet("/main")
public class MainController extends HttpServlet {

    private PostRepository postRepository;

    @Override
    public void init() {
        // PostRepository 초기화
        postRepository = new PostRepository();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 전체 게시글 조회 후 JSON으로 변환하여 클라이언트에 응답
        List<Post> postList = MainRepository.getAllPosts();
        String postJson = new Gson().toJson(postList);
        
        // 응답 설정: JSON 타입, UTF-8 인코딩
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(postJson);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // POST 요청에서 action 파라미터에 따라 페이지 이동 처리
        String action = request.getParameter("action");

        if ("mypage".equals(action)) {
            // 마이페이지로 리디렉션
            response.sendRedirect("mypage.jsp");
        } else if ("post".equals(action)) {
            // 게시글 페이지로 리디렉션
            response.sendRedirect("post.jsp");
        } else if ("recommend".equals(action)) {
            // 추천 페이지로 리디렉션
            response.sendRedirect("recommend.jsp");
        } else {
            // 기본적으로 메인 페이지로 리디렉션
            response.sendRedirect("main.jsp");
        }
    }
}
