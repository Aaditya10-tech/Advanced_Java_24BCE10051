package com.profile;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/signup")
public class ProfileInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    String name = request.getParameter("name");
	    String email = request.getParameter("email");
	    String phone = request.getParameter("phone");
	    String password = request.getParameter("password");

	    boolean isTrue = UserDBUtil.insertUser(name, email, phone, password);

	    if (isTrue) {
	        // redirect to login page
	        response.sendRedirect("login.jsp");
	    } else {
	        // show error
	        request.setAttribute("message", "Signup failed. Try again.");
	        RequestDispatcher dis = request.getRequestDispatcher("signup.jsp");
	        dis.forward(request, response);
	    }
	}
}


