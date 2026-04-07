package com.TicketManagement;

import java.sql.Timestamp;

public class Ticket {
	private int ticketId;
    private String userId;
    private String subject;
    private String description;
    private String priority;
    private Timestamp createdAt;

    public Ticket(int ticketId, String userId, String subject, String description, String priority,
                  Timestamp createdAt) {
        this.ticketId = ticketId;
        this.userId = userId;
        this.subject = subject;
        this.description = description;
        this.priority = priority;
        this.createdAt = createdAt;
    }

    public int getTicketId() {
		return ticketId;
	}

	public void setTicketId(int ticketId) {
		this.ticketId = ticketId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}


}
