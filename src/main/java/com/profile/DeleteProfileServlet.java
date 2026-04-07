package com.profile;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/DeleteProfileServlet")
public class DeleteProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int uid = Integer.parseInt(request.getParameter("uid"));

        // Try to delete the user
        boolean isDeleted = UserDBUtil.deleteUser(uid);

        if (isDeleted) {
            HttpSession session = request.getSession();
            session.invalidate(); // Logout user
            response.sendRedirect("signup.jsp");
        } else {
            // If deletion fails due to related records, show an error message
            request.setAttribute("deleteError", "Cannot delete user because they have associated records (articles or feedback). Please delete those first.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}

