package com.FeedbackManagement;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ArticleManagement.Article;
import com.ArticleManagement.ArticleDBUtil;

/**
 * Servlet implementation class InsertFeedbackServlet
 */
@WebServlet("/InsertFeedbackServlet")
public class InsertFeedbackServlet extends HttpServlet {
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String userId = request.getParameter("userId");
	        String message = request.getParameter("message");
	        String ratingstr = request.getParameter("rating");	    
	        int rating = Integer.parseInt(ratingstr);
	        
	        boolean isCreated = FeedbackDBUtil.createfeedback(userId, message,rating);
	        if (isCreated) {
	            request.setAttribute("message", "Feedback Created Successfully!");
	        } else {
	            request.setAttribute("message", "Feedback Creation Failed.");
	        }
	        

	        List<FeedBack> feedbacks = FeedbackDBUtil.getFeedBackByUser(userId);
	        request.setAttribute("feedbackList", feedbacks);
//	        RequestDispatcher dis = request.getRequestDispatcher("feedback_dashboard.jsp");
//	        dis.forward(request, response);
	        
	        response.sendRedirect("feedbackdashbord");

	    }
	}
