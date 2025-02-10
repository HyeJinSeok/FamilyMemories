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
import java.util.stream.Collectors;

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
        String type = request.getParameter("type");  // 요청 타입 확인
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if ("titles".equals(type)) {
            List<Post> postList = MainRepository.getAllPosts();
            List<String> postTitles = postList.stream()
                                              .map(Post::getTitle)
                                              .collect(Collectors.toList());
            String jsonResponse = new Gson().toJson(postTitles);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(jsonResponse);
            return; // JSON 응답만 전송
        } else if (isAjax) {
            // Ajax 요청인 경우 전체 게시글 정보를 JSON으로 응답
            List<Post> postList = MainRepository.getAllPosts();
            String jsonResponse = new Gson().toJson(postList);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(jsonResponse);
            return;
        } else {
            // 일반 브라우저 요청인 경우 JSP 포워드
            request.getRequestDispatcher("/views/jsp/main.jsp").forward(request, response);
        }
    }

}