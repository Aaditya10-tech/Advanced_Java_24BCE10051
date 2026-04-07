<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <%@ include file="navBar.jsp" %>
    <title>Your Articles</title>
    <style>
        html, body {
            height: 100%;
            margin: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f2f5;
            display: flex;
            flex-direction: column;
        }

        .header-container {
            margin-top: 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 60px auto 40px;
            padding: 0 20px;
        }

        .header-container h2 {
            margin: 0;
            flex-grow: 1;
            text-align: center;
            position: absolute;
            left: 50%;
            transform: translateX(-50%);
        }

        .create-form {
            margin-top: 0;
            position: absolute;
            right: 11%;
        }

        .create-btn {
            padding: 8px 15px;
            font-size: 14px;
            background-color: #3a8dde;
            border: none;
            color: white;       
            cursor: pointer;
        }

        .article-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 24px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .card {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.1);
            padding: 20px;
        }

        .card input[type="submit"],
        .card button {
            padding: 8px 14px;
            font-size: 14px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .card input[value="Delete"] {
            background-color: #dc3545;
            color: white;
        }

        .card input[value="Delete"]:hover {
            background-color: #a71d2a;
        }

        .card button.update-btn {
            background-color: #007bff;
            color: white;
        }

        .card button.update-btn:hover {
            background-color: #0056b3;
        }

        /* Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            overflow-y: auto;
        }

        .modal-content {
            background-color: #fff;
            margin: 80px auto;
            padding: 30px;
            border-radius: 12px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 15px 25px rgba(0, 0, 0, 0.3);
            position: relative;
        }

        .modal-title {
            margin-bottom: 20px;
            text-align: center;
            color: #2c3e50;
            font-weight: 600;
        }

        .modal-form .form-group {
            margin-bottom: 20px;
        }

        .modal-form label {
            display: block;
            font-weight: 500;
            color: #333;
            margin-bottom: 6px;
        }

        .modal-form input[type="text"],
        .modal-form input[type="email"],
        .modal-form input[type="number"] {
            width: 92%;
            padding: 14px 16px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 16px;
        }

        .modal-form input[type="text"]:focus {
            outline: none;
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
        }

        .form-actions {
            text-align: center;
        }

        .modal-form input[type="submit"] {
            background-color: #007bff;
            color: #fff;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
        }

        .modal-form input[type="submit"]:hover {
            background-color: #0056b3;
        }

        .close {
            position: absolute;
            right: 20px;
            top: 16px;
            font-size: 26px;
            cursor: pointer;
            color: #aaa;
        }

        .close:hover {
            color: #000;
        }

        .error-message {
            color: red;
            font-size: 12px;
        }
        
        .search-bar-container {
            margin-bottom: 20px;
            display: flex;
            justify-content: left;
            margin-left: 15%;
        }

        .search-bar {
            width: 20%;
            padding: 10px;
            font-size: 16px;
            border-radius: 8px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>

<div class="header-container">
    <h2>Your Articles</h2>
    <div class="create-form">
        <button class="create-btn" onclick="openCreateModal()">Create New Article</button>
    </div>
</div>

<div class="search-bar-container">
    <input type="text" id="searchBar" class="search-bar" placeholder="Search articles by title, subject, or author" oninput="filterArticles()" />
</div>

<div class="article-container" id="articleContainer">
    <c:forEach var="article" items="${articleList}">
        <div class="card" data-title="${article.title}" data-subject="${article.subject}" data-writtenby="${article.writtenBy}">
            <h3>${article.title}</h3>
            <p><strong>Subject:</strong> ${article.subject}</p>
            <p><strong>Written By:</strong> ${article.writtenBy}</p>

            <button
                type="button"
                class="update-btn"
                onclick="openUpdateModal('${article.articleId}', '${article.title}', '${article.subject}', '${article.writtenBy}')"
            >
                Update
            </button>

            <form action="articledelete" method="post" style="display:inline;" onsubmit="return confirmDelete()">
                <input type="hidden" name="articleId" value="${article.articleId}">
                <input type="submit" value="Delete">
            </form>
        </div>
    </c:forEach>
</div>

<!-- Update Modal -->
<div id="updateModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('updateModal')">&times;</span>
        <h2 class="modal-title">Update Article</h2>
        <form action="articleupdate" method="post" class="modal-form" id="updateForm">
            <input type="hidden" name="articleId" id="modal-articleId" />

            <div class="form-group">
                <label for="modal-title">Title</label>
                <input type="text" name="title" id="modal-title"  />
                <div id="update-title-error" class="error-message"></div>
            </div>

            <div class="form-group">
                <label for="modal-subject">Subject</label>
                <input type="text" name="subject" id="modal-subject"  />
                <div id="update-subject-error" class="error-message"></div>
            </div>

            <div class="form-group">
                <label for="modal-writtenBy">Written By</label>
                <input type="text" name="writtenBy" id="modal-writtenBy"  />
                <div id="update-writtenBy-error" class="error-message"></div>
            </div>

            <div class="form-actions">
                <input type="submit" value="Update Article" />
            </div>
        </form>
    </div>
</div>

<!-- Create Modal -->
<div id="createModal" class="modal">
    <div class="modal-content">
        <span class="close" onclick="closeModal('createModal')">&times;</span>
        <h2 class="modal-title">Create New Article</h2>
        <form action="insertarticle" method="post" class="modal-form" id="createForm">
            <input type="hidden" name="userId" value="${sessionScope.userId}" />

            <div class="form-group">
                <label for="create-title">Title</label>
                <input type="text" name="title" id="create-title"  />
                <div id="create-title-error" class="error-message"></div>
            </div>

            <div class="form-group">
                <label for="create-subject">Subject</label>
                <input type="text" name="subject" id="create-subject"  />
                <div id="create-subject-error" class="error-message"></div>
            </div>

            <div class="form-group">
                <label for="create-writtenBy">Written By</label>
                <input type="text" name="writtenBy" id="create-writtenBy"  />
                <div id="create-writtenBy-error" class="error-message"></div>
            </div>

            <div class="form-actions">
                <input type="submit" value="Submit Article" />
            </div>
        </form>
    </div>
</div>

<script>

function filterArticles() {
    const searchQuery = document.getElementById('searchBar').value.toLowerCase();
    const articles = document.querySelectorAll('.card');

    articles.forEach(article => {
        const title = article.getAttribute('data-title').toLowerCase();
        const subject = article.getAttribute('data-subject').toLowerCase();
        const writtenBy = article.getAttribute('data-writtenby').toLowerCase();

        // Check if any of the article's fields match the search query
        if (title.includes(searchQuery) || subject.includes(searchQuery) || writtenBy.includes(searchQuery)) {
            article.style.display = 'block'; // Show article
        } else {
            article.style.display = 'none'; // Hide article
        }
    });
}

    // Disable submit button only after form submission, and re-enable it if validation fails
    document.getElementById("createForm").addEventListener("submit", function(event) {
        const isValid = validateCreateForm();
        if (!isValid) {
            event.preventDefault();
            return;
        }

        const submitButton = event.target.querySelector("input[type='submit']");
        submitButton.disabled = true;
        submitButton.value = "Submitting...";
    });

    document.getElementById("updateForm").addEventListener("submit", function(event) {
        const isValid = validateUpdateForm();
        if (!isValid) {
            event.preventDefault();
            return;
        }

        const submitButton = event.target.querySelector("input[type='submit']");
        submitButton.disabled = true;
        submitButton.value = "Updating...";
    });

    function validateCreateForm() {
        let isValid = true;

        document.getElementById('create-title-error').textContent = '';
        document.getElementById('create-subject-error').textContent = '';
        document.getElementById('create-writtenBy-error').textContent = '';

        const createTitle = document.getElementById('create-title').value.trim();
        if (!createTitle) {
            document.getElementById('create-title-error').textContent = 'Title is required!';
            isValid = false;
        }

        const createSubject = document.getElementById('create-subject').value.trim();
        if (!createSubject) {
            document.getElementById('create-subject-error').textContent = 'Subject is required!';
            isValid = false;
        }

        const createWrittenBy = document.getElementById('create-writtenBy').value.trim();
        if (!createWrittenBy) {
            document.getElementById('create-writtenBy-error').textContent = 'Written By is required!';
            isValid = false;
        }

        if (!isValid) {
            const submitButton = document.getElementById('createForm').querySelector("input[type='submit']");
            submitButton.disabled = false;
            submitButton.value = "Submit Article";
        }

        return isValid;
    }

    function validateUpdateForm() {
        let isValid = true;

        document.getElementById('update-title-error').textContent = '';
        document.getElementById('update-subject-error').textContent = '';
        document.getElementById('update-writtenBy-error').textContent = '';

        const updateTitle = document.getElementById('modal-title').value.trim();
        if (!updateTitle) {
            document.getElementById('update-title-error').textContent = 'Title is required!';
            isValid = false;
        }

        const updateSubject = document.getElementById('modal-subject').value.trim();
        if (!updateSubject) {
            document.getElementById('update-subject-error').textContent = 'Subject is required!';
            isValid = false;
        }

        const updateWrittenBy = document.getElementById('modal-writtenBy').value.trim();
        if (!updateWrittenBy) {
            document.getElementById('update-writtenBy-error').textContent = 'Written By is required!';
            isValid = false;
        }

        if (!isValid) {
            const submitButton = document.getElementById('updateForm').querySelector("input[type='submit']");
            submitButton.disabled = false;
            submitButton.value = "Update Article";
        }

        return isValid;
    }

    function openCreateModal() {
        document.getElementById('createModal').style.display = 'block';
    }

    function openUpdateModal(articleId, title, subject, writtenBy) {
        document.getElementById('modal-articleId').value = articleId;
        document.getElementById('modal-title').value = title;
        document.getElementById('modal-subject').value = subject;
        document.getElementById('modal-writtenBy').value = writtenBy;
        document.getElementById('updateModal').style.display = 'block';
    }

    function closeModal(modalId) {
        document.getElementById(modalId).style.display = 'none';
    }

    function confirmDelete() {
        return confirm("Are you sure you want to delete this article?");
    }
</script>

<%@ include file="footer.jsp" %>
</body>
</html>
