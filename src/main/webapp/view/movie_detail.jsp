<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>${movie.title} - FilmFanatic</title>
  <style>
     body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0e1626;
            color: white;
        }

         header {
            background-color: #141d2f;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            color: #e50914;
        }

        .logo img {
            height: 28px;
            margin-right: 10px;
            filter: brightness(0) saturate(100%) invert(21%) sepia(97%) saturate(7476%) hue-rotate(353deg) brightness(92%) contrast(106%);
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 100px;
            font-size: 24px;
        }

         .search-bar {
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            background-color: #1e2b3a;
            color: white;
            width:400px;
            height: 35px;
        }
         .actions a {
            margin-left: 20px;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            color: white;
            font-size: 20px;
        }

        .profile {
            background-color: #2980b9;
        }

        .logout {
            background-color: #c0392b;
        }
        
        nav a:hover {
            color: #E50815;
        }
          

    .container {
      width: 60%;
      max-width: 100%;
      margin: 0 auto;
      padding: 2rem 5vw;
      background-color: #1c1f26;
    }

    .movie-banner {
      width: 100%;
      max-width: 1080px;
      height: auto;
      max-height: 600px;
      object-fit: contain;
      border-radius: 10px;
      display: block;
      margin: 0 auto;
    }

    .movie-info {
      margin-top: 2rem;
    }

    .movie-info h2 {
      font-size: 2.5rem;
      margin-bottom: 0.5rem;
    }

    .movie-info p {
      color: #d0d0d0;
      line-height: 1.6;
    }

    .actions {
      margin-top: 1.5rem;
    }

    .actions button {
      background-color: #e50914;
      color: white;
      border: none;
      padding: 0.6rem 1.2rem;
      margin-right: 1rem;
      border-radius: 5px;
      cursor: pointer;
      transition: background 0.3s;
    }

    .actions button:hover {
      background-color: #b0060f;
    }

    .review-section {
      margin-top: 3rem;
    }

    .review-form {
      background-color: #2c2f36;
      padding: 1.5rem;
      border-radius: 8px;
      margin-bottom: 2rem;
      border: 1px solid #3c3f46;
    }

    .form-group {
      margin-bottom: 1.5rem;
    }

    .form-group label {
      display: block;
      margin-bottom: 0.75rem;
      color: #fff;
      font-size: 1.1rem;
      font-weight: 500;
    }

    .form-group input,
    .form-group textarea {
      width: 100%;
      padding: 0.75rem;
      border: 1px solid #3c3f46;
      border-radius: 4px;
      background-color: #1c1f26;
      color: white;
      font-size: 1rem;
      transition: border-color 0.3s ease;
    }

    .form-group input:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: #2980b9;
    }

    .form-group textarea {
      min-height: 120px;
      resize: vertical;
    }

    .review-form button[type="submit"] {
      background-color: #27ae60;
      color: white;
      border: none;
      padding: 0.75rem 1.5rem;
      border-radius: 4px;
      cursor: pointer;
      font-size: 1rem;
      font-weight: 500;
      transition: background-color 0.3s ease;
    }

    .review-form button[type="submit"]:hover {
      background-color: #219a52;
    }

    .review {
      background-color: #2c2f36;
      padding: 1.5rem;
      margin-bottom: 1rem;
      border-radius: 8px;
    }

    .review-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1rem;
    }

    .review-header h4 {
      margin: 0;
      color: #fff;
    }

    .rating {
      color: #ffc107;
      margin-left: 0.5rem;
    }

    .review-actions {
      display: flex;
      gap: 0.5rem;
    }

    .edit-btn,
    .delete-btn {
      padding: 0.25rem 0.75rem;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      font-size: 0.875rem;
    }

    .edit-btn {
      background-color: #2980b9;
      color: white;
    }

    .delete-btn {
      background-color: #c0392b;
      color: white;
    }

    .review-comment {
      color: #d0d0d0;
      line-height: 1.6;
      margin: 0;
    }

    .edit-form {
      margin-top: 1rem;
      padding-top: 1rem;
      border-top: 1px solid #3c3f46;
    }

    .form-actions {
      display: flex;
      gap: 1rem;
      margin-top: 1rem;
    }

    .form-actions button {
      padding: 0.5rem 1rem;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .form-actions button[type="submit"] {
      background-color: #27ae60;
      color: white;
    }

    .form-actions button[type="button"] {
      background-color: #7f8c8d;
      color: white;
    }

    .footer {
      background-color: #161b22;
      color: #aaa;
      text-align: center;
      padding: 1.5rem 0;
      margin-top: 3rem;
    }

    .login-message {
        background-color: #2c2f36;
        padding: 1.5rem;
        border-radius: 8px;
        margin-bottom: 2rem;
        text-align: center;
        border: 1px solid #3c3f46;
    }

    .login-message p {
        color: #d0d0d0;
        font-size: 1.1rem;
        margin: 0;
    }

    .login-message a {
        color: #2980b9;
        text-decoration: none;
        font-weight: 500;
    }

    .login-message a:hover {
        text-decoration: underline;
    }
  </style>
</head>
<body>
 <header>
    <div class="logo">
        <img src="https://img.icons8.com/ios-filled/50/ffffff/movie-projector.png" alt="logo"/>
        FilmFanatic
    </div>
    <nav>
        <a href="${pageContext.request.contextPath}/view/dashboard.jsp">Home</a>
        <a href="${pageContext.request.contextPath}/view/movielist">Movies</a>
        <a href="${pageContext.request.contextPath}/view/about.jsp">About</a>
        <a href="${pageContext.request.contextPath}/view/contact.jsp">Contact</a>
        <input type="text" class="search-bar" placeholder="Search Movies...">
    </nav>
       <div class="actions">
          <a href="${pageContext.request.contextPath}/view/profile.jsp" class="profile">Profile</a>
          <a href="${pageContext.request.contextPath}/view/logout.jsp" class="logout">
             <img src="https://img.icons8.com/material-rounded/24/ffffff/exit.png" alt="Logout Icon"
                  style="vertical-align: middle; margin-right: 5px;" />
                Logout
            </a>
   	 </div>
</header>

  <div class="container">
    <c:if test="${empty movie}">
        <div class="error-message">
            <h2>Movie Not Found</h2>
            <p>The movie you're looking for doesn't exist or has been removed.</p>
            <a href="movie_list.jsp" class="btn">Back to Movies</a>
        </div>
    </c:if>

    <c:if test="${not empty movie}">
        <c:choose>
            <c:when test="${not empty movie.imageBase64}">
                <img src="data:image/jpeg;base64,${movie.imageBase64}" alt="${movie.title}" class="movie-banner">
            </c:when>
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/images/default-movie.png" alt="Default Movie Image" class="movie-banner">
            </c:otherwise>
        </c:choose>

        <div class="movie-info">
            <h2>${movie.title}</h2>
            <p><strong>Genre:</strong> ${movie.genreName}</p>
            <p><strong>Year:</strong> ${movie.releaseDate} &nbsp;&nbsp; <strong>Rating:</strong> <fmt:formatNumber value="${movie.averageRating}" pattern="#.#"/> /10</p>
            <p><strong>Director:</strong> ${movie.director}</p>
            <p><strong>Cast:</strong> ${movie.cast}</p>
            <p>${movie.description}</p>
        </div>


        <div class="review-section">
            <h3>Reviews</h3>
            
            <!-- Review Form or Login Message -->
            <div class="review-form">
                <c:choose>
                    <c:when test="${sessionScope.userId != null}">
                        <form action="${pageContext.request.contextPath}/movie/${movie.movieId}" method="post">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="movieId" value="${movie.movieId}">
                            <div class="form-group">
                                <label for="rating">Your Rating (1-10):</label>
                                <input type="text" name="rating" id="rating" pattern="[1-9](\.[0-9])?|10(\.0)?" 
                                       title="Please enter a number between 1 and 10 (can include one decimal place)" required>
                            </div>
                            <div class="form-group">
                                <label for="comment">Your Review:</label>
                                <textarea name="comment" id="comment" rows="4" required></textarea>
                            </div>
                            <button type="submit">Submit Review</button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="login-message">
                            <p>Please <a href="${pageContext.request.contextPath}/login.jsp">log in</a> to write a review.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Reviews List -->
            <div class="reviews-list">
                <c:forEach items="${reviews}" var="review">
                    <div class="review" id="review-${review.reviewId}">
                        <div class="review-header">
                            <h4>${review.username} <span class="rating">⭐ ${review.rating}/10</span></h4>
                            <small>${review.reviewDate}</small>
                            <c:if test="${sessionScope.userId == review.userId}">
                                <div class="review-actions">
                                    <button type="button" class="edit-btn" onclick="editReview('${review.reviewId}')">Edit</button>
                                    <form action="${pageContext.request.contextPath}/movie/${movie.movieId}" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="reviewId" value="${review.reviewId}">
                                        <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this review?')">Delete</button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                        <p class="review-comment">${review.comment}</p>
                        
                        <!-- Edit Form (Hidden by default) -->
                        <c:if test="${sessionScope.userId == review.userId}">
                            <form id="edit-form-${review.reviewId}" class="edit-form" style="display: none;" 
                                  action="${pageContext.request.contextPath}/movie/${movie.movieId}" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="reviewId" value="${review.reviewId}">
                                <div class="form-group">
                                    <label for="edit-rating-${review.reviewId}">Rating:</label>
                                    <input type="text" name="rating" id="edit-rating-${review.reviewId}" 
                                           pattern="[1-9](\.[0-9])?|10(\.0)?" 
                                           title="Please enter a number between 1 and 10 (can include one decimal place)"
                                           value="${review.rating}" required>
                                </div>
                                <div class="form-group">
                                    <label for="edit-comment-${review.reviewId}">Review:</label>
                                    <textarea name="comment" id="edit-comment-${review.reviewId}" 
                                              rows="4" required>${review.comment}</textarea>
                                </div>
                                <div class="form-actions">
                                    <button type="submit">Save Changes</button>
                                    <button type="button" onclick="cancelEdit(${review.reviewId})">Cancel</button>
                                </div>
                            </form>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </div>
    </c:if>
  </div>

  <div class="footer">
    &copy; 2025 FilmFanatic. All rights reserved.
  </div>

  <script>
    function editReview(reviewId) {
        console.log('Editing review:', reviewId); // Debug log
        
        // Get the review element
        const reviewElement = document.getElementById('review-' + reviewId);
        if (!reviewElement) {
            console.error('Review element not found:', reviewId);
            return;
        }
        
        // Hide the review content and actions
        const reviewComment = reviewElement.querySelector('.review-comment');
        const reviewActions = reviewElement.querySelector('.review-actions');
        const editForm = reviewElement.querySelector('#edit-form-' + reviewId);
        
        if (reviewComment) reviewComment.style.display = 'none';
        if (reviewActions) reviewActions.style.display = 'none';
        if (editForm) editForm.style.display = 'block';
    }

    function cancelEdit(reviewId) {
        console.log('Canceling edit for review:', reviewId); // Debug log
        
        // Get the review element
        const reviewElement = document.getElementById('review-' + reviewId);
        if (!reviewElement) {
            console.error('Review element not found:', reviewId);
            return;
        }
        
        // Show the review content and actions
        const reviewComment = reviewElement.querySelector('.review-comment');
        const reviewActions = reviewElement.querySelector('.review-actions');
        const editForm = reviewElement.querySelector('#edit-form-' + reviewId);
        
        if (reviewComment) reviewComment.style.display = 'block';
        if (reviewActions) reviewActions.style.display = 'flex';
        if (editForm) editForm.style.display = 'none';
    }
  </script>
</body>
</html>
