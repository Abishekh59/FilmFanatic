package controller;

import dao.UserDAO;
import model.User;
import Utils.DbConnectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        Connection conn = DbConnectionUtil.getConnection();
        if (conn == null) {
            throw new ServletException("DB connection failed");
        }
        userDAO = new UserDAO(conn);
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String plainPassword = request.getParameter("password");
        String rememberMe = request.getParameter("remember");

        System.out.println("Login attempt for username: " + username);

        User user = userDAO.authenticateUser(username, plainPassword);

        if (user != null) {
            // Put user in session
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Remember-Me cookie
            Cookie cookie = new Cookie("username", (rememberMe != null ? username : ""));
            cookie.setPath("/");
            cookie.setMaxAge(rememberMe != null ? (60 * 60 * 24 * 30) : 0);
            response.addCookie(cookie);

            // Redirect based on role
            String role = user.getRole(); // Ensure `getRole()` exists in your User model
            if ("Admin".equalsIgnoreCase(role)) {
                response.sendRedirect("view/admin_panel.jsp");
            } else {
                response.sendRedirect("view/dashboard.jsp");
            }

        } else {
            // Login failed
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}