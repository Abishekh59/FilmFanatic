package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import dao.UserDAO;
import dao.MovieDAO;
import dao.ReviewDAO;
import model.User;
import util.DbConnectionUtil;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Connection connection;
    private UserDAO userDAO;
    private MovieDAO movieDAO;
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        try {
            System.out.println("AdminDashboardServlet: Initializing...");
            connection = DbConnectionUtil.getConnection();
            System.out.println("AdminDashboardServlet: Database connection obtained successfully");
            
            userDAO = new UserDAO(connection);
            movieDAO = new MovieDAO(connection);
            reviewDAO = new ReviewDAO(connection);
            System.out.println("AdminDashboardServlet: DAOs initialized successfully");
        } catch (Exception e) {
            System.err.println("AdminDashboardServlet: Error in init: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Error initializing AdminDashboardServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Check if user is logged in and is an admin
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect(request.getContextPath() + "/view/login.jsp");
                return;
            }

            User user = (User) session.getAttribute("user");
            if (!"Admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/view/login.jsp");
                return;
            }

            // Get analytics data
            int totalUsers = userDAO.getTotalUsers();
            int totalMovies = movieDAO.getTotalMovies();
            int totalReviews = reviewDAO.getTotalReviews();

            // Set attributes
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalMovies", totalMovies);
            request.setAttribute("totalReviews", totalReviews);

            // Forward to admin panel
            request.getRequestDispatcher("/view/admin_panel.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("AdminDashboardServlet: Error in doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "An error occurred while processing the request: " + e.getMessage());
        }
    }

    @Override
    public void destroy() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("AdminDashboardServlet: Database connection closed");
            }
        } catch (Exception e) {
            System.err.println("AdminDashboardServlet: Error closing connection: " + e.getMessage());
        }
    }
} 