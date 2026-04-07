<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="navBar.jsp" %>
    <style>
    html, body {
    height: 100%;
    margin: 0;
    padding: 0;
}

        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
    flex-direction: column;
        }

        h2 {
            text-align: center;
            margin: 40px 0;
            font-size: 28px;
            color: #333;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            justify-content: center;
            padding-left: 20px;
            padding-right: 20px;
        }

        .card {
            background: #d9d9d9;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            width: 300px;
            padding: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            height: 200px;
            margin-bottom: 10px;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.15);
        }

        .card h3 {
            color: #2c3e50;
            margin: 0 0 10px; 
            font-size: 20px;
            font-weight: bold;
        }

        .card .subject {
            margin: 0; 
            color: #7f8c8d;
            font-size: 16px;
        }

        .card .written-by {
            font-style: italic;
            color: #000;
            font-size: 14px;
        }

        .card .rating {
            display: flex;
            align-items: center;
            font-size: 20px;
        }

        .card .card-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto; 
        }

        /* Styling the reaction icons */
        .reaction {
            margin-right: 10px;
            color: #ff0000; /* Heart reaction color */
            font-size: 24px;
        }

        .thumbs-up {
            color: #28a745; /* Thumbs up color */
        }

        /* Count Styling */
        .reaction-count {
            font-size: 16px;
            margin-left: 5px;
        }
    </style>
</head>
<body>

<h2>Knowledge Base Articles</h2>

<div class="card-container">
    <!-- Iterate over the articles dynamically -->
    <c:forEach var="article" items="${articleList}">
        <div class="card">
            <!-- Title Section -->
            <h3>${article.title}</h3>

            <!-- Subject Section -->
            <p class="subject">${article.subject}</p>

            <!-- Footer Section with Written By and Rating -->
            <div class="card-footer">
                <!-- Written By Section -->
                <p class="written-by">Written by: ${article.writtenBy}</p>

                <!-- Rating Section (Reactions: Heart & Thumbs Up with Counts) -->
                <div class="rating">
                    <!-- Heart Reaction with Count -->
                    <span class="reaction">&#10084;</span> 
                    <span class="reaction-count">5</span> <!-- Hardcoded heart count -->

                    <!-- Thumbs Up Reaction with Count -->
                    <span class="thumbs-up">&#128077;</span>
                    <span class="reaction-count">10</span> <!-- Hardcoded thumbs-up count -->
                </div>
            </div>
        </div>
    </c:forEach>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
