package com.FeedbackManagement;

public class FeedBack {
	private int feedbackId;
    private String userId;
    private String message;
    private int rating;
	public FeedBack(int feedbackId, String userId, String message, int rating) {
	
		this.feedbackId = feedbackId;
		this.userId = userId;
		this.message = message;
		this.rating = rating;
	}
	public int getFeedbackId() {
		return feedbackId;
	}
	public void setFeedbackId(int feedbackId) {
		this.feedbackId = feedbackId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public int getRating() {
		return rating;
	}
	public void setRating(int rating) {
		this.rating = rating;
	}
	

}
