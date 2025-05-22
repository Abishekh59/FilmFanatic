<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Redirect to servlet if no movies are found
    if (request.getAttribute("movies") == null) {
        response.sendRedirect(request.getContextPath() + "/view/movielist");
        return;
    }
%>
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
        .movie-card .info h4 a{
            margin: 0;
            font-size: 16px;
            color: White;
            text-decoration: none;
            
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
    </style>
   <script>
        // Function to filter movies based on category
        function filterMovies(category) {
            const buttons = document.querySelectorAll('.filter-btn');
            buttons.forEach(btn => btn.classList.remove('active'));
            document.getElementById(category).classList.add('active');

            const cards = document.querySelectorAll('.movie-card');
            cards.forEach(card => {
                if (category === 'All' || card.getAttribute('data-genre') === category) {
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
        <a href="${pageContext.request.contextPath}/view/movielist">Movies</a>
        <a href="about.jsp">About</a>
        <a href="contact.jsp">Contact</a> 
        <input type="text" class="search-bar" placeholder="Search Movies..." oninput="searchMovies()">
    </nav>
    <div class="actions">
            <a href="${pageContext.request.contextPath}/profile" class="profile">Profile</a>
            <a href="${pageContext.request.contextPath}/view/logout.jsp" class="logout">
                <img src="https://img.icons8.com/material-rounded/24/ffffff/exit.png" alt="Logout Icon"
                    style="vertical-align: middle; margin-right: 5px;" />
                Logout
            </a>
    </div>
</header>

<div class="filter-bar">
    <button class="filter-btn active" id="All" onclick="filterMovies('All')">All</button>
    <c:forEach items="${genres}" var="genre">
        <button class="filter-btn" id="${genre.name}" onclick="filterMovies('${genre.name}')">${genre.name}</button>
    </c:forEach>
</div>

<div class="movie-grid">
    <c:forEach items="${movies}" var="movie">
        <div class="movie-card" data-genre="${movie.genreName}">
            <c:choose>
                <c:when test="${not empty movie.imageBase64}">
                    <img src="data:image/jpeg;base64,${movie.imageBase64}" alt="${movie.title}">
                </c:when>
                <c:otherwise>
                    <img src="${pageContext.request.contextPath}/images/default-movie.png" alt="Default Movie Image">
                </c:otherwise>
            </c:choose>
            <div class="info">
                <h4><a href="${pageContext.request.contextPath}/movie/${movie.movieId}">${movie.title}</a></h4>
                <p>${movie.genreName} | ${movie.releaseDate}</p>
            </div>
        </div>
    </c:forEach>
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
    � 2025 FilmFanatic. All Rights Reserved.
  </div>
</body>
</html>
