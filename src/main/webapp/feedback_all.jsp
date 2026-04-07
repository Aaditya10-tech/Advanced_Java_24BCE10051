<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="navBar.jsp" %>
    <meta charset="UTF-8">
    <title>Client Feedback</title>

    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>

    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            display: flex;
            flex-direction: column;
        }

        .page-wrapper {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        h2 {
            margin-top:2%;
            text-align: center;
            color: #000000;
            font-size: 28px;
        }

        .swiper {
            width: 90%;
            padding: 10px 0 30px;
            flex: 1;
        }

        .swiper-slide {
    display: flex;
    justify-content: center;
    padding: 0; /* remove extra padding if any */
    margin: 0;  /* remove extra margin */
}


        .feedback-card {
        margin-top:5%;
            background-color: #d9d9d9;
            color: #000000;
            border-radius: 15px;
            padding: 20px;
            width: 280px;
            height: 250px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            text-align: center;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow: hidden;
        }

        .avatar {
            width: 80px;
            height: 80px;
            margin: 0 auto 10px;
            background-color: white;
            border-radius: 50%;
            background-image: url('https://cdn-icons-png.flaticon.com/512/149/149071.png');
            background-size: 60%;
            background-repeat: no-repeat;
            background-position: center;
        }

        .message {
            font-style: italic;
            margin: 15px 0;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
        }

        .rating {
            font-weight: bold;
            color: #ffcc00;
            font-size: 20px;
        }

        .footer {
            background-color: #333;
            color: white;
            padding: 20px;
            text-align: center;
            font-size: 14px;
        }
    </style>
</head>
<body>
<div class="page-wrapper">
    <h2>What Our Clients Say</h2>

    <!-- Swiper Slider -->
    <div class="swiper">
        <div class="swiper-wrapper">
            <c:forEach var="feedback" items="${feedbackList}">
                <div class="swiper-slide">
                    <div class="feedback-card">
                        <div class="avatar"></div>
                        <p class="message">"${feedback.message}"</p>
                        <p class="rating">
                            <c:forEach begin="1" end="5" var="i">
                                <c:choose>
                                    <c:when test="${i <= feedback.rating}">
                                        &#9733;
                                    </c:when>
                                    <c:otherwise>
                                        &#9734;
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </p>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Pagination -->
        <div class="swiper-pagination"></div>
    </div>

    <%@ include file="footer.jsp" %>
</div>

<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
<script>
    new Swiper('.swiper', {
        slidesPerView: 1,
        spaceBetween: 5,  // reduced from 20 or 30
        loop: true,
        autoplay: {
            delay: 4000,
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        breakpoints: {
            768: {
                slidesPerView: 2,
                spaceBetween: 5,  // tighter spacing on tablets
            },
            1024: {
                slidesPerView: 4,
                spaceBetween: 5,  // tighter spacing on desktop
            }
        }
    });
</script>

</body>
</html>
