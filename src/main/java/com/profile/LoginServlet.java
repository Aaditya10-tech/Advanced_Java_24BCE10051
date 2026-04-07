package com.profile;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String email = request.getParameter("useremail");
	    String password = request.getParameter("pass");

	    try {
	        List<User> userdetails = UserDBUtil.validate(email, password);

	        if (!userdetails.isEmpty()) {
	            // Store in session
	            HttpSession session = request.getSession();
	            session.setAttribute("userdetails", userdetails);
	            
	            User loggedUser = userdetails.get(0);
	            session.setAttribute("userId", loggedUser.getUid());
	            // Redirect to profile.jsp (instead of forward)
	            response.sendRedirect("article");
	        } else {
	            // Invalid login
	            request.setAttribute("error", "Invalid credentials");
	            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
	            dis.forward(request, response);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}


}
