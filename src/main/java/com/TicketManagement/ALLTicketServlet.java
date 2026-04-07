package com.TicketManagement;

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
 * Servlet implementation class ALLTicket
 */
@WebServlet("/ALLTicket")
public class ALLTicketServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Ticket> tickets = TicketDBUtil.getALLTicket();
        request.setAttribute("ticketList", tickets);

        RequestDispatcher dispatcher = request.getRequestDispatcher("all_ticket.jsp");
        dispatcher.forward(request, response);
        
        
    }
}
       

