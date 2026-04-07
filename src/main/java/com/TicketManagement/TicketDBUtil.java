package com.TicketManagement;


import java.sql.*;
import java.util.*;

public class TicketDBUtil {
    private static Connection con = null;
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;

    public static boolean createTicket(String userId, String subject, String description, String priority) {
        boolean success = false;
        try {
            con = com.Dbconnection.DBConnection.getConnection();
            String sql = "INSERT INTO tickets (user_id, subject, description, priority) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, userId);
            ps.setString(2, subject);
            ps.setString(3, description);
            ps.setString(4, priority);

            int row = ps.executeUpdate();
            success = row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public static List<Ticket> getTicketsByUser(String userId) {
        ArrayList<Ticket> tickets = new ArrayList<>();
        try {
            con = com.Dbconnection.DBConnection.getConnection();
            String sql = "SELECT * FROM tickets WHERE user_id=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                Ticket t = new Ticket(
                    rs.getInt("ticket_id"),
                    rs.getString("user_id"),
                    rs.getString("subject"),
                    rs.getString("description"),
                    rs.getString("priority"),
                    rs.getTimestamp("created_at")
                );
                tickets.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tickets;
    }

    public static boolean updateTicket(int ticketId, String subject, String description, String priority) {
        boolean success = false;
        try {
            Connection con = com.Dbconnection.DBConnection.getConnection();
            Statement stmt = con.createStatement();
            String sql = "UPDATE tickets SET subject = '" + subject + "', description = '" + description + "', priority = '" + priority + "' WHERE ticket_id = " + ticketId;
            int rs = stmt.executeUpdate(sql);
            success = rs > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }


    public static boolean deleteTicket(int ticketId) {
        try {
            con = com.Dbconnection.DBConnection.getConnection();
            String sql = "DELETE FROM tickets WHERE ticket_id=?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, ticketId);

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static List<Ticket> getALLTicket() {
        ArrayList<Ticket> tickets = new ArrayList<>();
        try {
            con = com.Dbconnection.DBConnection.getConnection();
            String sql = "SELECT * FROM tickets";
            ps = con.prepareStatement(sql);
       
            rs = ps.executeQuery();

            while (rs.next()) {
                Ticket t = new Ticket(
                    rs.getInt("ticket_id"),
                    rs.getString("user_id"),
                    rs.getString("subject"),
                    rs.getString("description"),
                    rs.getString("priority"),
                    rs.getTimestamp("created_at")
                );
                tickets.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return tickets;
    }
}
