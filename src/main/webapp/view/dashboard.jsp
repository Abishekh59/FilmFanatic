<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

        .banner {
            background-image: url('https://images.unsplash.com/photo-1524985069026-dd778a71c7b4');
            background-size: cover;
            background-position: center;
            padding: 100px 40px;
            text-align: center;
        }

        .banner h1 {
            font-size: 48px;
            margin-bottom: 20px;
            color: white;
        }

        .banner p {
            font-size: 20px;
            max-width: 700px;
            margin: 0 auto;
            color: #ddd;
        }

        .cta-button {
            display: inline-block;
            background-color: #E50815;
            padding: 12px 30px;
            color: white;
            font-size: 18px;
            font-weight: bold;
            text-decoration: none;
            border-radius: 6px;
            transition: background-color 0.3s ease;
        }

        .cta-button:hover {
            background-color: #C40613;
        }

        /* Section Styling */
        .section {
            padding: 40px;
        }

        .section h2 {
            margin-bottom: 20px;
            font-size: 26px;
            color: #f5f5f5;
        }

        /* Movie Grid Styling */
        .movie-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            gap: 20px;
        }

        .movie-card {
            background-color: #1a2433;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 0 #A6A6A6;
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
        
         <script>
        // Function to filter movies based on category
        function filterMovies(category) {
            const buttons = document.querySelectorAll('.filter-btn');
            buttons.forEach(btn => btn.classList.remove('active'));
            document.getElementById(category).classList.add('active');

            const cards = document.querySelectorAll('.movie-card');
            cards.forEach(card => {
                if (category === 'All' || card.classList.contains(category)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }

        // Function to search movies by title
        function searchMovies() {
            const searchText = document.querySelector('.search-bar').value.toLowerCase();
            const cards = document.querySelectorAll('.movie-card');
            
            cards.forEach(card => {
                const title = card.querySelector('h4').textContent.toLowerCase();
                if (title.includes(searchText)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        }
    </script>

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
        <a href="contact.jsp">Contact</a> 
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


    <div class="banner">
        <h1>Discover, Rate, and Review Movies</h1>
        <p>Join a vibrant community of movie lovers! Rate the films you've seen, leave thoughtful reviews, and explore recommendations based on community ratings. Find the best movies based on real feedback!</p>
        <a href="movie_list.jsp" class="cta-button">Explore Movies</a>
    </div>

    <div class="section">
        <h2>Trending Now</h2>
        <div class="movie-grid">
        <div class="movie-card">
            <img src="https://image.tmdb.org/t/p/w500/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg" alt="Godzilla x Kong: The New Empire">
            <div class="info">
                <h4>Godzilla x Kong</h4>
                <p>Action | 2024</p>
            </div>
        </div>
        <div class="movie-card">
            <img src="https://image.tmdb.org/t/p/w500/czembW0Rk1Ke7lCJGahbOhdCuhV.jpg" alt="Kung Fu Panda 4">
            <div class="info">
                <h4>Dune</h4>
                <p>Sci-Fi | 2024</p>
            </div>
        </div>
        <div class="movie-card Action">
    <img src="https://image.tmdb.org/t/p/w500/z8CExJekGrEThbpMXAmCFvvgoJR.jpg" alt="Army of the Dead">
    <div class="info">
        <h4>Army of the Dead</h4>
        <p>Action | 2021</p>
    </div>
</div>
        <div class="movie-card">
            <img src="https://image.tmdb.org/t/p/w500/iADOJ8Zymht2JPMoy3R7xceZprc.jpg" alt="Furious:A mad max sage">
            <div class="info">
                <h4>Furious:A mad max sage</h4>
                <p>Thriller | 2024</p>
            </div>
        </div>
        <div class="movie-card">
            <img src="https://image.tmdb.org/t/p/w500/9PqD3wSIjntyJDBzMNuxuKHwpUD.jpg" alt="Migration">
            <div class="info">
                <h4>Migration</h4>
                <p>Animation | 2023</p>
            </div>
        </div>
        <div class="movie-card">
            <img src="https://image.tmdb.org/t/p/w500/bXi6IQiQDHD00JFio5ZSZOeRSBh.jpg" alt="Road House">
            <div class="info">
                <h4>Road House</h4>
                <p>Thriller | 2024</p>
            </div>
        </div>
        <div class="movie-card Drama">
    <img src="https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg" alt="The Shawshank Redemption">
    <div class="info">
        <h4>The Shawshank Redemption</h4>
        <p>Drama | 1994</p>
    </div>
</div>
        <div class="movie-card SciFi">
    <img src="https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg" alt="Avengers: Endgame">
    <div class="info">
        <h4>Avengers: Endgame</h4>
        <p>Sci-Fi | 2019</p>
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
    © 2025 FilmFanatic. All Rights Reserved.
  </div>


    <script>
        const searchInput = document.getElementById("movie-search");
        searchInput.addEventListener("input", function () {
            const query = searchInput.value.toLowerCase();
            const movieCards = document.querySelectorAll(".movie-card");
            movieCards.forEach(function (card) {
                const title = card.querySelector("h4").textContent.toLowerCase();
                if (title.includes(query)) {
                    card.style.display = "block";
                } else {
                    card.style.display = "none";
                }
            });
        });
    </script>
</body>

</html>
