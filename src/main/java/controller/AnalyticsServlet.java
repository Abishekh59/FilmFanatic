package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import dao.UserDAO;
import dao.MovieDAO;
import dao.ReviewDAO;
import util.DbConnectionUtil;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/admin/analytics")
public class AnalyticsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection connection;
    private UserDAO userDAO;
    private MovieDAO movieDAO;
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        connection = DbConnectionUtil.getConnection();
        if (connection != null) {
            userDAO = new UserDAO(connection);
            movieDAO = new MovieDAO(connection);
            reviewDAO = new ReviewDAO(connection);
        } else {
            throw new ServletException("Database connection failed");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        // Check if user is logged in and is an admin
        if (session == null || session.getAttribute("user") == null || 
            !"Admin".equalsIgnoreCase(((User)session.getAttribute("user")).getRole())) {
            response.sendRedirect(request.getContextPath() + "/view/admin/login.jsp");
            return;
        }

        try {
            int totalUsers = userDAO.getTotalUsers();
            int totalMovies = movieDAO.getTotalMovies();
            int totalReviews = reviewDAO.getTotalReviews();

            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalMovies", totalMovies);
            request.setAttribute("totalReviews", totalReviews);

            request.getRequestDispatcher("/view/admin/analytics.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving analytics");
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