package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import repository.PostRepository;

@WebServlet("/post")
public class PostController extends HttpServlet {
    private PostRepository postRepository;

    public PostController() {
        this.postRepository = new PostRepository();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");
        String location = request.getParameter("location");
        String imgsrc = request.getParameter("imgsrc");
        int fid = Integer.parseInt(request.getParameter("fid"));
        
        boolean isInserted = postRepository.insertPost(title, description, startDate, endDate, location, imgsrc, fid);
        
        response.sendRedirect("post.jsp?status=" + (isInserted ? "success" : "failure"));
    }
}
