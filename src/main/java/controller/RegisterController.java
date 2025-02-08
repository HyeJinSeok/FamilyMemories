package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import repository.UserRepository;
import domain.User;
import utils.SecurityUtil;

@WebServlet("/register")
public class RegisterController extends HttpServlet {
    private UserRepository userRepository;

    public RegisterController() {
        this.userRepository = new UserRepository();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String name = request.getParameter("name");
        String id = request.getParameter("id");       
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        int fid = Integer.parseInt(request.getParameter("fid"));
        
        // 비밀번호 해싱
        String hashedPassword = SecurityUtil.hashPassword(password);
        
        User newUser = new User();
        newUser.setName(name);
        newUser.setId(id);
        newUser.setPw(hashedPassword);
        newUser.setEmail(email);
        newUser.setFid(fid);
        
        boolean isRegistered = userRepository.registerUser(newUser);
        
        if (isRegistered) {
            response.sendRedirect(request.getContextPath() + "/views/jsp/login.jsp?status=success");
        } else {
            response.sendRedirect(request.getContextPath() + "/views/jsp/register.jsp?status=failure");
        }
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.getRequestDispatcher("/views/jsp/register.jsp").forward(request, response); //
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}




