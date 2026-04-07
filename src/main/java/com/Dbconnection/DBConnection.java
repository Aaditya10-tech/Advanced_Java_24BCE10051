package com.Dbconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	private static String url ="jdbc:mysql://localhost:3306/learning";
	private static String user ="root";
	private static String password = "admin";
	private static Connection con;
	
	public static Connection getConnection() {
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			con = DriverManager.getConnection(url, user, password);
			
		}
		catch(Exception e) {
			System.out.println("Incomplete database connection");
		}
		return con;
	}
	
	
	//close the database connection
	public static void closeConnection(Connection connection) {
		try {
			if(connection != null  && !connection.isClosed()) {
				connection.close();
				
			}
		}
		
		catch(SQLException ex) {
			ex.printStackTrace();
		}
		
	}
}
