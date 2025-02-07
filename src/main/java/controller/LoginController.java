package controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginController extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");

		// 고유 세션이 있으면 재사용, 없으면 새로 만듬
		HttpSession session = request.getSession();
		System.out.println("Session ID: " + session.getId());

		// id,pw값 각각의 키에 저장
		session.setAttribute("idkey", id);
		session.setAttribute("pwkey", pw);
		session.setAttribute("namekey", "박지혜");

		System.out.println("로그인 ID: " + session.getAttribute("idkey"));

		response.sendRedirect("main.jsp");

	}

}
