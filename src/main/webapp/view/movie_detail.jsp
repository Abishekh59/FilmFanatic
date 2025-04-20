<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Movie Details - FilmFanatic</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #0d1117;
      color: #ffffff;
    }

    header {
      background-color: #161b22;
      padding: 1rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
      width: 100%;
    }

    header h1 {
      color: #e50914;
      margin: 0;
    }

    nav a {
      color: white;
      margin: 0 1rem;
      text-decoration: none;
    }

    nav a:hover {
      text-decoration: underline;
    }

    .container {
      width: 100%;
      max-width: 100%;
      margin: 0 auto;
      padding: 2rem 5vw;
      background-color: #1c1f26;
    }

    .movie-banner {
      width: 1080px;
      height: 600px;
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
    }

    .review-form h3 {
      margin-bottom: 1rem;
    }

    .review-form input, .review-form textarea {
      width: 100%;
      padding: 0.75rem;
      margin-bottom: 1rem;
      border: none;
      border-radius: 4px;
      background-color: #1c1f26;
      color: white;
    }

    .review-form button {
      background-color: #e50914;
      color: white;
      border: none;
      padding: 0.5rem 1.2rem;
      border-radius: 4px;
      cursor: pointer;
    }

    .review-form button:hover {
      background-color: #b0060f;
    }

    .review {
      background-color: #2c2f36;
      padding: 1rem;
      margin-top: 1rem;
      border-radius: 8px;
    }

    .review h4 {
      margin-bottom: 0.3rem;
    }

    .footer {
      background-color: #161b22;
      color: #aaa;
      text-align: center;
      padding: 1.5rem 0;
      margin-top: 3rem;
    }
  </style>
</head>
<body>

  <header>
    <h1>FilmFanatic</h1>
    <nav>
      <a href="home.jsp">Home</a>
      <a href="movies.jsp">Movies</a>
      <a href="about.jsp">About</a>
      <a href="profile.jsp">Profile</a>
      <a href="logout.jsp">Logout</a>
    </nav>
  </header>

  <div class="container">
    <img src="https://i.ibb.co/KbgMYht/stranger-things.jpg" alt="Stranger Things" class="movie-banner">
    
    <div class="movie-info">
      <h2>Stranger Things</h2>
      <p><strong>Genre:</strong> Sci-Fi, Thriller, Mystery</p>
      <p><strong>Year:</strong> 2022 &nbsp;&nbsp; <strong>Duration:</strong> 136 min</p>
      <p><strong>Director:</strong> Matt Duffer and Ross Duffer</p>
      <p>
        When a young boy vanishes, a small town uncovers a mystery involving secret experiments,
        terrifying supernatural forces and one strange little girl.
      </p>
    </div>

    <div class="actions">
      <button onclick="window.open('https://youtube.com', '_blank')">▶ Watch Trailer</button>
      <button>Add to Favorites</button>
    </div>

    <div class="review-section">
      <h3>Reviews</h3>

      <!-- Review Submission Form -->
      <div class="review-form">
        <form action="submitReview.jsp" method="post">
          <label for="rating">Your Rating (1-10):</label>
          <input type="number" name="rating" min="1" max="10" required>
          <textarea name="comment" placeholder="Write your review here..." rows="4" required></textarea>
          <button type="submit">Submit Review</button>
        </form>
      </div>

      <!-- Example Reviews -->
      <div class="review">
        <h4>MovieFan123 <span style="color: #ffc107;">⭐ 9/10</span></h4>
        <small>02/01/2023</small>
        <p>One of the best movies I’ve ever seen! The concept is mind-blowing and the execution is perfect.</p>
      </div>

      <div class="review">
        <h4>CinemaLover <span style="color: #ffc107;">⭐ 8/10</span></h4>
        <small>02/02/2023</small>
        <p>Incredible movie with amazing visual effects and a complex storyline.</p>
      </div>

    </div>
  </div>

  <div class="footer">
    &copy; 2025 FilmFanatic. All rights reserved.
  </div>

</body>
</html>
