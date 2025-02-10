package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import domain.Post;
import repository.MainRepository;
import com.google.gson.Gson;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/main")
public class MainController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false); // 세션 가져오기
        Integer userFid = (session != null) ? (Integer) session.getAttribute("userFid") : null; // 가족 ID 가져오기

        if (userFid == null) {
            // 로그인하지 않은 경우 또는 세션이 없는 경우, 로그인 페이지로 리디렉트
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String type = request.getParameter("type");  // 요청 타입 확인 (예: "titles" 등)
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if ("titles".equals(type)) {
            // 제목만 가져오는 요청일 경우
            List<Post> postList = MainRepository.getPostsByFamilyId(userFid); // 가족 ID 기준으로 게시물 조회
            List<String> postTitles = postList.stream()
                                              .map(Post::getTitle)
                                              .collect(Collectors.toList());
            String jsonResponse = new Gson().toJson(postTitles);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(jsonResponse);
            return;
        } else if (isAjax) {
            // Ajax 요청인 경우 가족 게시물 정보를 JSON으로 응답
            List<Post> postList = MainRepository.getPostsByFamilyId(userFid); // 가족 게시물 조회
            String jsonResponse = new Gson().toJson(postList);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(jsonResponse);
            return;
        } else {
            // 일반 브라우저 요청인 경우 JSP 포워드
            request.setAttribute("familyPosts", MainRepository.getPostsByFamilyId(userFid)); // JSP에서 접근 가능하도록 전달
            request.getRequestDispatcher("/views/jsp/main.jsp").forward(request, response);
        }
    }
}

