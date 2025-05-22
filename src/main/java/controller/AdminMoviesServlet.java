package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import model.Movie;
import model.Genre;
import model.User;
import dao.MovieDAO;
import dao.GenreDAO;
import util.DbConnectionUtil;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.util.List;
import java.util.Calendar;

@WebServlet("/admin/movies/*")
@MultipartConfig(maxFileSize = 16177215) // max 16MB upload
public class AdminMoviesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection connection;
    private MovieDAO movieDAO;
    private GenreDAO genreDAO;

    @Override
    public void init() throws ServletException {
        connection = DbConnectionUtil.getConnection();
        if (connection == null) {
            throw new ServletException("Failed to establish DB connection.");
        }
        movieDAO = new MovieDAO(connection);
        genreDAO = new GenreDAO(connection);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || 
            !"Admin".equalsIgnoreCase(((User)session.getAttribute("user")).getRole())) {
            response.sendRedirect(request.getContextPath() + "/view/admin/login.jsp");
            return;
        }

        try {
            // Get all movies
            List<Movie> movies = movieDAO.getAllMovies();
            List<Genre> genres = genreDAO.getAllGenres();
            
            // Set movies in request attribute
            request.setAttribute("movieList", movies);
            request.setAttribute("genres", genres);
            
            // Forward to JSP
            request.getRequestDispatcher("/view/admin/movies.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving movies: " + e.getMessage());
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in and is an admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || 
            !"Admin".equalsIgnoreCase(((User)session.getAttribute("user")).getRole())) {
            response.sendRedirect(request.getContextPath() + "/view/admin/login.jsp");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        try {
            switch (pathInfo) {
                case "/add":
                    handleAddMovie(request, response);
                    break;
                case "/edit":
                    handleEditMovie(request, response);
                    break;
                case "/delete":
                    handleDeleteMovie(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Operation failed: " + e.getMessage());
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }

    private void handleAddMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Log all request parameters for debugging
            System.out.println("Add Movie Request Parameters:");
            request.getParameterMap().forEach((key, value) -> {
                System.out.println(key + ": " + String.join(", ", value));
            });

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String director = request.getParameter("director");
            String cast = request.getParameter("cast");
            int releaseYear = Integer.parseInt(request.getParameter("releaseYear"));
            int genreId = Integer.parseInt(request.getParameter("genreId"));
            float rating = Float.parseFloat(request.getParameter("rating"));

            // Create Date object from year
            Calendar cal = Calendar.getInstance();
            cal.set(releaseYear, Calendar.JANUARY, 1);
            Date releaseDate = new Date(cal.getTimeInMillis());

            Movie movie = new Movie();
            movie.setTitle(title);
            movie.setDescription(description);
            movie.setDirector(director);
            movie.setCast(cast);
            movie.setReleaseDate(releaseDate);
            movie.setGenreId(genreId);
            movie.setRating(rating);

            // Handle image upload
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                try (InputStream is = imagePart.getInputStream()) {
                    byte[] imageBytes = is.readAllBytes();
                    movie.setImageData(imageBytes);
                }
            }

            System.out.println("Attempting to add new movie: " + title);
            if (movieDAO.addMovie(movie)) {
                System.out.println("Movie added successfully");
                // Redirect to the main movies page
                response.sendRedirect(request.getContextPath() + "/admin/movies");
            } else {
                System.out.println("Failed to add movie");
                request.setAttribute("errorMessage", "Failed to add movie. Please check if the genre exists.");
                request.getRequestDispatcher("/view/admin/movies.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            System.out.println("Number format error: " + e.getMessage());
            request.setAttribute("errorMessage", "Invalid input format. Please check all fields.");
            request.getRequestDispatcher("/view/admin/movies.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error adding movie: " + e.getMessage());
            request.setAttribute("errorMessage", "An error occurred while adding the movie: " + e.getMessage());
            request.getRequestDispatcher("/view/admin/movies.jsp").forward(request, response);
        }
    }

    private void handleEditMovie(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Log all request parameters for debugging
            System.out.println("Edit Movie Request Parameters:");
            request.getParameterMap().forEach((key, value) -> {
                System.out.println(key + ": " + String.join(", ", value));
            });

            int movieId = Integer.parseInt(request.getParameter("movieId"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String director = request.getParameter("director");
            String cast = request.getParameter("cast");
            int releaseYear = Integer.parseInt(request.getParameter("releaseYear"));
            int genreId = Integer.parseInt(request.getParameter("genreId"));
            float rating = Float.parseFloat(request.getParameter("rating"));

            // Create Date object from year
            Calendar cal = Calendar.getInstance();
            cal.set(releaseYear, Calendar.JANUARY, 1);
            Date releaseDate = new Date(cal.getTimeInMillis());

            Movie movie = new Movie();
            movie.setMovieId(movieId);
            movie.setTitle(title);
            movie.setDescription(description);
            movie.setDirector(director);
            movie.setCast(cast);
            movie.setReleaseDate(releaseDate);
            movie.setGenreId(genreId);
            movie.setRating(rating);

            // Handle image upload
            Part imagePart = request.getPart("image");
            if (imagePart != null && imagePart.getSize() > 0) {
                try (InputStream is = imagePart.getInputStream()) {
                    byte[] imageBytes = is.readAllBytes();
                    movie.setImageData(imageBytes);
                }
            }

            System.out.println("Attempting to update movie with ID: " + movieId);
            if (movieDAO.updateMovie(movie)) {
                System.out.println("Movie updated successfully");
                // Redirect to the main movies page
                response.sendRedirect(request.getContextPath() + "/admin/movies");
            } else {
                System.out.println("Failed to update movie");
                request.setAttribute("errorMessage", "Failed to update movie. Please check if the genre exists.");
                request.getRequestDispatcher("/view/admin/movies.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            System.out.println("Number format error: " + e.getMessage());
            request.setAttribute("errorMessage", "Invalid input format. Please check all fields.");
            request.getRequestDispatcher("/view/admin/movies.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Error updating movie: " + e.getMessage());
            request.setAttribute("errorMessage", "An error occurred while updating the movie: " + e.getMessage());
            request.getRequestDispatcher("/view/admin/movies.jsp").forward(request, response);
        }
    }

    private void handleDeleteMovie(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("movieId"));

        if (movieDAO.deleteMovie(movieId)) {
            response.sendRedirect(request.getContextPath() + "/admin/movies");
        } else {
            request.setAttribute("errorMessage", "Failed to delete movie");
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }

    @Override
    public void destroy() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
} 