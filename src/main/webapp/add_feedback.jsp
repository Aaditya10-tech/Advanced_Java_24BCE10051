<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp"); // redirect if not logged in
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add New Feedback</title>
</head>
<body>

<h2>Create New feedback</h2>

<form action="feedbackinsert" method="post">
    <label for="userId">User ID:</label><br>
    <input type="text"  name="userId" value="<%= userId %>" ><br><br>

    <label for="message">Message:</label><br>
    <input type="text" id="message" name="message" required><br><br>

    <label for="rating">rating</label><br>
 <input type="text" id="rating" name="rating" required><br><br>




    <input type="submit" value="Submit Feedback">
</form>

</body>
</html>
