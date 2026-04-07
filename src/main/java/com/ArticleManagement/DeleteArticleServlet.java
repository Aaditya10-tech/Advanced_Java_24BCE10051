package com.ArticleManagement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.TicketManagement.TicketDBUtil;

/**
 * Servlet implementation class DeleteArticleServlet
 */
@WebServlet("/DeleteArticleServlet")
public class DeleteArticleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    int aid = Integer.parseInt(request.getParameter("articleId"));

	    boolean isDeleted = ArticleDBUtil.deleteArticle(aid);

	    if (isDeleted) {
	   
	        response.sendRedirect("dashboardarticle");
	    } else {
	        response.getWriter().println("Deletion failed.");
	    }
	}
}

