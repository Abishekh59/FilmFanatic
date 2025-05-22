package controller;

import dao.UserDAO;
import model.User;
import util.DbConnectionUtil;
import util.SecurityUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Base64;

@WebServlet("/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,    // 5 MB
    maxRequestSize = 1024 * 1024 * 10  // 10 MB
)
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private Connection conn;

    @Override
    public void init() throws ServletException {
        try {
            conn = (Connection) getServletContext().getAttribute("DBConnection");
            if (conn == null) {
                conn = DbConnectionUtil.getConnection();
                if (conn != null) {
                    getServletContext().setAttribute("DBConnection", conn);
                }
            }
            userDAO = new UserDAO(conn);
        } catch (Exception e) {
            throw new ServletException("Error initializing ProfileServlet", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            // Get the latest user data including profile image
            User updatedUser = userDAO.getUserById(user.getUserId());
            if (updatedUser != null) {
                session.setAttribute("user", updatedUser);
            }
        } catch (SQLException e) {
            throw new ServletException("Error retrieving user data", e);
        }

        request.getRequestDispatcher("/view/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        if ("update".equals(action)) {
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            // Handle profile image upload
            Part filePart = request.getPart("profileImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                String fileType = filePart.getContentType();
                
                // Validate file type
                if (fileType.startsWith("image/")) {
                    // Convert image to Base64
                    byte[] imageBytes = filePart.getInputStream().readAllBytes();
                    String base64Image = Base64.getEncoder().encodeToString(imageBytes);
                    
                    // Update profile image (store only the base64 part)
                    if (userDAO.updateProfileImage(user.getUserId(), base64Image)) {
                        user.setProfileImage(base64Image);
                    }
                }
            }

            // Update user information
            user.setUsername(username);
            user.setEmail(email);

            if (newPassword != null && !newPassword.isEmpty()) {
                if (!newPassword.equals(confirmPassword)) {
                    request.setAttribute("error", "New passwords do not match");
                    request.getRequestDispatcher("/view/profile.jsp").forward(request, response);
                    return;
                }

                // Verify current password
                String hashedCurrentPassword = SecurityUtil.hashPassword(currentPassword);
                if (!hashedCurrentPassword.equals(user.getPassword())) {
                    request.setAttribute("error", "Current password is incorrect");
                    request.getRequestDispatcher("/view/profile.jsp").forward(request, response);
                    return;
                }

                // Update password
                user.setPassword(SecurityUtil.hashPassword(newPassword));
            }

            try {
                if (userDAO.updateUser(user)) {
                    session.setAttribute("user", user);
                    response.sendRedirect(request.getContextPath() + "/profile");
                } else {
                    request.setAttribute("error", "Failed to update profile");
                    request.getRequestDispatcher("/view/profile.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                request.setAttribute("error", "An error occurred while updating profile");
                request.getRequestDispatcher("/view/profile.jsp").forward(request, response);
            }
        }
    }

    @Override
    public void destroy() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} 