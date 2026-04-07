package com.ArticleManagement;

	import java.sql.*;
	import java.util.*;

	public class ArticleDBUtil {
	    private static Connection con = null;
	    private static PreparedStatement ps = null;
	    private static ResultSet rs = null;

	    public static boolean createArticle(String userId, String title, String subject, String writtenBy) {
	        boolean success = false;
	        try {
	            con = com.Dbconnection.DBConnection.getConnection();
	            String sql = "INSERT INTO articles (user_id, title, subject, written_by) VALUES (?, ?, ?, ?)";
	            ps = con.prepareStatement(sql);
	            ps.setString(1, userId);
	            ps.setString(2, title);
	            ps.setString(3, subject);
	            ps.setString(4, writtenBy);

	            int row = ps.executeUpdate();
	            success = row > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return success;
	    }

	    public static List<Article> getArticleByUser(String userId) {
	        ArrayList<Article> articles = new ArrayList<>();
	        try {
	            con = com.Dbconnection.DBConnection.getConnection();
	            String sql = "SELECT * FROM articles WHERE user_id=?";
	            ps = con.prepareStatement(sql);
	            ps.setString(1, userId);
	            rs = ps.executeQuery();

	            while (rs.next()) {
	            	Article t = new Article(
	                    rs.getInt("article_id"),
	                    rs.getString("user_id"),
	                    rs.getString("title"),
	                    rs.getString("subject"),
	                    rs.getString("written_by")
	         
	                );
	            	articles.add(t);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return articles;
	    }

	    public static boolean updateArticle(int articleId, String title, String subject, String writtenBy) {
	        boolean success = false;
	        try {
	            Connection con = com.Dbconnection.DBConnection.getConnection();
	            Statement stmt = con.createStatement();
	            String sql = "UPDATE articles SET title = '" + title + "',subject = '" + subject + "', written_by = '" + writtenBy + "' WHERE article_id = " + articleId;
	            int rs = stmt.executeUpdate(sql);
	            success = rs > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return success;
	    }


	    public static boolean deleteArticle(int articleId) {
	        try {
	            con = com.Dbconnection.DBConnection.getConnection();
	            String sql = "DELETE FROM articles WHERE article_id=?";
	            ps = con.prepareStatement(sql);
	            ps.setInt(1, articleId);

	            int result = ps.executeUpdate();
	            return result > 0;
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }
	    
	    public static List<Article> getALLArticle() {
	        ArrayList<Article> articles = new ArrayList<>();
	        try {
	            con = com.Dbconnection.DBConnection.getConnection();
	            String sql = "SELECT * FROM articles";
	            ps = con.prepareStatement(sql);
	         
	            rs = ps.executeQuery();

	            while (rs.next()) {
	            	Article t = new Article(
	                    rs.getInt("article_id"),
	                    rs.getString("user_id"),
	                    rs.getString("title"),
	                    rs.getString("subject"),
	                    rs.getString("written_by")
	         
	                );
	            	articles.add(t);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return articles;
	    }
	}
