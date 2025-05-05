<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Movie Details - FilmFanatic</title>
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
    <div class="logo">
        <img src="https://img.icons8.com/ios-filled/50/ffffff/movie-projector.png" alt="logo"/>
        FilmFanatic
    </div>
    <nav>
    <a href="dashboard.jsp">Home</a>
    <a href="movie_list.jsp">Movies</a>
    <a href="about.jsp">About</a>
    <a href="contact.jsp">Contact</a> <!-- New link -->
    <input type="text" class="search-bar" placeholder="Search Movies...">
</nav>
       <div class="actions">
          <a href="profile.jsp" class="profile">Profile</a>
          <a href="logout.jsp" class="logout">
             <img src="https://img.icons8.com/material-rounded/24/ffffff/exit.png" alt="Logout Icon"
                  style="vertical-align: middle; margin-right: 5px;" />
                Logout
            </a>
   	 </div>
</header>

  <div class="container">
  <img src="https://image.tmdb.org/t/p/w500/q719jXXEzOoYaps6babgKnONONX.jpg" alt="Your Name" class="movie-banner">

  <div class="movie-info">
    <h2>Your Name</h2>
    <p><strong>Genre:</strong> Anime, Romance, Drama</p>
    <p><strong>Year:</strong> 2016 &nbsp;&nbsp; <strong>Duration:</strong> 112 min</p>
    <p><strong>Director:</strong> Makoto Shinkai</p>
    <p>
      Two teenagers share a profound, magical connection upon discovering they are swapping bodies.
      Things manage to become even more complicated when the boy and girl decide to meet in person.
    </p>
  </div>

  <div class="actions">
    <button onclick="window.open('https://www.youtube.com/watch?v=xU47nhruN-Q', '_blank')">▶ Watch Trailer</button>
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
      <h4>AnimeLover22 <span style="color: #ffc107;">⭐ 10/10</span></h4>
      <small>01/15/2023</small>
      <p>Absolutely breathtaking! The story, animation, and music were all phenomenal.</p>
    </div>

    <div class="review">
      <h4>RomanceFan <span style="color: #ffc107;">⭐ 9/10</span></h4>
      <small>01/20/2023</small>
      <p>A beautifully crafted film that stays with you long after the credits roll.</p>
    </div>

  </div>
</div>


  <div class="footer">
    &copy; 2025 FilmFanatic. All rights reserved.
  </div>

</body>
</html>
