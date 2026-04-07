package com.FeedbackManagement;


import java.sql.*;
import java.util.*;

public class FeedbackDBUtil {
    private static Connection con = null;
    private static PreparedStatement ps = null;
    private static ResultSet rs = null;

    public static boolean createfeedback(String userId, String message, int rating) {
        boolean success = false;
        try {
            con = com.Dbconnection.DBConnection.getConnection();
            String sql = "INSERT INTO feedback (user_id, message, rating) VALUES (?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, userId);
            ps.setString(2, message);
            ps.setInt(3, rating);
     

            int row = ps.executeUpdate();
            success = row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public static List<FeedBack> getFeedBackByUser(String userId) {
        ArrayList<FeedBack> feedbacks = new ArrayList<>();
        try {
            con = com.Dbconnection.DBConnection.getConnection();
            String sql = "SELECT * FROM feedback WHERE user_id=?";
            ps = con.prepareStatement(sql);
            ps.setString(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
            	FeedBack t = new FeedBack(
                    rs.getInt("feedback_id"),
                    rs.getString("user_id"),
                    rs.getString("message"),
                    rs.getInt("rating")
         
                );
            	feedbacks.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbacks;
    }

    public static boolean updatefeedback(int feedbackId, String message, int rating) {
        boolean success = false;
        try {
            Connection con = com.Dbconnection.DBConnection.getConnection();
            Statement stmt = con.createStatement();
            String sql = "UPDATE feedback SET message = '" + message + "',rating = '" + rating + "' WHERE feedback_id = " + feedbackId;
            int rs = stmt.executeUpdate(sql);
            success = rs > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }


    public static boolean deletefeedback(int feedbackId) {
        try {
            con = com.Dbconnection.DBConnection.getConnection();
            String sql = "DELETE FROM feedback WHERE feedback_id=?";
            ps = con.prepareStatement(sql);
            ps.setInt(1, feedbackId);

            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static List<FeedBack> getAllFeedBack() {
        ArrayList<FeedBack> feedbacks = new ArrayList<>();
        try {
            con = com.Dbconnection.DBConnection.getConnection();
            String sql = "SELECT * FROM feedback";
            ps = con.prepareStatement(sql);
  
            rs = ps.executeQuery();

            while (rs.next()) {
            	FeedBack t = new FeedBack(
                    rs.getInt("feedback_id"),
                    rs.getString("user_id"),
                    rs.getString("message"),
                    rs.getInt("rating")
         
                );
            	feedbacks.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return feedbacks;
    }
}
