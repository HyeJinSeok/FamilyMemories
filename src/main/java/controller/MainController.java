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
        String type = request.getParameter("type");  // 요청 타입 확인 (전체 또는 제목)
        
        if ("titles".equals(type)) {
            // 제목만 가져오는 경우
            List<Post> postList = MainRepository.getAllPosts();
            List<String> postTitles = postList.stream()
                                              .map(Post::getTitle)
                                              .collect(Collectors.toList());
            String jsonResponse = new Gson().toJson(postTitles);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(jsonResponse);
        } else {
            // 전체 게시글 정보를 가져오는 경우
            List<Post> postList = MainRepository.getAllPosts();
            String jsonResponse = new Gson().toJson(postList);

            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(jsonResponse);
        }
        
        try {
            request.getRequestDispatcher("/views/jsp/main.jsp").forward(request, response); //
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

}