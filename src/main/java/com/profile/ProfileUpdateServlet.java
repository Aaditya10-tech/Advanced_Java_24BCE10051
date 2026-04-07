package com.profile;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ProfileUpdateServlet")
public class ProfileUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;



		protected void doPost(HttpServletRequest request, HttpServletResponse response)
		        throws ServletException, IOException {

		    int uid = Integer.parseInt(request.getParameter("uid"));
		    String name = request.getParameter("name");
		    String email = request.getParameter("email");
		    String phone = request.getParameter("phone");
		    String password = request.getParameter("password");

		    boolean isUpdated = UserDBUtil.updateUser(uid, name, email, phone, password);

		    if (isUpdated) {
		        // Reload user data after update
		        List<User> userdetails = UserDBUtil.validate(email, password);
		        request.setAttribute("userdetails", userdetails);

		        RequestDispatcher dis = request.getRequestDispatcher("profile.jsp");
		        dis.forward(request, response);
		    } else {
		        response.getWriter().println("Update failed.");
		    }
		}
	}





