package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import domain.Post;
import domain.Scheduler;
import repository.MainRepository;
import repository.SchedulerRepository;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/main") // 기존처럼 /main에서 모든 데이터를 처리
public class MainController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userFid = (session != null) ? (Integer) session.getAttribute("userFid") : null;

        if (userFid == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String type = request.getParameter("type");
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));

        if ("titles".equals(type)) {
            // 게시글 제목 목록 JSON 응답
            List<Post> postList = MainRepository.getPostsByFamilyId(userFid);
            List<String> postTitles = postList.stream().map(Post::getTitle).collect(Collectors.toList());
            sendJsonResponse(response, postTitles);
        } else if ("schedule".equals(type)) {
            // 일정 목록 JSON 응답 (ScheduleController 기능 포함)
            List<Scheduler> scheduleList = SchedulerRepository.getSchedulesByFamilyId(userFid);
            sendJsonResponse(response, scheduleList);
        } else if (isAjax) {
            // 전체 게시글 JSON 응답
            List<Post> postList = MainRepository.getPostsByFamilyId(userFid);
            sendJsonResponse(response, postList);
        } else {
            // JSP 페이지로 포워딩 (게시글 + 일정 데이터 포함)
            request.setAttribute("familyPosts", MainRepository.getPostsByFamilyId(userFid));
            request.setAttribute("familySchedules", SchedulerRepository.getSchedulesByFamilyId(userFid));
            request.getRequestDispatcher("/views/jsp/main.jsp").forward(request, response);
        }
    }

    private void sendJsonResponse(HttpServletResponse response, Object data) throws IOException {
        String jsonResponse = new Gson().toJson(data);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(jsonResponse);
    }
}
