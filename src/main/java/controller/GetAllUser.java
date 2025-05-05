package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.User;
import dao.UserDAO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/GetAllUser")
public class GetAllUser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        try {
            // Attempt DB connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection testConn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/your_db", // Replace with your DB
                    "your_username",
                    "your_password"
            );
            System.out.println("✅ Database connected successfully in Servlet.");
            testConn.close(); // Close after test
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println("❌ Database connection failed in Servlet: " + e.getMessage());
        }

        // Initialize DAO (Make sure DAO manages its own connection or pass one here)
        userDAO = new UserDAO(null); // Assuming updated DAO handles connection
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = userDAO.getAllUsers();  // DAO should already handle errors internally

        if (users != null) {
            request.setAttribute("userList", users);
        } else {
            request.setAttribute("error", "Failed to fetch users from the database.");
        }

        request.getRequestDispatcher("view/Users.jsp").forward(request, response);
    }
}
