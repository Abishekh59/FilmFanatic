<!DOCTYPE html>
<html lang="en">

<head>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>FilmFanatic | Profile</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      background-color: #0e1525;
      font-family: Arial, sans-serif;
      color: #ffffff;
    }

    header {
      background: #141d2f;
      padding: 20px 40px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
    }
    .actions a {
            margin-left: 20px;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            color: white;
            font-weight: bold;
            font-size: 14px;
        }

    .logo {
      font-size: 1.5rem;
      font-weight: bold;
      color: white;
      display: flex;
      align-items: center;
    }

    .logo img {
      height: 32px;
      margin-right: 12px;
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

    .user-links a {
      color: white;
      margin-left: 20px;
    }

    .user-links a.active {
      color: #e74c3c;
    }

    .profile-section {
      padding: 2rem;
    }

    .profile-card {
      display: flex;
      background: #1c1f2b;
      padding: 1.5rem;
      border-radius: 10px;
      align-items: center;
      margin-bottom: 2rem;
    }

    .profile-card img {
      border-radius: 50%;
      width: 100px;
      margin-right: 1.5rem;
    }

    .profile-info h2 {
      margin-bottom: 0.2rem;
    }

    .profile-info .email,
    .profile-info .joined,
    .profile-info .bio {
      font-size: 0.9rem;
      margin-bottom: 5px;
    }

    .edit-btn {
      margin-top: 10px;
      padding: 5px 10px;
      background: #333;
      color: white;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .edit-profile-form {
      background: #1c1f2b;
      padding: 1.5rem;
      border-radius: 10px;
    }

    .edit-profile-form input,
    .edit-profile-form textarea {
      width: 100%;
      padding: 10px;
      background: #2a2f3a;
      border: none;
      border-radius: 5px;
      color: white;
      margin-bottom: 10px;
    }

    .edit-profile-form .form-actions {
      display: flex;
      justify-content: flex-end;
      gap: 10px;
    }

    .edit-profile-form button {
      padding: 10px 15px;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .edit-profile-form .cancel-btn {
      background: #555;
      color: white;
    }

    .edit-profile-form .save-btn {
      background: #e74c3c;
      color: white;
    }

    .tabs {
      margin-top: 2rem;
    }

    .tab-btn {
      background: #2a2f3a;
      color: white;
      padding: 10px 20px;
      margin-right: 10px;
      border: none;
      border-radius: 5px 5px 0 0;
      cursor: pointer;
    }

    .tab-btn.active {
      background: red;
    }

    .tab-content {
      display: flex;
      flex-wrap: wrap;
      gap: 1rem;
      padding-top: 1rem;
    }

    .movie-card {
      background: #1c1f2b;
      width: 200px;
      border-radius: 10px;
      overflow: hidden;
    }

    .movie-card img {
      width: 100%;
    }

    .movie-info {
      padding: 10px;
    }

    footer {
      display: flex;
      justify-content: space-around;
      background: #1c1f2b;
      padding: 2rem 1rem;
      color: #ccc;
      flex-wrap: wrap;
    }

    .footer-col h4 {
      margin-bottom: 10px;
    }

    .footer-col a {
      display: block;
      color: #aaa;
      text-decoration: none;
      margin: 5px 0;
    }

    .footer-col p {
      font-size: 0.9rem;
    }

    .copyright {
      background: #111;
      text-align: center;
      padding: 10px;
      font-size: 0.8rem;
      color: #aaa;
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
        <input type="text" class="search-bar" placeholder="Search Movies...">
    </nav>
            <div class="actions">
            <a href="profile.jsp" class="profile">Profile</a>
             <a href="" class="logout">Logout</a>
        </div>
</header>

  <!-- Profile Section -->
  <section class="profile-section">
    <div id="viewProfile">
      <div class="profile-card">
        <img src="https://i.pravatar.cc/100?img=1" alt="User Avatar">
        <div class="profile-info">
          <h2>Abishek Joshi</h2>
          <p class="email">abishek@gmail.com</p>
          <p class="joined">Joined July 17, 2023</p>
          <p class="bio">I'm a huge fan of science fiction and drama films. Christopher Nolan and Denis Villeneuve are my favorite directors.</p>
          <button class="edit-btn" onclick="toggleEdit(true)">Edit Profile</button>
        </div>
      </div>
    </div>

    <div id="editProfile" style="display: none;">
      <form class="edit-profile-form">
        <h3>Edit Profile</h3>
        <label>Username</label>
        <input type="text" value="Abishek Joshi">
        <label>Email</label>
        <input type="email" value="abishek@example.com">
        <label>Avatar URL</label>
        <input type="text" value="https://i.pravatar.cc/100?img=1">
        <label>Bio</label>
        <textarea rows="3">I'm a huge fan of science fiction and drama films. Christopher Nolan and Denis Villeneuve are my favorite directors.</textarea>
        <div class="form-actions">
          <button type="button" class="cancel-btn" onclick="toggleEdit(false)">Cancel</button>
          <button type="submit" class="save-btn">Save Changes</button>
        </div>
      </form>
    </div>

    <!-- Tabs -->
    <div class="tabs">
      <button class="tab-btn active" onclick="showTab('favorites')">Favorites</button>
      <button class="tab-btn" onclick="showTab('reviews')">Reviews</button>
    </div>

    <div class="tab-content" id="favorites">
      <div class="movie-card">
        <img src="https://image.tmdb.org/t/p/w200/rkB5MyhjCfaP4s2tY8RAiDERU3F.jpg" alt="Stranger Things">
        <div class="movie-info">
          <h3>Stranger Things</h3>
          <p>2022 • 135 min</p>
          <p>Sci-Fi, Action, Thriller</p>
        </div>
      </div>
      <div class="movie-card">
        <img src="https://image.tmdb.org/t/p/w200/edv5CZvWj09upOsy2Y6IwDhK8bt.jpg" alt="Inception">
        <div class="movie-info">
          <h3>Inception</h3>
          <p>2022 • 136 min</p>
          <p>Sci-Fi, Action, Thriller</p>
        </div>
      </div>
    </div>

    <div class="tab-content" id="reviews" style="display:none;">
      <p>No reviews yet.</p>
    </div>

    <div class="tab-content" id="watchlist" style="display:none;">
      <p>No movies in watchlist.</p>
    </div>
  </section>

  <!-- Footer -->
  <footer>
    <div class="footer-col">
      <h4>FilmFanatic</h4>
      <p>Your one-stop platform for discovering, rating, and reviewing the best movies from around the world.</p>
      <div class="socials" style="display: flex; gap: 15px; margin-top: 10px;">
        <a href="#" style="color:white;"><i class="fab fa-github fa-lg"></i></a>
        <a href="#" style="color:white;"><i class="fab fa-twitter fa-lg"></i></a>
        <a href="#" style="color:white;"><i class="fab fa-facebook fa-lg"></i></a>
        <a href="#" style="color:white;"><i class="fab fa-instagram fa-lg"></i></a>
      </div>
    </div>
    <div class="footer-col">
      <h4>Quick Links</h4>
      <a href="#">Home</a>
      <a href="#">Movies</a>
      <a href="#">About Us</a>
    </div>
    <div class="footer-col">
      <h4>Genres</h4>
      <a href="#">Action</a>
      <a href="#">Comedy</a>
      <a href="#">Drama</a>
      <a href="#">Horror</a>
      <a href="#">Sci-Fi</a>
    </div>
    <div class="footer-col">
      <p>123 Movie Street, Damak-7</p>
      <p>+023 560908</p>
      <p>info@filmfanatic.com</p>
    </div>
  </footer>

  <div class="copyright">
    © 2025 FilmFanatic. ALL RIGHTS RESERVED
  </div>

  <script>
    function showTab(tabId) {
      const tabs = document.querySelectorAll('.tab-btn');
      const contents = document.querySelectorAll('.tab-content');

      tabs.forEach(btn => btn.classList.remove('active'));
      contents.forEach(content => content.style.display = 'none');

      document.getElementById(tabId).style.display = 'flex';
      document.querySelector(`.tab-btn[onclick="showTab('${tabId}')"]`).classList.add('active');
    }

    function toggleEdit(showEdit) {
      document.getElementById('viewProfile').style.display = showEdit ? 'none' : 'block';
      document.getElementById('editProfile').style.display = showEdit ? 'block' : 'none';
    }
  </script>

</body>

</html>
