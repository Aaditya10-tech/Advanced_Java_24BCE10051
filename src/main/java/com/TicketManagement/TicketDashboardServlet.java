package com.TicketManagement;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/TicketDashboardServlet")
public class TicketDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = session.getAttribute("userId").toString();

        List<Ticket> tickets = TicketDBUtil.getTicketsByUser(userId);
        request.setAttribute("ticketList", tickets);

        RequestDispatcher dispatcher = request.getRequestDispatcher("ticket_dashboard.jsp");
        dispatcher.forward(request, response);
        
        
    }
}
