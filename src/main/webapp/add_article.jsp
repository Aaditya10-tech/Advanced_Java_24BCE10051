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
    <title>Add New Article</title>
</head>
<body>

<h2>Create New Ticket</h2>

<form action="insertarticle" method="post">
    <label for="userId">User ID:</label><br>
    <input type="hidden"  name="userId" value="<%= userId %>" ><br><br>

    <label for="title">Title:</label><br>
    <input type="text" id="title" name="title" required><br><br>

    <label for="subject">subject:</label><br>
 <input type="text" id="subject" name="subject" required><br><br>

    <label for="writtenBy">writtenBy:</label><br>
 <input type="text" id="writtenBy" name="writtenBy" required><br><br>

    <input type="submit" value="Submit Article">
</form>

</body>
</html>
