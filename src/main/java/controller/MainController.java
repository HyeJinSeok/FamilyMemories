package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/main")
public class MainController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // JSP로 요청 전달 (정확한 경로로 수정)
        request.getRequestDispatcher("/webapp/views/jsp/main.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // POST 요청 처리
        String action = request.getParameter("action");

        if ("mypage".equals(action)) {
            response.sendRedirect("mypage.jsp");
        } else if ("post".equals(action)) {
            response.sendRedirect("post.jsp");
        } else if ("recommend".equals(action)) {
            response.sendRedirect("recommend.jsp");
        } else {
            response.sendRedirect("main.jsp");
        }
    }
}
