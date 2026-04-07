package com.TicketManagement;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.profile.UserDBUtil;

@WebServlet("/TicketInsertServlet")
public class TicketInsertServlet extends HttpServlet {
	  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String userId = request.getParameter("userId");
	        String subject = request.getParameter("subject");
	        String description = request.getParameter("description");
	        String priority = request.getParameter("priority");
	 

	        boolean isCreated = TicketDBUtil.createTicket(userId, subject, description, priority);
	        if (isCreated) {
	            request.setAttribute("message", "Ticket Created Successfully!");
	        } else {
	            request.setAttribute("message", "Ticket Creation Failed.");
	        }
	        

	        List<Ticket> tickets = TicketDBUtil.getTicketsByUser(userId);
	        request.setAttribute("ticketList", tickets);
//	        RequestDispatcher dis = request.getRequestDispatcher("ticket_dashboard.jsp");
//	        dis.forward(request, response);
	        
	        response.sendRedirect("ticketdashboard");

	    }
	}