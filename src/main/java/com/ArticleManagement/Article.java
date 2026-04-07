package com.ArticleManagement;

public class Article {

	private int articleId;
    private String userId;
    private String title;
    private String subject;
    private String writtenBy;
	public Article(int articleId, String userId, String title, String subject, String writtenBy) {

		this.articleId = articleId;
		this.userId = userId;
		this.title = title;
		this.subject = subject;
		this.writtenBy = writtenBy;
	}
	public int getArticleId() {
		return articleId;
	}
	public void setArticleId(int articleId) {
		this.articleId = articleId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getWrittenBy() {
		return writtenBy;
	}
	public void setWrittenBy(String writtenBy) {
		this.writtenBy = writtenBy;
	}

   
  

}
