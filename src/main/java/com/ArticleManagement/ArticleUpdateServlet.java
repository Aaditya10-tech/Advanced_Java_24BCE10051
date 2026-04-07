package com.ArticleManagement;


import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ArticleUpdateServlet")
public class ArticleUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String articleIdStr = request.getParameter("articleId");
        String title = request.getParameter("title");
        String subject = request.getParameter("subject");
        String writtenBy = request.getParameter("writtenBy");

        int articleId = Integer.parseInt(articleIdStr);

        boolean isUpdated = ArticleDBUtil.updateArticle(articleId,title,subject, writtenBy);

        HttpSession session = request.getSession();
        Integer userIdInt = (Integer) session.getAttribute("userId");

        if (userIdInt == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = String.valueOf(userIdInt);

        if (isUpdated) {
            request.setAttribute("message", "Article Updated Successfully!");
        } else {
            request.setAttribute("message", "Failed to Update Article.");
        }

        request.setAttribute("articleList", ArticleDBUtil.getArticleByUser(userId));
        RequestDispatcher dis = request.getRequestDispatcher("articledashboard.jsp");
        dis.forward(request, response);
    }
}


