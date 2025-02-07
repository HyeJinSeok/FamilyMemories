package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import repository.PostRepository;

@WebServlet("/post")
public class PostController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PostRepository postRepository;

    public PostController() {
        this.postRepository = new PostRepository();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        // 📌 세션 확인 및 `uid`, `fid` 가져오기
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null || session.getAttribute("fid") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        int uid = (int) session.getAttribute("userId");
        int fid = (int) session.getAttribute("fid");

        // 📌 폼 데이터 가져오기
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String location = request.getParameter("location");
        String imgsrc = request.getParameter("imgsrc");

        // 📌 필수 값 확인 (빈 값 방지)
        if (title == null || title.trim().isEmpty() || 
            description == null || description.trim().isEmpty() ||
            startDate == null || startDate.trim().isEmpty() ||
            endDate == null || endDate.trim().isEmpty() ||
            location == null || location.trim().isEmpty() ||
            imgsrc == null || imgsrc.trim().isEmpty()) {
            
            response.sendRedirect(request.getContextPath() + "/post?status=failure");
            return;
        }

        // 📌 DB에 INSERT 실행
        boolean isInserted = postRepository.insertPost(title, description, startDate, endDate, location, imgsrc, fid, uid);

        // 📌 성공 여부에 따라 페이지 이동
        if (isInserted) {
            response.sendRedirect(request.getContextPath() + "/post?status=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/post?status=failure");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.getRequestDispatcher("/views/jsp/post.jsp").forward(request, response);
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
