package controller;

import dao.UserDAO;
import model.User;
import Utils.DbConnectionUtil;

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
        System.out.println("🔁 Initializing RegisterServlet...");
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
            System.out.println("📥 Received user registration request");

            int userId = Integer.parseInt(request.getParameter("userId"));
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            System.out.println("🧾 User Input - ID: " + userId + ", Username: " + username + ", Email: " + email + ", Role: " + role);

            User user = new User(userId, username, email, password, role, new Timestamp(System.currentTimeMillis()));

            boolean registered = userDAO.registerUser(user);

            if (registered) {
                System.out.println("✅ User registered successfully.");
                response.sendRedirect("success.jsp");
            } else {
                System.err.println("❌ Registration failed. DAO returned false.");
                response.sendRedirect("error.jsp");
            }
        } catch (Exception e) {
            System.err.println("❌ Exception during registration:");
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

}
