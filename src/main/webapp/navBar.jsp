<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <style>
        body {
            margin: 0;
            font-family: Verdana, sans-serif;
            background: #f0f0f0;
        }

        header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background-color: #1f1f1f;
            padding: 10px 40px;
            position: relative;
        }

        #logo {
            height: 60px;
        }

        #n_bar {
    list-style: none;
    display: flex;
    gap: 30px;
    margin: 0;
    padding: 0;
    align-items: center;
}

#n_bar li {
    position: relative;
}

#n_bar li a {
    text-decoration: none;
    color: #ffffff;
    font-size: 15px;
    font-weight: 500;
    transition: color 0.3s ease;
    padding: 8px 12px;
    border-radius: 4px;
}

#n_bar li a:hover {
    background-color: #2e2e2e;
    color: #4d79ff;
}

        #b1, #b2 {
            margin-left: 10px;
            background-color: #444;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
        }

        #b1 a, #b2 a {
            color: white;
            text-decoration: none;
        }

        .profile-wrapper {
            position: relative;
            display: inline-block;
        }

        #profile {
            height: 70px;
            width: 70px;
            border-radius: 50%;
            cursor: pointer;
        }

        .profile-dropdown {
            position: absolute;
            top: 60px;
            right: 30px;
            background-color: #333;
            border-radius: 6px;
            display: none;
            flex-direction: column;
            min-width: 180px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
            z-index: 1000;
        }

        .profile-dropdown a {
            padding: 12px 16px;
            color: white;
            text-decoration: none;
            font-size: 14px;
        }

        .profile-dropdown a:hover {
            background-color: #555;
        }

        .show {
            display: flex;
        }
        
#text-logo {
    font-size: 30px;
    font-weight: bold;
    font-family: 'Verdana', sans-serif;
    background: linear-gradient(90deg, #007bff, #00ffff);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    position: relative;
    letter-spacing: 2px;
    text-align: center;
}

#text-logo::after {
    content: "NestWest";
    position: absolute;
    top: 0;
    left: 0;
    z-index: -1;
    filter: blur(8px);
    background: linear-gradient(90deg, #007bff, #00ffff);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}


        
    </style>
</head>
<body>

    <header>
        <span id="text-logo">HelpNest</span>


        <ul id="n_bar">
            <li><a href="article">Home</a></li>
            <li><a href="article">Article</a></li>
            <li><a href="feedbackall">Feedback</a></li>
            <li><a href="#">Services</a></li>
            <li><a href="#">Resources</a></li>
        
        </ul>

        <div class="profile-wrapper">
            <img src="images/profile.png" id="profile" alt="PROFILE">
            <div class="profile-dropdown" id="dropdown">
    <a href="profile.jsp">My Profile</a>
    <a href="ticketdashboard">Tickets</a>
    <a href="feedbackdashbord"> Feedback</a>
    <a href="dashboardarticle"> Articles</a>
    <a href="login.jsp">Logout</a>
</div>

        </div>
    </header>

    <script>
        const profile = document.getElementById('profile');
        const dropdown = document.getElementById('dropdown');

        profile.addEventListener('click', (e) => {
            e.stopPropagation(); 
            dropdown.classList.toggle('show');
        });

        window.addEventListener('click', () => {
            dropdown.classList.remove('show');
        });

        dropdown.addEventListener('click', (e) => {
            e.stopPropagation();
        });
    </script>

</body>
</html>
