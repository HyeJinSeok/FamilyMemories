package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import domain.Scheduler;
import repository.SchedulerRepository;
import com.google.gson.Gson;
import java.io.IOException;
import java.util.List;

@WebServlet("/schedule")
public class ScheduleController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Integer userFid = (session != null) ? (Integer) session.getAttribute("userFid") : null;

        if (userFid == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // 가족 ID 기반 일정 조회
        List<Scheduler> scheduleList = SchedulerRepository.getSchedulesByFamilyId(userFid);
        String jsonResponse = new Gson().toJson(scheduleList);

        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().write(jsonResponse);
    }
}
