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
    private PostRepository postRepository;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        
        // 세션 가져오기
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null || session.getAttribute("fid") == null) {
            response.sendRedirect(request.getContextPath() + "/views/jsp/login.jsp");
            return;
        }
        
        int userId = (int) session.getAttribute("userId");
        int fid = (int) session.getAttribute("fid");
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String location = request.getParameter("location");
        String imgsrc = request.getParameter("imgsrc");
        
        boolean isInserted = postRepository.insertPost(title, description, startDate, endDate, location, imgsrc, fid);
        
        response.sendRedirect(request.getContextPath() + "/views/jsp/post.jsp?status=" + (isInserted ? "success" : "failure"));
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.getRequestDispatcher("/views/jsp/post.jsp").forward(request, response); //
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}