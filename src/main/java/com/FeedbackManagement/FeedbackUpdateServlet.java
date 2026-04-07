package com.FeedbackManagement;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

;

	@WebServlet("/FeedbackUpdateServlet")
	public class FeedbackUpdateServlet extends HttpServlet {
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {

	        String feedbackIdStr = request.getParameter("feedbackId");
	        String message = request.getParameter("message");
	        String ratingstr = request.getParameter("rating");
	        
	        int rating = Integer.parseInt(ratingstr);
	        int feedbackId = Integer.parseInt(feedbackIdStr);

	        boolean isUpdated = FeedbackDBUtil.updatefeedback(feedbackId,message,rating);

	        HttpSession session = request.getSession();
	        Integer userIdInt = (Integer) session.getAttribute("userId");

	        if (userIdInt == null) {
	            response.sendRedirect("login.jsp");
	            return;
	        }

	        String userId = String.valueOf(userIdInt);

	        if (isUpdated) {
	            request.setAttribute("message", "Feedback Updated Successfully!");
	        } else {
	            request.setAttribute("message", "Failed to Update Feedback.");
	        }

	        request.setAttribute("feedbackList", FeedbackDBUtil.getFeedBackByUser(userId));
	        RequestDispatcher dis = request.getRequestDispatcher("feedback_dashboard.jsp");
	        dis.forward(request, response);
	    }
	}



