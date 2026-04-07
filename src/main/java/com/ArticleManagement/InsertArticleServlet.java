package com.ArticleManagement;


import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.profile.UserDBUtil;

@WebServlet("/InsertArticleServlet")
public class InsertArticleServlet extends HttpServlet {
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String userId = request.getParameter("userId");
	        String title = request.getParameter("title");
	        String subject = request.getParameter("subject");
	        String writtenBy = request.getParameter("writtenBy");
	 

	        boolean isCreated = ArticleDBUtil.createArticle(userId, title,subject, writtenBy);
	        if (isCreated) {
	            request.setAttribute("message", "Article Created Successfully!");
	        } else {
	            request.setAttribute("message", "Article Creation Failed.");
	        }
	        

	        List<Article> articles = ArticleDBUtil.getArticleByUser(userId);
	        request.setAttribute("articleList", articles);
	        
	        response.sendRedirect("dashboardarticle");

	    }
	}
