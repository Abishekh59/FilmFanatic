package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.ReviewDAO;
import dao.UserDAO;
import dao.MovieDAO;
import model.Review;
import model.User;
import model.Movie;
import util.DbConnectionUtil;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/reviews/*")
public class ReviewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection connection;
    private ReviewDAO reviewDAO;
    private UserDAO userDAO;
    private MovieDAO movieDAO;

    @Override
    public void init() throws ServletException {
        connection = DbConnectionUtil.getConnection();
        if (connection == null) {
            throw new ServletException("Failed to establish DB connection.");
        }
        reviewDAO = new ReviewDAO(connection);
        userDAO = new UserDAO(connection);
        movieDAO = new MovieDAO(connection);
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
            // Get all reviews, users, and movies
            List<Review> reviews = reviewDAO.getAllReviews();
            List<User> users = userDAO.getAllUsers();
            List<Movie> movies = movieDAO.getAllMovies();
            
            // Set data in request attributes
            request.setAttribute("reviewList", reviews);
            request.setAttribute("userList", users);
            request.setAttribute("movieList", movies);
            
            // Forward to JSP
            request.getRequestDispatcher("/view/admin/reviews.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving reviews: " + e.getMessage());
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
                    handleAddReview(request, response);
                    break;
                case "/edit":
                    handleEditReview(request, response);
                    break;
                case "/delete":
                    handleDeleteReview(request, response);
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

    private void handleAddReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Review review = new Review();
        review.setUserId(userId);
        review.setMovieId(movieId);
        review.setRating(rating);
        review.setComment(comment);

        try {
            if (reviewDAO.addReview(review)) {
                response.sendRedirect(request.getContextPath() + "/admin/reviews");
            } else {
                request.setAttribute("errorMessage", "Failed to add review");
                request.getRequestDispatcher("/view/error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error adding review: " + e.getMessage());
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }

    private void handleEditReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        int movieId = Integer.parseInt(request.getParameter("movieId"));
        float rating = Float.parseFloat(request.getParameter("rating"));
        String comment = request.getParameter("comment");

        Review review = new Review();
        review.setReviewId(reviewId);
        review.setUserId(userId);
        review.setMovieId(movieId);
        review.setRating(rating);
        review.setComment(comment);

        try {
            if (reviewDAO.updateReview(review)) {
                response.sendRedirect(request.getContextPath() + "/admin/reviews");
            } else {
                request.setAttribute("errorMessage", "Failed to update review");
                request.getRequestDispatcher("/view/error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error updating review: " + e.getMessage());
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }

    private void handleDeleteReview(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        int userId = Integer.parseInt(request.getParameter("userId"));

        try {
            if (reviewDAO.deleteReview(reviewId, userId)) {
                response.sendRedirect(request.getContextPath() + "/admin/reviews");
            } else {
                request.setAttribute("errorMessage", "Failed to delete review");
                request.getRequestDispatcher("/view/error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error deleting review: " + e.getMessage());
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