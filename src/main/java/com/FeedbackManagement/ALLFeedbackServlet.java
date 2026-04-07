package com.FeedbackManagement;

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
 * Servlet implementation class ALLFeedback
 */
@WebServlet("/ALLFeedback")
public class ALLFeedbackServlet extends HttpServlet {
	   protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	     
	     

	        List<FeedBack> feedbacks = FeedbackDBUtil.getAllFeedBack();
	        request.setAttribute("feedbackList", feedbacks);

	        RequestDispatcher dispatcher = request.getRequestDispatcher("feedback_all.jsp");
	        dispatcher.forward(request, response);
	        
	        
	    }
	}
