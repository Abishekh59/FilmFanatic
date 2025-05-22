package controller;

import dao.MovieDAO;
import dao.GenreDAO;
import model.Movie;
import model.Genre;
import model.User;
import util.DbConnectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/view/movielist")
public class MovieListServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MovieDAO movieDAO;
    private GenreDAO genreDAO;
    private Connection conn;

    @Override
    public void init() throws ServletException {
        System.out.println("MovieListServlet: Initializing...");
        try {
            // Try to get connection from context first
            conn = (Connection) getServletContext().getAttribute("DBConnection");
            
            // If not in context, create a new connection
            if (conn == null) {
                System.out.println("MovieListServlet: No connection in context, creating new connection...");
                conn = DbConnectionUtil.getConnection();
                if (conn != null) {
                    getServletContext().setAttribute("DBConnection", conn);
                    System.out.println("MovieListServlet: New database connection created and stored in context");
                }
            }
            
            if (conn == null) {
                System.err.println("MovieListServlet: Database connection is null!");
                throw new ServletException("Database connection is null");
            }
            
            System.out.println("MovieListServlet: Database connection obtained successfully");
            movieDAO = new MovieDAO(conn);
            genreDAO = new GenreDAO(conn);
            System.out.println("MovieListServlet: DAOs initialized successfully");
        } catch (Exception e) {
            System.err.println("MovieListServlet: Error in init: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error initializing MovieListServlet: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("MovieListServlet: doGet called");
        try {
            System.out.println("MovieListServlet: Fetching movies...");
            List<Movie> movies = movieDAO.getAllMovies();
            System.out.println("MovieListServlet: Found " + (movies != null ? movies.size() : 0) + " movies");
            
            if (movies != null && !movies.isEmpty()) {
                for (Movie movie : movies) {
                    System.out.println("Movie: " + movie.getTitle() + 
                                     ", Genre: " + movie.getGenreName() + 
                                     ", ID: " + movie.getMovieId());
                }
            } else {
                System.out.println("MovieListServlet: No movies found in database");
            }
            
            System.out.println("MovieListServlet: Fetching genres...");
            List<Genre> genres = genreDAO.getAllGenres();
            System.out.println("MovieListServlet: Found " + (genres != null ? genres.size() : 0) + " genres");
            
            request.setAttribute("movies", movies);
            request.setAttribute("genres", genres);
            
            // Check if user is admin and forward to appropriate JSP
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            if (user != null && "Admin".equalsIgnoreCase(user.getRole())) {
                System.out.println("MovieListServlet: Forwarding to Movies.jsp for admin");
                request.getRequestDispatcher("Movies.jsp").forward(request, response);
            } else {
                System.out.println("MovieListServlet: Forwarding to movie_list.jsp for regular user");
                request.getRequestDispatcher("movie_list.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("MovieListServlet: Error in doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "An error occurred while processing the request: " + e.getMessage());
        }
    }

    @Override
    public void destroy() {
        System.out.println("MovieListServlet: Destroying...");
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("MovieListServlet: Database connection closed");
            }
        } catch (Exception e) {
            System.err.println("MovieListServlet: Error closing database connection");
            e.printStackTrace();
        }
    }
} 