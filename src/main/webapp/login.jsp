<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
background: linear-gradient(to right, #7f8c8d, #bdc3c7, #ffffff);
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100vh;
        margin: 0;
    }
    .login-container {
        background: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        width: 300px;
        text-align: center;
    }
    .login-container h2 {
        margin-bottom: 20px;
        color: #333;
    }
    .login-container input[type="text"],
    .login-container input[type="password"] {
        width: 93%;
        padding: 10px;
        margin: 10px 0;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    .login-container input[type="submit"] {
        width: 100%;
        padding: 10px;
        background-color: #2980b9;
        border: none;
        border-radius: 5px;
        color: white;
        font-weight: bold;
        cursor: pointer;
        margin-top: 10px;
    }
    .login-container input[type="submit"]:hover {
        background-color: #1c5980;
    }
    .signup-link {
        margin-top: 15px;
        display: block;
        font-size: 14px;
        color: #555;
    }
    .signup-link a {
        color: #2980b9;
        text-decoration: none;
    }
    .signup-link a:hover {
        text-decoration: underline;
    }
    .error-message {
        color: red;
        font-size: 13px;
        margin-top: 10px;
        display: none;
    }
</style>
</head>
<body>
<div class="login-container">
    <h2>Login</h2>
    <form action="login" method="post" id="loginForm">
        <input type="text" name="useremail" placeholder="Email" >
        <input type="password" name="pass" placeholder="Password" >
        <input type="submit" value="Login">
        <div id="errorMessage" class="error-message"></div>
    </form>
    <div class="signup-link">
        Don't have an account? <a href="signup.jsp">Sign up</a>
    </div>
</div>

<script>
    document.getElementById("loginForm").addEventListener("submit", function (e) {
        const email = document.querySelector('input[name="useremail"]').value.trim();
        const password = document.querySelector('input[name="pass"]').value;
        const errorDiv = document.getElementById("errorMessage");
        let errorMessage = "";

        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

        if (!emailPattern.test(email)) {
            errorMessage = "Please enter a valid email address.";
        } else if (password.length < 2) {
            errorMessage = "Password must be at least 2 characters long.";
        }

        if (errorMessage !== "") {
            errorDiv.style.display = "block";
            errorDiv.textContent = errorMessage;
            e.preventDefault();
        } else {
            errorDiv.style.display = "none";
        }
    });
</script>
</body>
</html>
