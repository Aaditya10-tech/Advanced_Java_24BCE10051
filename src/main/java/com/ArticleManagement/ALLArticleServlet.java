package com.ArticleManagement;

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
 * Servlet implementation class ALLArticle
 */
@WebServlet("/ALLArticle")
public class ALLArticleServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    


        List<Article> articles = ArticleDBUtil.getALLArticle();
        request.setAttribute("articleList", articles);

        RequestDispatcher dispatcher = request.getRequestDispatcher("allarticle.jsp");
        dispatcher.forward(request, response);
        
        
    }
}

