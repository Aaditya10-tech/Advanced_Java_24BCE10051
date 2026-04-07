package com.TicketManagement;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/TicketUpdateServlet")
public class TicketUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String ticketIdStr = request.getParameter("ticketId");
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");
        String priority = request.getParameter("priority");

        int ticketId = Integer.parseInt(ticketIdStr);

        boolean isUpdated = TicketDBUtil.updateTicket(ticketId, subject, description, priority);

        HttpSession session = request.getSession();
        Integer userIdInt = (Integer) session.getAttribute("userId");

        if (userIdInt == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = String.valueOf(userIdInt);

        if (isUpdated) {
            request.setAttribute("message", "Ticket Updated Successfully!");
        } else {
            request.setAttribute("message", "Failed to Update Ticket.");
        }

        request.setAttribute("ticketList", TicketDBUtil.getTicketsByUser(userId));
        RequestDispatcher dis = request.getRequestDispatcher("ticket_dashboard.jsp");
        dis.forward(request, response);
    }
}
