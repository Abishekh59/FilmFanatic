package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import dao.UserDAO;
import model.User;
import util.DbConnectionUtil;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        Connection connection = DbConnectionUtil.getConnection();
        if (connection == null) {
            throw new ServletException("Failed to establish DB connection.");
        }
        userDAO = new UserDAO(connection);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String username = request.getParameter("username"); // Use "username" or "email" based on your form
        String password = request.getParameter("password");

        try {
            User user = userDAO.authenticateUser(username, password);

            if (user != null) {
                // Store user info in session
                HttpSession session = request.getSession();
                System.out.println("LoginServlet: Creating new session: " + session.getId());
                
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("username", user.getUsername());
                session.setAttribute("user", user);

                System.out.println("LoginServlet: Session attributes set -");
                System.out.println("  userId: " + session.getAttribute("userId"));
                System.out.println("  username: " + session.getAttribute("username"));
                System.out.println("  user object: " + session.getAttribute("user"));

                // Set session timeout to 30 minutes
                session.setMaxInactiveInterval(30 * 60);
                
                // Redirect based on user role
                if ("Admin".equalsIgnoreCase(user.getRole())) {
                    System.out.println("LoginServlet: Redirecting admin user to admin panel");
                    response.sendRedirect(request.getContextPath() + "/admin/panel");
                } else {
                    System.out.println("LoginServlet: Redirecting regular user to dashboard");
                    response.sendRedirect(request.getContextPath() + "/view/dashboard.jsp");
                }
            } else {
                // Login failed: back to login page with error
                request.setAttribute("errorMessage", "Invalid username or password");
                request.getRequestDispatcher("view/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("view/error.jsp").forward(request, response);
        }
    }
}
