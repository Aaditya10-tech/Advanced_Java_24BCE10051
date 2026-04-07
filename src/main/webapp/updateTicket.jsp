<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String ticketId = request.getParameter("ticketId");
    String subject = request.getParameter("subject");
    String description = request.getParameter("description");
    String priority = request.getParameter("priority");
;
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

<form action="ticketupdate" method="post">
    <input type="text" name="ticketId" value="<%=ticketId%>" />
    <label for="subject">Subject:</label>
    <input type="text" name="subject" id="subject" value="<%=subject%>"  />

    <label for="description">Description:</label>
  <input type="text" name="description" id="description" value="<%=description%>"  />

    <label for="priority">Priority:</label>
  <input type="text" name="priority" id="priority" value="<%=priority%>"  />


    <input type="submit" value="Update Ticket" />
</form>

</body>
</html>
