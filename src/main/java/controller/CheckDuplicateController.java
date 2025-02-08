package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import repository.UserRepository;

@WebServlet("/check-duplicate")
public class CheckDuplicateController extends HttpServlet {
    private UserRepository userRepository;

    public CheckDuplicateController() {
        this.userRepository = new UserRepository();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain;charset=UTF-8");
        String type = request.getParameter("type"); // "id" 또는 "email"
        String value = request.getParameter("value");

        boolean isDuplicate = false;

        if ("id".equals(type)) {
            isDuplicate = userRepository.isIdDuplicate(value);
        } else if ("email".equals(type)) {
            isDuplicate = userRepository.isEmailDuplicate(value);
        }

        response.getWriter().write(isDuplicate ? "duplicate" : "available");
    }
}