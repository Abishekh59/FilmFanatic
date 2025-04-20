<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movies - FilmFanatic</title>
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
            margin: 0 15px;
        }

        .search-bar {
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            background-color: #1e2b3a;
            color: white;
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

        .filter-bar {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            padding: 20px 10px;
            background-color: #1a2433;
        }

        .filter-btn {
            background-color: transparent;
            border: 2px solid #fff;
            color: white;
            padding: 10px 16px;
            margin: 8px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s, color 0.3s;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background-color: #e74c3c;
            color: white;
            border-color: #e74c3c;
        }

        .movie-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
            gap: 20px;
            padding: 40px;
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
    </style>
    <script>
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
    </script>
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
            <a href="profile.jsp" class="profile">Proifle</a>
             <a href="" class="logout">Logout</a>
        </div>
</header>

<div class="filter-bar">
    <button class="filter-btn active" id="All" onclick="filterMovies('All')">All</button>
    <button class="filter-btn" id="Action" onclick="filterMovies('Action')">Action</button>
    <button class="filter-btn" id="Drama" onclick="filterMovies('Drama')">Drama</button>
    <button class="filter-btn" id="SciFi" onclick="filterMovies('SciFi')">Sci-Fi</button>
    <button class="filter-btn" id="Comedy" onclick="filterMovies('Comedy')">Comedy</button>
    <button class="filter-btn" id="Thriller" onclick="filterMovies('Thriller')">Thriller</button>
</div>

<div class="movie-grid">
    <!-- Action -->
    <div class="movie-card Action">
        <img src="https://image.tmdb.org/t/p/w500/q719jXXEzOoYaps6babgKnONONX.jpg" alt="Mad Max">
        <div class="info">
            <h4>Mad Max: Fury Road</h4>
            <p>Action | 2015</p>
        </div>
    </div>
    <div class="movie-card Action">
        <img src="https://image.tmdb.org/t/p/w500/z8CExJekGrEThbpMXAmCFvvgoJR.jpg" alt="Avengers">
        <div class="info">
            <h4>Avengers: Endgame</h4>
            <p>Action | 2019</p>
        </div>
    </div>
    <div class="movie-card Action">
        <img src="https://image.tmdb.org/t/p/w500/aSdp2uS0jWkqdhCeyhJuCoiLZji.jpg" alt="Top Gun: Maverick">
        <div class="info">
            <h4>Top Gun: Maverick</h4>
            <p>Action | 2022</p>
        </div>
    </div>
    <div class="movie-card Action">
        <img src="https://image.tmdb.org/t/p/w500/wMnUMwVXZxD8HLwqF8cfCk8hNJv.jpg" alt="The Batman">
        <div class="info">
            <h4>The Batman</h4>
            <p>Action | 2022</p>
        </div>
    </div>
    <div class="movie-card Action">
        <img src="https://image.tmdb.org/t/p/w500/r7XifzvtezNt31ypvsmb6Oqxw49.jpg" alt="Mission Impossible 7">
        <div class="info">
            <h4>Mission: Impossible - Dead Reckoning</h4>
            <p>Action | 2023</p>
        </div>
    </div>

    <!-- Drama -->
    <div class="movie-card Drama">
        <img src="https://image.tmdb.org/t/p/w500/udDclJoHjfjb8Ekgsd4FDteOkCU.jpg" alt="Joker">
        <div class="info">
            <h4>Joker</h4>
            <p>Drama | 2019</p>
        </div>
    </div>
    <div class="movie-card Drama">
        <img src="https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg" alt="The Shawshank Redemption">
        <div class="info">
            <h4>Shawshank Redemption</h4>
            <p>Drama | 1994</p>
        </div>
    </div>
    <div class="movie-card Drama">
        <img src="https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg" alt="The Godfather">
        <div class="info">
            <h4>The Godfather</h4>
            <p>Drama | 1972</p>
        </div>
    </div>
    <div class="movie-card Drama">
        <img src="https://image.tmdb.org/t/p/w500/e5vEYm9pVlzC8mZExz0nggd0Rui.jpg" alt="The Whale">
        <div class="info">
            <h4>The Whale</h4>
            <p>Drama | 2022</p>
        </div>
    </div>
    <div class="movie-card Drama">
        <img src="https://image.tmdb.org/t/p/w500/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg" alt="Forrest Gump">
        <div class="info">
            <h4>Forrest Gump</h4>
            <p>Drama | 1994</p>
        </div>
    </div>

    <!-- Sci-Fi -->
    <div class="movie-card SciFi">
        <img src="https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg" alt="Inception">
        <div class="info">
            <h4>Inception</h4>
            <p>Sci-Fi | 2010</p>
        </div>
    </div>
    <div class="movie-card SciFi">
        <img src="https://image.tmdb.org/t/p/w500/nBNZadXqJSdt05SHLqgT0HuC5Gm.jpg" alt="Interstellar">
        <div class="info">
            <h4>Interstellar</h4>
            <p>Sci-Fi | 2014</p>
        </div>
    </div>
    <div class="movie-card SciFi">
        <img src="https://image.tmdb.org/t/p/w500/x2FJsf1ElAgr63Y3PNPtJrcmpoe.jpg" alt="The Matrix">
        <div class="info">
            <h4>The Matrix</h4>
            <p>Sci-Fi | 1999</p>
        </div>
    </div>

    <!-- Comedy -->
    <div class="movie-card Comedy">
        <img src="https://image.tmdb.org/t/p/w500/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg" alt="Deadpool">
        <div class="info">
            <h4>Deadpool</h4>
            <p>Comedy | 2016</p>
        </div>
    </div>
    <div class="movie-card Comedy">
        <img src="https://image.tmdb.org/t/p/w500/4o2BKoKTt0tDs2H6fJwA2jzSjaS.jpg" alt="The Hangover">
        <div class="info">
            <h4>The Hangover</h4>
            <p>Comedy | 2009</p>
        </div>
    </div>

    <!-- Thriller -->
    <div class="movie-card Thriller">
        <img src="https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg" alt="John Wick">
        <div class="info">
            <h4>John Wick 4</h4>
            <p>Thriller | 2023</p>
        </div>
    </div>
    <div class="movie-card Thriller">
        <img src="https://image.tmdb.org/t/p/w500/mfnkSeeVOBVheuyn2lo4tfmOPQb.jpg" alt="Gone Girl">
        <div class="info">
            <h4>Gone Girl</h4>
            <p>Thriller | 2014</p>
        </div>
    </div>
</div>

<footer>
    © 2025 FilmFanatic. All rights reserved.
</footer>

</body>
</html>
