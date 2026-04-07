<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        .page-wrapper {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        main.container {
            flex-grow: 1;
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f4f7fc;
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            margin-top: 2%;
        }

        h2 {
            font-size: 24px;
            color: #000;
            margin: 0;
            flex-grow: 1;
            text-align: center;
        }

        .button {
            background-color: #3a8dde;
            color: white;
            padding: 10px 20px;
            border: none;
            cursor: pointer;
            text-align: center;
            display: inline-block;
        }

        .button:hover {
            background-color: #357cc9;
        }

        .search-bar {
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 1em;
            width: 250px;
            margin-bottom: 20px;
        }

        .feedback-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            justify-content: center;
        }

        .feedback-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            box-sizing: border-box;
            transition: transform 0.2s;
        }

        .feedback-card:hover {
            transform: translateY(-5px);
        }

        .feedback-header {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .avatar-placeholder {
            width: 40px;
            height: 40px;
            background-color: white;
            border-radius: 50%;
            background-image: url('https://cdn-icons-png.flaticon.com/512/149/149071.png');
            background-size: 60%;
            background-position: center;
            background-repeat: no-repeat;
            margin-right: 10px;
        }

        .client-id {
            font-weight: bold;
            color: #333;
        }

        .feedback-message {
            font-style: italic;
            color: #555;
            margin-bottom: 10px;
        }

        .feedback-rating {
            color: #ffcc00;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .action-buttons {
            display: flex;
            justify-content: flex-start;
            gap: 10px;
        }

        .action-buttons button {
            background-color: transparent;
            border: none;
            cursor: pointer;
            font-size: 1.2em;
        }

        .action-buttons button:hover {
            color: #007BFF;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0; top: 0;
            width: 100%; height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.6);
        }

        .modal-content {
            background-color: #fff;
            margin: 10% auto;
            padding: 30px;
            border: 1px solid #888;
            width: 90%;
            max-width: 500px;
            border-radius: 10px;
            position: relative;
        }

        .close {
            position: absolute;
            top: 10px; right: 20px;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }

        .star-rating {
            direction: rtl;
            display: inline-flex;
            font-size: 2em;
        }

        .star-rating input[type="radio"] {
            display: none;
        }

        .star-rating label {
            color: #ccc;
            cursor: pointer;
        }

        .star-rating input:checked ~ label,
        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: #ffcc00;
        }

        textarea {
            width: 80%;
            height: 150px;
            padding: 10px;
            font-size: 1em;
            border-radius: 5px;
            border: 1px solid #ccc;
            resize: vertical;
        }

        @media (max-width: 600px) {
            .feedback-card {
                max-width: 100%;
            }

            .header-container {
                flex-direction: column;
                align-items: stretch;
                gap: 10px;
            }
        }
        
        .error-message {
            color: red;
            font-size: 0.9em;
            margin-top: 5px;
        }
        
    </style>
</head>
<body>
<div class="page-wrapper">
    <%@ include file="navBar.jsp" %>

    <main class="container">
        <div class="header-container">
            <h2>Your Feedbacks</h2>
            <button type="button" class="button" onclick="openModal()">Create New Feedback</button>

            
        </div>
<!-- Search Bar -->
            <input type="text" id="searchBar" class="search-bar" placeholder="Search by client id..." oninput="filterFeedback()">
        <div class="feedback-list">
            <c:forEach var="feedback" items="${feedbackList}">
                <div class="feedback-card">
                    <div class="feedback-header">
                        <div class="avatar-placeholder"></div>
                        <span class="client-id">Client #${feedback.feedbackId}</span>
                    </div>
                    <div class="feedback-message">“${feedback.message}”</div>
                    <div class="feedback-rating">
                        <c:forEach var="i" begin="1" end="5">
                            <i class="fa-star <c:out value='${i <= feedback.rating ? "fas" : "far"}'/>" style="color: #ffcc00;"></i>
                        </c:forEach>
                    </div>
                    <div class="action-buttons">
                        <button type="button" onclick="openUpdateModal('${feedback.feedbackId}', '${feedback.message}', '${feedback.rating}')">
                            <i class="fas fa-edit"></i>
                        </button>
                        <form action="feedbackdelete" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this feedback?');">
                            <input type="hidden" name="feedbackId" value="${feedback.feedbackId}">
                            <button type="submit">
                                <i class="fas fa-trash-alt" style="color: red;"></i>
                            </button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
</div>

<!-- Create Feedback Modal -->
<div id="feedbackModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal()">&times;</span>
        <h2>Create Feedback</h2>
        <form id="createFeedbackForm" onsubmit="return validateCreateForm()" action="${pageContext.request.contextPath}/InsertFeedbackServlet" method="post">
            <input type="hidden" name="userId" value="${sessionScope.userId}" />
            <label for="message">Message:</label><br>
            <textarea name="message" rows="4" ></textarea><br>
            <div id="createMessageError" class="error-message"></div>

            <label for="rating">Rating:</label>
            <div class="star-rating">
                <input type="radio" name="rating" value="5" id="5"><label for="5">★</label>
                <input type="radio" name="rating" value="4" id="4"><label for="4">★</label>
                <input type="radio" name="rating" value="3" id="3"><label for="3">★</label>
                <input type="radio" name="rating" value="2" id="2"><label for="2">★</label>
                <input type="radio" name="rating" value="1" id="1"><label for="1">★</label>
            </div>
            <div id="createRatingError" class="error-message"></div>
            <br>
            <input type="submit" value="Submit Feedback" class="button">
        </form>
    </div>
</div>

<!-- Update Feedback Modal -->
<div id="updateFeedbackModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeUpdateModal()">&times;</span>
        <h2>Update Feedback</h2>
        <form id="updateFeedbackForm" onsubmit="return validateUpdateForm()" action="${pageContext.request.contextPath}/FeedbackUpdateServlet" method="post">
            <input type="hidden" name="feedbackId" id="updateFeedbackId">
            <label for="updateMessage">Message:</label><br>
            <textarea name="message" id="updateMessage" rows="4" ></textarea>
            <div id="updateMessageError" class="error-message"></div>

            <label for="updateRating">Rating:</label>
            <div class="star-rating" id="updateRatingStars">
                <input type="radio" name="rating" value="5" id="update5"><label for="update5">★</label>
                <input type="radio" name="rating" value="4" id="update4"><label for="update4">★</label>
                <input type="radio" name="rating" value="3" id="update3"><label for="update3">★</label>
                <input type="radio" name="rating" value="2" id="update2"><label for="update2">★</label>
                <input type="radio" name="rating" value="1" id="update1"><label for="update1">★</label>
            </div>
            <div id="updateRatingError" class="error-message"></div>
            <br>
            <input type="submit" value="Update Feedback" class="button">
        </form>
    </div>
</div>

<script>
    function filterFeedback() {
        const searchQuery = document.getElementById("searchBar").value.toLowerCase();
        const feedbackCards = document.querySelectorAll(".feedback-card");

        feedbackCards.forEach(card => {
            const clientId = card.querySelector(".client-id").textContent.toLowerCase();
            const message = card.querySelector(".feedback-message").textContent.toLowerCase();
            const rating = card.querySelector(".feedback-rating").textContent.toLowerCase();

            // Check if the search query matches any part of the feedback (clientId, message, or rating)
            if (clientId.includes(searchQuery) || message.includes(searchQuery) || rating.includes(searchQuery)) {
                card.style.display = "block";
            } else {
                card.style.display = "none";
            }
        });
    }

    function openModal() {
        document.getElementById("feedbackModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("feedbackModal").style.display = "none";
    }

    function openUpdateModal(id, message, rating) {
        document.getElementById("updateFeedbackId").value = id;
        document.getElementById("updateMessage").value = message;

        const radios = document.querySelectorAll('#updateRatingStars input[type="radio"]');
        radios.forEach(radio => {
            radio.checked = radio.value === rating;
        });

        document.getElementById("updateFeedbackModal").style.display = "block";
    }

    function closeUpdateModal() {
        document.getElementById("updateFeedbackModal").style.display = "none";
    }

    window.onclick = function(event) {
        const createModal = document.getElementById("feedbackModal");
        const updateModal = document.getElementById("updateFeedbackModal");
        if (event.target === createModal) createModal.style.display = "none";
        if (event.target === updateModal) updateModal.style.display = "none";
    }

    function validateCreateForm() {
        let isValid = true;
        const message = document.querySelector('#createFeedbackForm textarea[name="message"]').value.trim();
        const ratingChecked = document.querySelector('#createFeedbackForm input[name="rating"]:checked');

        document.getElementById('createMessageError').textContent = '';
        document.getElementById('createRatingError').textContent = '';

        if (!message) {
            document.getElementById('createMessageError').textContent = 'Please enter a message.';
            isValid = false;
        }

        if (!ratingChecked) {
            document.getElementById('createRatingError').textContent = 'Please select a rating.';
            isValid = false;
        }

        return isValid;
    }

    function validateUpdateForm() {
        let isValid = true;
        const message = document.querySelector('#updateFeedbackForm textarea[name="message"]').value.trim();
        const ratingChecked = document.querySelector('#updateFeedbackForm input[name="rating"]:checked');

        document.getElementById('updateMessageError').textContent = '';
        document.getElementById('updateRatingError').textContent = '';

        if (!message) {
            document.getElementById('updateMessageError').textContent = 'Please enter a message.';
            isValid = false;
        }

        if (!ratingChecked) {
            document.getElementById('updateRatingError').textContent = 'Please select a rating.';
            isValid = false;
        }

        return isValid;
    }
</script>

</body>
</html>
