package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import dao.UserDAO;
import model.User;
import util.DbConnectionUtil;
import util.SecurityUtil;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/admin/users/*")
public class UsersServlet extends HttpServlet {
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
            // Get all users
            List<User> users = userDAO.getAllUsers();
            
            // Set users in request attribute
            request.setAttribute("userList", users);
            
            // Forward to JSP
            request.getRequestDispatcher("/view/admin/users.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error retrieving users: " + e.getMessage());
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
                    handleAddUser(request, response);
                    break;
                case "/edit":
                    handleEditUser(request, response);
                    break;
                case "/delete":
                    handleDeleteUser(request, response);
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

    private void handleAddUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Hash the password
        String hashedPassword = SecurityUtil.hashPassword(password);

        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(hashedPassword);
        newUser.setRole(role);

        if (userDAO.registerUser(newUser)) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } else {
            request.setAttribute("errorMessage", "Failed to add user");
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }

    private void handleEditUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        User user = new User();
        user.setUserId(userId);
        user.setUsername(username);
        user.setEmail(email);
        user.setRole(role);

        try {
            if (userDAO.updateUser(user)) {
                response.sendRedirect(request.getContextPath() + "/admin/users");
            } else {
                request.setAttribute("errorMessage", "Failed to update user");
                request.getRequestDispatcher("/view/error.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error updating user: " + e.getMessage());
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }

    private void handleDeleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        if (userDAO.deleteUser(userId)) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        } else {
            request.setAttribute("errorMessage", "Failed to delete user");
            request.getRequestDispatcher("/view/error.jsp").forward(request, response);
        }
    }
}
