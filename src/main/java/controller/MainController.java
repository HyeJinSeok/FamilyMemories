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
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/main")
public class MainController extends HttpServlet {
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

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
            List<Post> postList = MainRepository.getPostsByFamilyId(userFid);
            List<String> postTitles = postList.stream().map(Post::getTitle).collect(Collectors.toList());
            sendJsonResponse(response, postTitles);
        } else if ("schedule".equals(type)) {
            // 일정 목록 JSON 응답 (ISO 8601 형식 날짜 변환)
            List<Scheduler> scheduleList = SchedulerRepository.getSchedulesByFamilyId(userFid);
            List<SchedulerDTO> scheduleDTOs = scheduleList.stream().map(s -> 
                new SchedulerDTO(s.getTitle(), dateFormat.format(s.getStartDate()), dateFormat.format(s.getEndDate()), s.getLocation())
            ).collect(Collectors.toList());
            sendJsonResponse(response, scheduleDTOs);
        } else if (isAjax) {
            List<Post> postList = MainRepository.getPostsByFamilyId(userFid);
            sendJsonResponse(response, postList);
        } else {
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

    private static class SchedulerDTO {
        String title, start, end, location;

        public SchedulerDTO(String title, String start, String end, String location) {
            this.title = title;
            this.start = start;
            this.end = end;
            this.location = location;
        }
    }
}

