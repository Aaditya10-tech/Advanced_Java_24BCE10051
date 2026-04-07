<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toast Notification</title>
    <style>
        /* Toast container */
        #toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
        }

        /* Toast basic styling */
        .toast {
            background-color: #333;
            color: white;
            padding: 15px;
            margin: 5px;
            border-radius: 5px;
            font-size: 16px;
            opacity: 1;
            transition: opacity 0.5s ease;
            display: none;
            min-width: 250px;
            text-align: center;
        }

        .toast.success {
            background-color: #28a745; /* Green */
        }

        .toast.error {
            background-color: #dc3545; /* Red */
        }

        .toast.warning {
            background-color: #ffc107; /* Yellow */
        }

        /* Toast close button */
        .toast .close-btn {
            margin-left: 15px;
            background-color: transparent;
            border: none;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
</head>
<body>

    <div id="toast-container"></div>

    <script>
        // Function to show a toast notification
        function showToast(message, type = 'info', duration = 3000) {
            let toastContainer = document.getElementById('toast-container');
            if (!toastContainer) {
                toastContainer = document.createElement('div');
                toastContainer.id = 'toast-container';
                document.body.appendChild(toastContainer);
            }

            // Create a new toast element
            const toast = document.createElement('div');
            toast.classList.add('toast', type);

            // Create the close button for the toast
            const closeBtn = document.createElement('button');
            closeBtn.classList.add('close-btn');
            closeBtn.innerHTML = '&times;'; // Close icon

            // Attach the close event to remove the toast
            closeBtn.onclick = function() {
                toast.remove();
            };

            // Set the message and append the close button
            toast.innerHTML = message;
            toast.appendChild(closeBtn);

            // Append the toast to the container
            toastContainer.appendChild(toast);

            // Show the toast
            toast.style.display = 'block';

            // Hide and remove the toast after the specified duration
            setTimeout(() => {
                toast.style.opacity = '0';
                setTimeout(() => {
                    toast.remove();
                }, 500);
            }, duration);
        }
    </script>

</body>
</html>
