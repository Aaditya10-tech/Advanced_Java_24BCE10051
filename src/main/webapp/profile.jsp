<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ include file="navBar.jsp" %>
  <meta charset="ISO-8859-1">
  <title>User Profile</title>
    <style>
    html, body {
      height: 100%;
      margin: 0;
    }

    body {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      font-family: Arial, sans-serif;
      background: #f7f7f7;
    }

    .container {
      flex: 1;
      width: 800px;
      margin: 20px auto;
      padding: 20px;
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }

    .profile-header {
      text-align: center;
      margin-bottom: 30px;
    }

    .profile-header img {
      border-radius: 50%;
      width: 150px;
      height: 150px;
      object-fit: cover;
      border: 3px solid #007bff;
    }

    .user-info {
      display: flex;
      justify-content: space-between;
      padding: 15px;
      background: #f9f9f9;
      border-radius: 8px;
      margin-bottom: 10px;
    }

    .user-info p {
      margin: 5px 0;
      color: #555;
    }

    .user-info .label {
      font-weight: bold;
      color: #007bff;
    }

    .actions {
      display: flex;
      justify-content: center;
      gap: 10px;
      margin-bottom: 30px;
    }

    button, .actions input[type="submit"] {
      padding: 10px 20px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 16px;
      transition: background 0.3s;
    }

    button.edit {
      background: #007bff;
      color: #fff;
    }

    button.edit:hover {
      background: #0056b3;
    }

    .delete {
      background: #e74c3c;
      color: #fff;
    }

    .delete:hover {
      background: #c0392b;
    }

    /* Modal */
    .modal {
      display: none;
      position: fixed;
      top: 0; left: 0;
      width: 100%; height: 100%;
      background: rgba(0,0,0,0.4);
      align-items: center;
      justify-content: center;
    }

    .modal.show {
      display: flex;
    }

    .modal-content {
      background: #fff;
      border-radius: 8px;
      padding: 20px;
      width: 90%;
      max-width: 500px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      position: relative;
    }

    .modal-content h2 {
      margin-top: 0;
    }

    .modal-content .close {
      position: absolute;
      top: 10px;
      right: 15px;
      font-size: 24px;
      color: #aaa;
      cursor: pointer;
    }

    .modal-content .close:hover {
      color: #000;
    }

    .modal-content form {
      display: flex;
      flex-direction: column;
      gap: 10px;
    }

    .modal-content input[type="text"],
    .modal-content input[type="email"],
    .modal-content input[type="number"],
    .modal-content input[type="password"] {
      padding: 10px;
      font-size: 16px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }

    .modal-content input[type="submit"] {
      background: #007bff;
      color: #fff;
      border: none;
      padding: 10px;
      border-radius: 5px;
      cursor: pointer;
    }

    .modal-content input[type="submit"]:hover {
      background: #0056b3;
    }
    
    .error {
      color: red;
      font-size: 12px;
      margin-top: 5px;
    }
    
    .error-message {
      color: red;
      padding: 10px;
      background-color: #f8d7da;
      border-radius: 5px;
      margin-bottom: 20px;
    }
  </style>
</head>
<body>
  <div class="container">
  <c:if test="${not empty deleteError}">
        <div class="error-message">
            <strong>Error: </strong>${deleteError}
        </div>
    </c:if>
    <div class="profile-header">
      <img src="images/profile.png" alt="Profile Picture">
      <h1>User Profile</h1>
    </div>

    <c:forEach var="user" items="${userdetails}">
      <div class="user-info">
        <div><p class="label">User ID:</p><p>${user.uid}</p></div>
        <div><p class="label">Name:</p><p>${user.name}</p></div>
        <div><p class="label">Email:</p><p>${user.email}</p></div>
        <div><p class="label">Phone:</p><p>${user.phone_number}</p></div>
      </div>
      <div class="actions">
        <!-- Edit button carries data- attributes for JS -->
        <button class="edit"
          data-uid="${user.uid}"
          data-name="${user.name}"
          data-email="${user.email}"
          data-phone="${user.phone_number}"
          data-password="${user.password}">
          Edit Profile
        </button>
        <form action="DeleteProfileServlet" method="post" onsubmit="return confirm('Are you sure you want to delete this account?');">
          <input type="hidden" name="uid" value="${user.uid}">
          <input type="submit" value="Delete Account" class="delete">
        </form>
      </div>
    </c:forEach>
  </div>

  <!-- Modal -->
  <div id="editModal" class="modal">
    <div class="modal-content">
      <span class="close">&times;</span>
      <h2>Edit Profile</h2>
      <form id="editProfileForm" action="ProfileUpdateServlet" method="post">
  <input type="hidden" id="modal-uid" name="uid">

  <!-- Name Field -->
  <label for="modal-name">Name</label>
  <input type="text" id="modal-name" name="name" placeholder="Name">
  <span id="name-error" class="error"></span> <!-- Error message for name -->

  <!-- Email Field -->
  <label for="modal-email">Email</label>
  <input type="email" id="modal-email" name="email" placeholder="Email">
  <span id="email-error" class="error"></span> <!-- Error message for email -->

  <!-- Phone Field -->
  <label for="modal-phone">Phone</label>
  <input type="number" id="modal-phone" name="phone" placeholder="Phone">
  <span id="phone-error" class="error"></span> <!-- Error message for phone -->

  <!-- Password Field -->
  <label for="modal-pass">Password</label>
  <input type="password" id="modal-pass" name="password" placeholder="Password">
  <span id="pass-error" class="error"></span> <!-- Error message for password -->

  <input type="submit" value="Update Profile">
</form>

    </div>
  </div>

  <script>
    // Grab modal elements
    const modal      = document.getElementById('editModal');
    const closeBtn   = modal.querySelector('.close');
    const form       = document.getElementById('editProfileForm');
    const inputs     = {
      uid:   document.getElementById('modal-uid'),
      name:  document.getElementById('modal-name'),
      email: document.getElementById('modal-email'),
      phone: document.getElementById('modal-phone'),
      pass:  document.getElementById('modal-pass'),
    };
    const errorSpans = {
      name:  document.getElementById('name-error'),
      email: document.getElementById('email-error'),
      phone: document.getElementById('phone-error'),
      pass:  document.getElementById('pass-error')
    };

    // Open modal and populate fields
    document.querySelectorAll('button.edit').forEach(btn => {
      btn.addEventListener('click', () => {
        inputs.uid.value   = btn.dataset.uid;
        inputs.name.value  = btn.dataset.name;
        inputs.email.value = btn.dataset.email;
        inputs.phone.value = btn.dataset.phone;
        inputs.pass.value  = btn.dataset.password;
        modal.classList.add('show');
      });
    });

    // Close modal
    closeBtn.addEventListener('click', () => modal.classList.remove('show'));
    window.addEventListener('click', e => {
      if (e.target === modal) modal.classList.remove('show');
    });

    // Basic form validation with error messages
    form.addEventListener('submit', function(event) {
      let valid = true;

      // Clear previous errors
      Object.values(errorSpans).forEach(span => span.textContent = '');

      // Validate name
      if (inputs.name.value.trim() === '') {
        errorSpans.name.textContent = 'Name cannot be empty.';
        valid = false;
      }

      // Validate email
      const emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
      if (!emailPattern.test(inputs.email.value)) {
        errorSpans.email.textContent = 'Please enter a valid email address.';
        valid = false;
      }

      // Validate phone
      const phone = inputs.phone.value;
      if (isNaN(phone) || phone.length < 10) {
        errorSpans.phone.textContent = 'Please enter a valid phone number.';
        valid = false;
      }

      // Validate password (optional check, if field is not empty)
      if (inputs.pass.value.trim() !== '' && inputs.pass.value.length < 3) {
        errorSpans.pass.textContent = 'Password must be at least 3 characters long.';
        valid = false;
      }

      if (!valid) {
        event.preventDefault();  // Prevent form submission if invalid
      }
    });
  </script>
  <%@ include file="footer.jsp" %>
</body>
</html>
