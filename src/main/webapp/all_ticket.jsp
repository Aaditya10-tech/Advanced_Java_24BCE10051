<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
    <%@ include file="navBar.jsp" %>
</head>
<body>

<h2>Your Tickets</h2>




<table border="1">
    <tr>
        <th>Ticket ID</th>
        <th>Subject</th>
        <th>Description</th>
        <th>Priority</th>
     
    </tr>
    <c:forEach var="ticket" items="${ticketList}">
        <tr>
            <td>${ticket.ticketId}</td>
            <td>${ticket.subject}</td>
            <td>${ticket.description}</td>
            <td>${ticket.priority}</td>
    
            
        </tr>
    </c:forEach>
</table>

</body>
</html>
