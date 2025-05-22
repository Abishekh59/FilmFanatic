package controller;

import util.SecurityUtil;
import dao.UserDAO;
import model.User;
import util.DbConnectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        System.out.println("Initializing RegisterServlet...");
        Connection connection = DbConnectionUtil.getConnection();

        if (connection == null) {
            System.err.println("Could not establish DB connection in servlet.");
            throw new ServletException("Failed to establish DB connection via DbConnectionUtil");
        }

        System.out.println("DB connection initialized in servlet.");
        userDAO = new UserDAO(connection);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            System.out.println("Received user registration request");

            // Don't parse userId as it's auto-generated
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String plainPassword = request.getParameter("password");
            String role = "User"; // Default role is User

            System.out.println("User Input - Username: " + username + ", Email: " + email + ", Role: " + role);

            // Hash the password before storing
            String hashedPassword = SecurityUtil.hashPassword(plainPassword);
            System.out.println("Hashed Password: " + hashedPassword);

            // Create user with role set to "User"
            User user = new User(0, username, email, role, hashedPassword, new Timestamp(System.currentTimeMillis()));

            boolean registered = userDAO.registerUser(user);

            if (registered) {
                System.out.println("✅ User registered successfully.");
                response.sendRedirect("view/dashboard.jsp");
            } else {
                System.err.println("Registration failed. DAO returned false.");
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            System.err.println("Exception during registration:");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
