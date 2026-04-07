<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
    String uid = request.getParameter("uid");
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String phone = request.getParameter("phone");
    String password = request.getParameter("password");
%>
<!DOCTYPE html>
<html>
<head>
<title>Update Profile</title>
</head>
<body>
    <h2>Update Profile</h2>
    <form action="profileupdate" method="post">
        <input type="hidden" name="uid" value="<%=uid%>">
        Name: <input type="text" name="name" value="<%=name%>"><br><br>
        Email: <input type="email" name="email" value="<%=email%>"><br><br>
        Phone: <input type="text" name="phone" value="<%=phone%>"><br><br>
        Password: <input type="password" name="password" value="<%=password%>"><br><br>
        <input type="submit" value="Update">
    </form>
</body>
</html>
