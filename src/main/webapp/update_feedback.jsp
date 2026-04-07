<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String feedbackId = request.getParameter("feedbackId");
    String message = request.getParameter("message");
    String rating = request.getParameter("rating");

%>
<!DOCTYPE html>
<html>          
  
<head>
    <meta charset="UTF-8">
    <title>Update Ticket</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 40px;
        }
        form {
            background: #fff;
            padding: 20px;
            width: 400px;
            margin: auto;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        label, input, textarea, select {
            display: block;
            width: 100%;
            margin-bottom: 15px;
        }
        input[type="submit"] {
            background-color: #007BFF;
            color: white;
            border: none;
            padding: 10px;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h2 style="text-align:center;">Update Ticket</h2>

<form action="updatefeedback" method="post">
    <input type="hidden" name="feedbackId" value="<%=feedbackId%>" />
    <label for="message">message:</label>
    <input type="text" name="message" id="message" value="<%=message%>"  />

    <label for="rating">rating:</label>
  <input type="text" name="rating" id="rating" value="<%=rating%>"  />

  
    <input type="submit" value="Update Feedback" />
</form>

</body>
</html>
