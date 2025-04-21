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
            margin: 0 100px;
            font-size: 24px;
        }

        .search-bar {
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            background-color: #1e2b3a;
            color: white;
            width: 400px;
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
            background-color: #E50815;
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
        <input type="text" class="search-bar" placeholder="Search Movies..." oninput="searchMovies()">
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

<div class="filter-bar">
    <button class="filter-btn active" id="All" onclick="filterMovies('All')">All</button>
    <button class="filter-btn" id="Action" onclick="filterMovies('Action')">Action</button>
    <button class="filter-btn" id="Drama" onclick="filterMovies('Drama')">Drama</button>
    <button class="filter-btn" id="SciFi" onclick="filterMovies('SciFi')">Sci-Fi</button>
    <button class="filter-btn" id="Comedy" onclick="filterMovies('Comedy')">Comedy</button>
    <button class="filter-btn" id="Thriller" onclick="filterMovies('Thriller')">Thriller</button>
</div>

<div class="movie-grid">
   <div class="movie-card Anime">
    <img src="https://image.tmdb.org/t/p/w500/q719jXXEzOoYaps6babgKnONONX.jpg" alt="Your Name">
    <div class="info">
        <h4>Your Name</h4>
        <p>Anime | 2016</p>
    </div>
</div>
<div class="movie-card Action">
    <img src="https://image.tmdb.org/t/p/w500/z8CExJekGrEThbpMXAmCFvvgoJR.jpg" alt="Army of the Dead">
    <div class="info">
        <h4>Army of the Dead</h4>
        <p>Action | 2021</p>
    </div>
</div>

<div class="movie-card Action">
    <img src="https://image.tmdb.org/t/p/w500/aSdp2uS0jWkqdhCeyhJuCoiLZji.jpg" alt="Top Gun: Maverick">
    <div class="info">
        <h4>Top Gun: Maverick</h4>
        <p>Action | 2022</p>
    </div>
</div>
<div class="movie-card">
            <img src="https://image.tmdb.org/t/p/w500/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg" alt="Godzilla x Kong: The New Empire">
            <div class="info">
                <h4>Godzilla x Kong</h4>
                <p>Action | 2024</p>
            </div>
        </div>     

<div class="movie-card Action">
    <img src="https://image.tmdb.org/t/p/w500/r7XifzvtezNt31ypvsmb6Oqxw49.jpg" alt="DC League of Super-Pets">
    <div class="info">
        <h4>DC League of Super-Pets</h4>
        <p>Action | 2022</p>
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
        <h4>The Shawshank Redemption</h4>
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
    <img src="https://image.tmdb.org/t/p/w500/6b7swg6DLqXCO3XUsMnv6RwDMW2.jpg" alt="After Ever Happy">
    <div class="info">
        <h4>After Ever Happy</h4>
        <p>Drama | 2022</p>
    </div>
</div>


<div class="movie-card Drama">
    <img src="https://image.tmdb.org/t/p/w500/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg" alt="Star Wars">
    <div class="info">
        <h4>Star Wars: Episode IV - A New Hope</h4>
        <p>Drama | 1977</p>
    </div>
</div>


<!-- Sci-Fi -->
<div class="movie-card SciFi">
    <img src="https://image.tmdb.org/t/p/w500/or06FN3Dka5tukK1e9sl16pB3iy.jpg" alt="Avengers: Endgame">
    <div class="info">
        <h4>Avengers: Endgame</h4>
        <p>Sci-Fi | 2019</p>
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
    <img src="https://image.tmdb.org/t/p/w500/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg" alt="John Wick 4">
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
<!-- Action -->
<div class="movie-card Action">
    <img src="https://image.tmdb.org/t/p/w500/vlgn4kNlVR9XbjX0Tq8XW5NkGg.jpg" alt="Spider-Man: No Way Home">
    <div class="info">
        <h4>Spider-Man: No Way Home</h4>
        <p>Action | 2021</p>
    </div>
</div>
<div class="movie-card Action">
    <img src="https://image.tmdb.org/t/p/w500/7Xzmx5Bb03gAzZDNzshPzRrRaWy.jpg" alt="Furious 7">
    <div class="info">
        <h4>Furious 7</h4>
        <p>Action | 2015</p>
    </div>
</div>

<!-- Drama -->
<div class="movie-card Drama">
    <img src="https://image.tmdb.org/t/p/w500/6Zgcfjqv6a7SYycvdCsbT2gUpUg.jpg" alt="The Pursuit of Happyness">
    <div class="info">
        <h4>The Pursuit of Happyness</h4>
        <p>Drama | 2006</p>
    </div>
</div>
<div class="movie-card Drama">
    <img src="https://image.tmdb.org/t/p/w500/rsEhdXyI4auLs1v5rBv9UV4wqie.jpg" alt="A Beautiful Mind">
    <div class="info">
        <h4>A Beautiful Mind</h4>
        <p>Drama | 2001</p>
    </div>
</div>

<!-- Sci-Fi -->
<div class="movie-card SciFi">
    <img src="https://image.tmdb.org/t/p/w500/l3bNd15j4nre6J4vZjcxV6va0Wj.jpg" alt="Blade Runner 2049">
    <div class="info">
        <h4>Blade Runner 2049</h4>
        <p>Sci-Fi | 2017</p>
    </div>
</div>

<!-- Comedy -->
<div class="movie-card Comedy">
    <img src="https://image.tmdb.org/t/p/w500/k6Su8kZ1nQGpOlxaIoY5pHoI2cm.jpg" alt="The Grand Budapest Hotel">
    <div class="info">
        <h4>The Grand Budapest Hotel</h4>
        <p>Comedy | 2014</p>
    </div>
</div>

<!-- Thriller -->
<div class="movie-card Thriller">
    <img src="https://image.tmdb.org/t/p/w500/4j7WmYeMxxlTbF9cUzjLLO7WGHl.jpg" alt="Shutter Island">
    <div class="info">
        <h4>Shutter Island</h4>
        <p>Thriller | 2010</p>
    </div>
</div>
</div>

<footer>
    <p>© 2025 FilmFanatic. All Rights Reserved.</p>
</footer>

</body>
</html>
