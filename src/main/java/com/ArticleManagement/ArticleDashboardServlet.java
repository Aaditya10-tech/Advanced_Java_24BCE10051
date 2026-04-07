package com.ArticleManagement;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ArticleDashboardServlet")
public class ArticleDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = session.getAttribute("userId").toString();

        List<Article> articles = ArticleDBUtil.getArticleByUser(userId);
        request.setAttribute("articleList", articles);

        RequestDispatcher dispatcher = request.getRequestDispatcher("articledashboard.jsp");
        dispatcher.forward(request, response);
        
        
    }
}


