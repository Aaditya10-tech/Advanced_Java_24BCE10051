package com.profile;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class UserDBUtil {
	private static boolean success;
	private static Connection con = null;
	private static Statement stat = null;
	private static ResultSet re = null;

	public static List<User> validate(String uemail, String password){
		ArrayList<User> us = new ArrayList<>();
		//
		try {
			
			con = com.Dbconnection.DBConnection.getConnection();
			stat = con.createStatement();
			String sql = "select * from profile where email='"+uemail+"' and password= '"+password+"'";
			ResultSet rs = stat.executeQuery(sql);
			if(rs.next()) {
				int uid = rs.getInt(1);
				String name = rs.getString(2);
				String email = rs.getString(3);
				String phone = rs.getString(4);
				String upassword = rs.getString(5);
				
				User u= new User(uid,name,email,phone,upassword);
				us.add(u);
			}
			
		
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return us;
	}
	public static boolean insertUser(String name, String email, String phone, String password) {
	    boolean isSuccess = false;

	    try {
	        con = com.Dbconnection.DBConnection.getConnection();
	        stat = con.createStatement();
	        String sql = "INSERT INTO profile (name, email, phone_number, password) VALUES ('" + name + "', '" + email + "', '" + phone + "', '" + password + "')";
	        int rs = stat.executeUpdate(sql);

	        if (rs > 0) {
	            isSuccess = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return isSuccess;
	}
	
	public static boolean updateUser(int uid, String name, String email, String phone, String password) {
	    boolean success = false;

	    try {
	        con = com.Dbconnection.DBConnection.getConnection();
	        stat = con.createStatement();
	        String sql = "UPDATE profile SET name='" + name + "', email='" + email + "', phone_number='" + phone + "', password='" + password + "' WHERE uid=" + uid;
	        int rs = stat.executeUpdate(sql);

	        if (rs > 0) {
	            success = true;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return success;
	}
	
	public static boolean deleteUser(int uid) {
	    boolean success = false;
	    Connection con = null;
	    Statement stat = null;
	    ResultSet rs = null;

	    try {
	        // Establish the connection
	        con = com.Dbconnection.DBConnection.getConnection();
	        stat = con.createStatement();

	        // Check if the user has any foreign key references (articles or tickets)
	        String ticketCheckSql = "SELECT COUNT(*) FROM learning.tickets WHERE user_id = " + uid;
	        rs = stat.executeQuery(ticketCheckSql);
	        rs.next();
	        int ticketCount = rs.getInt(1);

	        String articleCheckSql = "SELECT COUNT(*) FROM learning.articles WHERE user_id = " + uid;
	        rs = stat.executeQuery(articleCheckSql);
	        rs.next();
	        int articleCount = rs.getInt(1);

	        // If there are related records (tickets or articles), do not delete
	        if (ticketCount > 0 || articleCount > 0) {
	            return false; // User has foreign key references in tickets or articles, cannot be deleted
	        }

	        // If no related records exist, proceed with deletion from profile
	        String deleteSql = "DELETE FROM learning.profile WHERE uid = " + uid;
	        int rowsAffected = stat.executeUpdate(deleteSql);

	        if (rowsAffected > 0) {
	            success = true; // User deleted successfully
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (stat != null) stat.close();
	            if (con != null) con.close();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

	    return success;
	}

}
