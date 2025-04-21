package controller;

import dao.UserDAO;
import model.User;
import Utils.DbConnectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/LoginServlet") // Changed to lowercase for convention and cleaner URL mapping
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        System.out.println("🔁 Initializing LoginServlet...");
        Connection connection = DbConnectionUtil.getConnection();

        if (connection == null) {
            System.err.println("❌ Could not establish DB connection in servlet.");
            throw new ServletException("Failed to establish DB connection via DbConnectionUtil");
        }

        System.out.println("✅ DB connection initialized in servlet.");
        userDAO = new UserDAO(connection);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        try {
            System.out.println("📥 Received user login request");

            // Collect form parameters
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            // Logging inputs (don't log password in production)
            System.out.println("🧾 User Input - Username: " + username);

            // Attempt authentication
            User user = userDAO.authenticateUser(username, password);

            if (user != null) {
                System.out.println("✅ Login successful for user: " + user.getUsername());

                // Save user in session
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                // Redirect to dashboard or homepage
                response.sendRedirect("dashboard.jsp");
            } else {
                System.err.println("❌ Login failed: Invalid credentials");
                request.setAttribute("errorMessage", "Invalid username or password.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            System.err.println("❌ Exception during login:");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
