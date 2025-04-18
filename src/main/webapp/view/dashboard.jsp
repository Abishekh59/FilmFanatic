<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.Movie" %>
<%
    List<Movie> movies = (List<Movie>) request.getAttribute("movies");
    Movie featuredMovie = (movies != null && !movies.isEmpty()) ? movies.get(new Random().nextInt(movies.size())) : null;
    String[] genres = { "All", "Action", "Drama", "Sci-Fi", "Comedy", "Thriller" };
%>
<!DOCTYPE html>
<html>
<head>
    <title>FlimFantic - Home</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #0a1929;
            color: #f1f1f1;
        }
        .container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 2rem;
            text-align: center;
        }
        .hero {
            background-color: #1e293b;
            padding: 60px 20px;
            border-radius: 10px;
        }
        .hero h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        .hero p {
            font-size: 1.2rem;
            color: #ccc;
        }
        .genres {
            margin: 2rem 0;
        }
        .genres button {
            background-color: #1e293b;
            border: none;
            color: #f1f1f1;
            padding: 10px 20px;
            margin: 5px;
            cursor: pointer;
            border-radius: 5px;
        }
        .genres button:hover {
            background-color: #334155;
        }
        .movie-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }
        .movie-card {
            background-color: #111827;
            width: 200px;
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .movie-card:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
        }
        .movie-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }
        .movie-info {
            padding: 10px;
            text-align: left;
        }
        .movie-title {
            font-size: 1rem;
            font-weight: bold;
            margin-bottom: 5px;
        }
        .movie-meta {
            font-size: 0.85rem;
            color: #aaa;
        }
    </style>
</head>
<body>
    <div class="container">

        <!-- Hero Section -->
        <div class="hero">
            <h1><%= featuredMovie != null ? featuredMovie.getTitle() : "Featured Movie" %></h1>
            <p><%= featuredMovie != null ? featuredMovie.getDescription() : "Enjoy your favorite movies with FlimFantic." %></p>
        </div>

        <!-- Genre Filter -->
        <div class="genres">
            <% for(String genre : genres) { %>
                <button><%= genre %></button>
            <% } %>
        </div>

        <!-- Movies Grid -->
        <div class="movie-grid">
            <% if (movies != null && !movies.isEmpty()) {
                int count = 0;
                for (Movie movie : movies) {
                    if (++count > 12) break; %>
                    <div class="movie-card">
                        <!-- Using placeholder image as you don’t have poster URL in your model -->
                        <img src="https://via.placeholder.com/200x300?text=<%= movie.getTitle().replaceAll(" ", "+") %>" alt="<%= movie.getTitle() %> Poster">
                        <div class="movie-info">
                            <div class="movie-title"><%= movie.getTitle() %></div>
                            <div class="movie-meta">
                                <span>⭐ <%= movie.getRating() %></span><br/>
                                <span><%= movie.getReleaseDate() != null ? movie.getReleaseDate().toString() : "Unknown Year" %></span>
                            </div>
                        </div>
                    </div>
            <%  } } else { %>
                <p>No movies available.</p>
            <% } %>
        </div>

    </div>
</body>
</html>
