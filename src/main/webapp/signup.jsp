<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sign Up</title>
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
    .signup-container {
        background: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        width: 350px;
        text-align: center;
    }
    .signup-container h2 {
        margin-bottom: 20px;
        color: #333;
    }
    .signup-container input[type="text"],
    .signup-container input[type="email"],
    .signup-container input[type="password"],
    .signup-container input[type="number"] {
        width: 93%;
        padding: 10px;
        margin: 10px 0;
        border-radius: 5px;
        border: 1px solid #ccc;
    }
    .signup-container input[type="submit"] {
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
    .signup-container input[type="submit"]:hover {
        background-color: #1c5980;
    }
    .back-to-login {
        margin-top: 15px;
        font-size: 14px;
    }
    .back-to-login a {
        color: #2575fc;
        text-decoration: none;
    }
    .back-to-login a:hover {
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
<div class="signup-container">
    <h2>Create an Account</h2>
    <form action="profileinsert" method="post" id="signupForm">
        <input type="text" name="name" placeholder="Full Name" >
        <input type="email" name="email" placeholder="Email Address" >
        <input type="number" name="phone" placeholder="Phone Number" >
        <input type="password" name="password" placeholder="Password" >
        <input type="submit" value="Register">
        <div id="errorMessage" class="error-message"></div>
    </form>
    <div class="back-to-login">
        Already have an account? <a href="login.jsp">Login here</a>
    </div>
</div>

<script>
    document.getElementById("signupForm").addEventListener("submit", function (e) {
        const name = document.querySelector('input[name="name"]').value.trim();
        const email = document.querySelector('input[name="email"]').value.trim();
        const phone = document.querySelector('input[name="phone"]').value.trim();
        const password = document.querySelector('input[name="password"]').value;
        const errorDiv = document.getElementById("errorMessage");
        let errorMessage = "";

        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const phonePattern = /^\d{10,}$/;

        if (name.length === 0) {
            errorMessage = "Name is required.";
        } else if (!emailPattern.test(email)) {
            errorMessage = "Please enter a valid email address.";
        } else if (!phonePattern.test(phone)) {
            errorMessage = "Please enter a valid phone number (at least 10 digits).";
        } else if (password.length < 6) {
            errorMessage = "Password must be at least 6 characters long.";
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
