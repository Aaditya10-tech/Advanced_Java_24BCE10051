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
    <%@ include file="navBar.jsp" %>
    <title>Add New Ticket</title>
    <style>
        /* Ensure full height for the page */
        html, body {
            height: 100%;
            margin: 0;
            font-family: 'Arial', sans-serif;
        }

        body {
            background-color: #f4f7fa;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .content-wrapper {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .ticket-form-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
            position: relative;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-size: 14px;
            color: #555;
            font-weight: bold;
        }

        input[type="text"], textarea, select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
            background-color: #f9f9f9;
        }

        input[type="text"]:focus, textarea:focus, select:focus {
            border-color: #4CAF50;
            outline: none;
            background-color: #fff;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .submit-btn {
            background-color: #3a8dde;
            color: white;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 4px;
            width: 100%;
        }

        .submit-btn:hover {
            background-color: #4d88ff;
        }

        .form-group select {
            cursor: pointer;
        }
        
        .error-msg {
    color: red;
    font-size: 13px;
    margin-top: 5px;
}

.notification {
    position: fixed;
    top: 20px;
    right: 20px;
    background-color: #28a745;
    color: white;
    padding: 15px 20px;
    border-radius: 5px;
    box-shadow: 0 0 10px rgba(0,0,0,0.2);
    z-index: 1000;
    font-size: 14px;
    animation: fadeout 4s forwards;
}

@keyframes fadeout {
    0% { opacity: 1; }
    80% { opacity: 1; }
    100% { opacity: 0; display: none; }
}
        

    </style>
</head>
<body>

<div class="content-wrapper">
    <div class="ticket-form-container">
        <h2>Create New Ticket</h2>
        <form id="ticketForm" action="ticketinsert" method="post" onsubmit="return validateForm();">

            <input type="hidden" name="userId" value="<%= userId %>">
            
            <div class="form-group">
    <label for="subject">Subject:</label>
    <input type="text" id="subject" name="subject" >
    <div id="subjectError" class="error-msg"></div>
</div>

<div class="form-group">
    <label for="description">Description:</label>
    <textarea id="description" name="description" rows="4" ></textarea>
    <div id="descriptionError" class="error-msg"></div>
</div>

<div class="form-group">
    <label for="priority">Priority:</label>
    <select id="priority" name="priority" >
        <option value="">-- Select Priority --</option>
        <option value="Low">Low</option>
        <option value="Medium">Medium</option>
        <option value="High">High</option>
    </select>
    <div id="priorityError" class="error-msg"></div>
</div>


            <div class="form-group">
                <input type="submit" value="Submit Ticket" class="submit-btn">
            </div>
        </form>
    </div>
</div>

<script>
    function validateForm() {
        // Clear previous errors
        document.getElementById("subjectError").textContent = "";
        document.getElementById("descriptionError").textContent = "";
        document.getElementById("priorityError").textContent = "";

        let isValid = true;
        const subject = document.getElementById("subject").value.trim();
        const description = document.getElementById("description").value.trim();
        const priority = document.getElementById("priority").value;

        if (subject === "") {
            document.getElementById("subjectError").textContent = "Subject is required.";
            isValid = false;
        }

        if (description.length < 10) {
            document.getElementById("descriptionError").textContent = "Description must be at least 10 characters.";
            isValid = false;
        }

        if (priority === "") {
            document.getElementById("priorityError").textContent = "Please select a priority.";
            isValid = false;
        }

        return isValid;
    }
</script>



<%@ include file="footer.jsp" %>
</body>
</html>
