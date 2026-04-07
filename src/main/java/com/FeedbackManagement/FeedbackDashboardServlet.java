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

import com.ArticleManagement.Article;
import com.ArticleManagement.ArticleDBUtil;

/**
 * Servlet implementation class FeedbackDashboardServlet
 */
@WebServlet("/FeedbackDashboardServlet")
public class FeedbackDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = session.getAttribute("userId").toString();

        List<FeedBack> feedbacks = FeedbackDBUtil.getFeedBackByUser(userId);
        request.setAttribute("feedbackList", feedbacks);

        RequestDispatcher dispatcher = request.getRequestDispatcher("feedback_dashboard.jsp");
        dispatcher.forward(request, response);
        
        
    }
}
