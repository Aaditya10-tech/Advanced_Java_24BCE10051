<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <%@ include file="navBar.jsp" %>
    <title>Ticket Dashboard</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .container {
            width: 80%;
            margin: 2% auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            flex-grow: 1;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h2 {
            flex: 1;
            text-align: center;
            margin: 0;
        }

        .ticket-btn input {
            padding: 10px 20px;
            background-color: #3a8dde;
            color: white;
            border: none;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }

        .ticket-btn input:hover {
            background-color: #0056b3;
        }

        .ticket-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .ticket-table th, .ticket-table td {
            padding: 12px 15px;
            text-align: left;
        }

        .ticket-table th {
            background-color: #3a8dde;
            color: #fff;
        }

        .ticket-table tr {
            border-bottom: 1px solid #ddd;
        }

        .ticket-table tr:hover {
            background-color: #f1f1f1;
        }

        .status-container {
            display: flex;
            align-items: center;
        }

        .status {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background-color: green;
            animation: blink 1s infinite step-start;
            margin-right: 8px;
        }

        @keyframes blink {
            0% { background-color: green; }
            50% { background-color: #009900; }
            100% { background-color: green; }
        }

        .status-text {
            font-size: 14px;
            font-weight: bold;
            color: green;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
        }

        .icon-button {
            cursor: pointer;
            border: none;
            background: none;
            padding: 5px;
            transition: transform 0.3s;
        }

        .icon-button i {
            font-size: 18px;
            color: #007bff;
        }

        .icon-button:hover {
            transform: scale(1.2);
        }

        .icon-button:hover i {
            color: #0056b3;
        }

        /* MODAL */
        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            justify-content: center;
            align-items: center;
            background-color: rgba(0,0,0,0.4);
        }

        .modal-content {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            width: 400px;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        .modal-content label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        .modal-content input[type="text"],
        .modal-content select {
            width: 95%;
            padding: 8px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
        }

        .modal-content select {
            background-color: #fff;
            cursor: pointer;
        }

        .modal-content input[type="text"]:focus,
        .modal-content select:focus {
            border-color: #007bff;
        }

        .modal-content .modal-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 15px;
        }

        .modal-content .modal-actions button {
            padding: 8px 16px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
        }

        .save-btn {
            background-color: #007bff;
            color: white;
        }

        .close-btn {
            background-color: #ccc;
        }

        .error-msg {
            color: red;
            font-size: 13px;
            margin-top: -5px;
            margin-bottom: 8px;
        }

        /* Styles for the search bar */
        .search-container {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }

        .search-container input {
            padding: 10px;
            font-size: 14px;
            width: 300px;
            margin-right: 20px;
            border-radius: 4px;
            border: 1px solid #ccc;
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

    <script>
        // Function to filter tickets based on search query
        function filterTickets() {
            const searchQuery = document.getElementById('search-bar').value.toLowerCase();
            const rows = document.querySelectorAll('.ticket-table tbody tr');

            rows.forEach(row => {
                const ticketId = row.cells[0].textContent.toLowerCase();
                const subject = row.cells[1].textContent.toLowerCase();
                const description = row.cells[2].textContent.toLowerCase();
                const priority = row.cells[3].textContent.toLowerCase();

                // If any of the ticket details match the search query, show the row
                if (ticketId.includes(searchQuery) || subject.includes(searchQuery) || description.includes(searchQuery) || priority.includes(searchQuery)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        function openModal(ticketId, subject, description, priority) {
            document.getElementById("modal").style.display = "flex";
            document.getElementById("modal-ticketId").value = ticketId;
            document.getElementById("modal-subject").value = subject;
            document.getElementById("modal-description").value = description;
            document.getElementById("modal-priority").value = priority;
        }

        function closeModal() {
            document.getElementById("modal").style.display = "none";
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this ticket?");
        }

        function validateModalForm() {
            const subject = document.getElementById("modal-subject").value.trim();
            const description = document.getElementById("modal-description").value.trim();
            const priority = document.getElementById("modal-priority").value;

            let isValid = true;

            if (subject === "") {
                document.getElementById("modal-subject-error").textContent = "Subject is required.";
                isValid = false;
            } else {
                document.getElementById("modal-subject-error").textContent = "";
            }

            if (description.length < 10) {
                document.getElementById("modal-description-error").textContent = "Description must be at least 10 characters.";
                isValid = false;
            } else {
                document.getElementById("modal-description-error").textContent = "";
            }

            if (priority === "") {
                document.getElementById("modal-priority-error").textContent = "Please select a priority.";
                isValid = false;
            } else {
                document.getElementById("modal-priority-error").textContent = "";
            }

            return isValid;
            
            setTimeout(() => {
                const notification = document.getElementById('notification');
                if (notification) {
                    notification.remove();
                }
            }, 4000);

        }
    </script>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>Your Tickets</h2>
        <form action="add_ticket.jsp" method="get" class="ticket-btn">
            <input type="submit" value="Create New Ticket" />
        </form>
    </div>
    
    

    <!-- Search Bar -->
    <div class="search-container">
        <input type="text" id="search-bar" placeholder="Search tickets..." onkeyup="filterTickets()" />
    </div>

    <table class="ticket-table">
        <thead>
        <tr>
            <th>Ticket ID</th>
            <th>Subject</th>
            <th>Description</th>
            <th>Priority</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:if test="${empty ticketList}">
            <tr>
                <td colspan="6" style="text-align: center; font-weight: bold; color: #999;">
                    No data available
                </td>
            </tr>
        </c:if>
        <c:forEach var="ticket" items="${ticketList}">
            <tr>
                <td>${ticket.ticketId}</td>
                <td>${ticket.subject}</td>
                <td>${ticket.description}</td>
                <td>${ticket.priority}</td>
                <td>
                    <div class="status-container">
                        <div class="status"></div>
                        <div class="status-text">Open</div>
                    </div>
                </td>
                <td class="action-buttons">
                    <button type="button" class="icon-button"
                            onclick="openModal('${ticket.ticketId}', '${ticket.subject}', '${ticket.description}', '${ticket.priority}')">
                        <i class="fas fa-edit"></i>
                    </button>

                    <form action="ticketdelete" method="post" style="display:inline-block;" onsubmit="return confirmDelete()">
                        <input type="hidden" name="ticketId" value="${ticket.ticketId}">
                        <button type="submit" class="icon-button">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Modal -->
<div id="modal" class="modal">
    <div class="modal-content">
        <form action="ticketupdate" method="post" onsubmit="return validateModalForm();">
            <label for="modal-ticketId">Ticket ID:</label>
            <input type="text" readonly name="ticketId" id="modal-ticketId" />

            <label for="modal-subject">Subject:</label>
            <input type="text" name="subject" id="modal-subject"  />
            <div id="modal-subject-error" class="error-msg"></div>

            <label for="modal-description">Description:</label>
            <input type="text" name="description" id="modal-description"  />
            <div id="modal-description-error" class="error-msg"></div>

            <label for="modal-priority">Priority:</label>
            <select name="priority" id="modal-priority" >
                <option value="">-- Select Priority --</option>
                <option value="Low">Low</option>
                <option value="Medium">Medium</option>
                <option value="High">High</option>
            </select>
            <div id="modal-priority-error" class="error-msg"></div>

            <div class="modal-actions">
                <button type="submit" class="save-btn">Save</button>
                <button type="button" class="close-btn" onclick="closeModal()">Cancel</button>
            </div>
        </form>
    </div>
</div>

<%@ include file="footer.jsp" %>
</body>
</html>
