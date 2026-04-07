package com.TicketManagement;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.profile.UserDBUtil;

/**
 * Servlet implementation class DeleteTicketServlet
 */
@WebServlet("/DeleteTicketServlet")
public class DeleteTicketServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ticketIdStr = request.getParameter("ticketId");
        int ticketId = Integer.parseInt(ticketIdStr);

        boolean isDeleted = TicketDBUtil.deleteTicket(ticketId);

        HttpSession session = request.getSession();
        Integer userIdInt = (Integer) session.getAttribute("userId");

        if (userIdInt == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = String.valueOf(userIdInt);

        if (isDeleted) {
            session.setAttribute("message", "Ticket Deleted Successfully!");
        } else {
            session.setAttribute("message", "Failed to Delete Ticket.");
        }
     
        response.sendRedirect("ticketdashboard");
    }
}

