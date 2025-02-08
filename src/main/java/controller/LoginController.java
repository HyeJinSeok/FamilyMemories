package controller;

import java.io.IOException;


import domain.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import repository.LoginRepository;
import utils.SecurityUtil;

@WebServlet("/login")
public class LoginController extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		
		
		// 고유 세션이 있으면 재사용, 없으면 새로 만듬

		// id,pw값 각각의 키에 저장
		//if(id.equals("tester")) {

			
			LoginRepository lp = new LoginRepository();
			User user = lp.validateUser(id, pw);
			System.out.println(user.toString());
			
			
	        if (user != null && SecurityUtil.checkPassword(pw, user.getPw())) {  // 수정: 비밀번호 검증
	            // 세션에 사용자 정보 저장
	            HttpSession session = request.getSession(true);
	            session.setAttribute("uidkey", user.getUid());
	            session.setAttribute("namekey", user.getName());
	            session.setAttribute("idkey", user.getId());
	            session.setAttribute("emailId", user.getEmail());
	            session.setAttribute("userFid", user.getFid());

	            response.sendRedirect("main");  // 로그인 성공 시 리다이렉트
	        } else {
	            // 로그인 실패 처리
	            request.setAttribute("loginError", "Invalid username or password.");
	            request.getRequestDispatcher("/views/jsp/login.jsp").forward(request, response);
	        }
	    }

	
		protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        try {
	            request.getRequestDispatcher("/views/jsp/login.jsp").forward(request, response); //
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    

	}

}
