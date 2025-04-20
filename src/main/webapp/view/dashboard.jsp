<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - FilmFanatic</title>
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
            color: white;
        }

        .logo img {
            height: 28px;
            margin-right: 10px;
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
            font-weight: bold;
            font-size: 14px;
        }

        .login {
            background-color: transparent;
        }

        .register {
            background-color: #e74c3c;
        }

        .banner {
            background-image: url('https://images.unsplash.com/photo-1524985069026-dd778a71c7b4');
            background-size: cover;
            background-position: center;
            padding: 80px 40px;
            text-align: center;
        }

        .banner h1 {
            font-size: 48px;
            margin-bottom: 20px;
        }

        .banner p {
            font-size: 20px;
            max-width: 700px;
            margin: 0 auto;
            color: #ddd;
        }

        .section {
            padding: 40px;
        }

        .section h2 {
            margin-bottom: 20px;
            font-size: 26px;
            color: #f5f5f5;
        }

        .movie-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            gap: 20px;
        }

        .movie-card {
            background-color: #1a2433;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 6px rgba(0,0,0,0.4);
            transition: transform 0.3s;
        }

        .movie-card:hover {
            transform: scale(1.03);
        }

        .movie-card img {
            width: 100%;
            height: 240px;
            object-fit: cover;
        }

        .movie-card .info {
            padding: 10px;
        }

        .movie-card .info h4 {
            margin: 0;
            font-size: 16px;
            color: #fff;
        }

        .movie-card .info p {
            margin: 4px 0 0;
            font-size: 13px;
            color: #bbb;
        }

        footer {
            background-color: #141d2f;
            text-align: center;
            padding: 20px;
            font-size: 14px;
            color: #888;
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
    

    <div class="banner">
        <h1>Stream Your Favorites for Free</h1>
        <p>Watch the latest movies and TV shows online without registration. No ads. No limits.</p>
    </div>

    <div class="section">
        <h2>Trending Now</h2>
        <div class="movie-grid">
            <div class="movie-card">
                <img src="https://image.tmdb.org/t/p/w500/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg" alt="Movie">
                <div class="info">
                    <h4>Wonder Woman 1984</h4>
                    <p>Action | 2020</p>
                </div>
            </div>
            <div class="movie-card">
                <img src="https://image.tmdb.org/t/p/w500/rTh4K5uw9HypmpGslcKd4QfHl93.jpg" alt="Movie">
                <div class="info">
                    <h4>Dune</h4>
                    <p>Adventure | 2021</p>
                </div>
            </div>
            <div class="movie-card">
                <img src="https://image.tmdb.org/t/p/w500/xGuOF1T3WmPsAcQEQJfnG7Ud9f8.jpg" alt="Movie">
                <div class="info">
                    <h4>Tenet</h4>
                    <p>Sci-Fi | 2020</p>
                </div>
            </div>
            <div class="movie-card">
                <img src="https://image.tmdb.org/t/p/w500/6agKYU5IQFpuDyUYPu39w7UCRrJ.jpg" alt="Movie">
                <div class="info">
                    <h4>Joker</h4>
                    <p>Drama | 2019</p>
                </div>
            </div>
        </div>
    </div>
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
      <a href="dashboard.jsp">Home</a>
      <a href="ovie_list.jsp">Movies</a>
      <a href="about.jsp">About Us</a>
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
     <div>© 2025 FilmFanatic. All rights reserved.</div>
  </footer>
   
    
        

</body>
</html>
