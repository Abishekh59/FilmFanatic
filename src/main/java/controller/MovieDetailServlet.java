package controller;

import dao.MovieDAO;
import dao.ReviewDAO;
import model.Movie;
import model.Review;
import util.DbConnectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/movie/*")
public class MovieDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private MovieDAO movieDAO;
    private ReviewDAO reviewDAO;
    private Connection conn;

    @Override
    public void init() throws ServletException {
        System.out.println("MovieDetailServlet: Initializing...");
        try {
            // Try to get connection from context first
            conn = (Connection) getServletContext().getAttribute("DBConnection");
            
            // If not in context, create a new connection
            if (conn == null) {
                System.out.println("MovieDetailServlet: No connection in context, creating new connection...");
                conn = DbConnectionUtil.getConnection();
                if (conn != null) {
                    getServletContext().setAttribute("DBConnection", conn);
                    System.out.println("MovieDetailServlet: New database connection created and stored in context");
                }
            }
            
            if (conn == null) {
                System.err.println("MovieDetailServlet: Database connection is null!");
                throw new ServletException("Database connection is null");
            }
            
            System.out.println("MovieDetailServlet: Database connection obtained successfully");
            movieDAO = new MovieDAO(conn);
            reviewDAO = new ReviewDAO(conn);
            System.out.println("MovieDetailServlet: DAOs initialized successfully");
        } catch (Exception e) {
            System.err.println("MovieDetailServlet: Error in init: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error initializing MovieDetailServlet: " + e.getMessage(), e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        System.out.println("MovieDetailServlet: Session check -");
        System.out.println("  Session exists: " + (session != null));
        if (session != null) {
            System.out.println("  Session ID: " + session.getId());
            System.out.println("  userId: " + session.getAttribute("userId"));
            System.out.println("  username: " + session.getAttribute("username"));
            System.out.println("  user object: " + session.getAttribute("user"));
        }

        System.out.println("MovieDetailServlet: doGet called");
        try {
            // Get movie ID from the URL path
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Movie ID is required");
                return;
            }

            // Extract movie ID from the path
            String movieIdStr = pathInfo.substring(1); // Remove leading slash
            int movieId;
            try {
                movieId = Integer.parseInt(movieIdStr);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid movie ID format");
                return;
            }

            System.out.println("MovieDetailServlet: Fetching movie with ID: " + movieId);
            Movie movie = movieDAO.getMovieById(movieId);
            
            if (movie == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Movie not found");
                return;
            }

            System.out.println("MovieDetailServlet: Found movie: " + movie.getTitle());
            request.setAttribute("movie", movie);
            
            // Fetch reviews for the movie
            System.out.println("MovieDetailServlet: Fetching reviews for movie ID: " + movieId);
            request.setAttribute("reviews", reviewDAO.getReviewsByMovieId(movieId));
            
            System.out.println("MovieDetailServlet: Forwarding to movie_detail.jsp");
            request.getRequestDispatcher("/view/movie_detail.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("MovieDetailServlet: Error in doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "An error occurred while processing the request: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        System.out.println("MovieDetailServlet: doPost called");
        try {
            HttpSession session = request.getSession();
            Integer userId = (Integer) session.getAttribute("userId");
            
            if (userId == null) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "You must be logged in to submit a review");
                return;
            }

            String action = request.getParameter("action");
            if (action == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter is required");
                return;
            }

            switch (action) {
                case "add":
                    handleAddReview(request, response, userId);
                    break;
                case "update":
                    handleUpdateReview(request, response, userId);
                    break;
                case "delete":
                    handleDeleteReview(request, response, userId);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
            }
        } catch (Exception e) {
            System.err.println("MovieDetailServlet: Error in doPost: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "An error occurred while processing the request: " + e.getMessage());
        }
    }

    private void handleAddReview(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException {
        try {
            int movieId = Integer.parseInt(request.getParameter("movieId"));
            float rating = Float.parseFloat(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            Review review = new Review(movieId, userId, rating, comment);
            reviewDAO.addReview(review);

            response.sendRedirect(request.getContextPath() + "/movie/" + movieId);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid movie ID or rating format");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error adding review: " + e.getMessage());
        }
    }

    private void handleUpdateReview(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException {
        try {
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            float rating = Float.parseFloat(request.getParameter("rating"));
            String comment = request.getParameter("comment");

            Review review = reviewDAO.getReviewById(reviewId);
            if (review == null || review.getUserId() != userId) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You can only edit your own reviews");
                return;
            }

            review.setRating(rating);
            review.setComment(comment);
            reviewDAO.updateReview(review);

            response.sendRedirect(request.getContextPath() + "/movie/" + review.getMovieId());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid review ID or rating format");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error updating review: " + e.getMessage());
        }
    }

    private void handleDeleteReview(HttpServletRequest request, HttpServletResponse response, int userId) 
            throws ServletException, IOException {
        try {
            int reviewId = Integer.parseInt(request.getParameter("reviewId"));
            Review review = reviewDAO.getReviewById(reviewId);
            
            if (review == null || review.getUserId() != userId) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "You can only delete your own reviews");
                return;
            }

            reviewDAO.deleteReview(reviewId, userId);
            response.sendRedirect(request.getContextPath() + "/movie/" + review.getMovieId());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid review ID format");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error deleting review: " + e.getMessage());
        }
    }

    @Override
    public void destroy() {
        System.out.println("MovieDetailServlet: Destroying...");
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("MovieDetailServlet: Database connection closed");
            }
        } catch (Exception e) {
            System.err.println("MovieDetailServlet: Error closing database connection");
            e.printStackTrace();
        }
    }
} 