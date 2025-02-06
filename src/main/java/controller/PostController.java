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
    private static final long serialVersionUID = 1L;
    private PostRepository postRepository;

    public PostController() {

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
        
        if (isInserted) {
            response.getWriter().write("Post successfully created!");
        } else {
            response.getWriter().write("Failed to create post.");
        }
    }
}