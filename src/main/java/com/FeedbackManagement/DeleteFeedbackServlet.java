package com.FeedbackManagement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ArticleManagement.ArticleDBUtil;

/**
 * Servlet implementation class DeleteFeedbackServlet
 */
@WebServlet("/DeleteFeedbackServlet")
public class DeleteFeedbackServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    int fid = Integer.parseInt(request.getParameter("feedbackId"));

	    boolean isDeleted = FeedbackDBUtil.deletefeedback(fid);

	    if (isDeleted) {
	   
	        response.sendRedirect("feedbackdashbord");
	    } else {
	        response.getWriter().println("Deletion failed.");
	    }
	}
}
