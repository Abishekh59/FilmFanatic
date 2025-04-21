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
        String rememberMe = request.getParameter("remember"); // "on" or null

        System.out.println("Login attempt for username: " + username);

        // authenticate (DAO does hash+compare)
        User user = userDAO.authenticateUser(username, plainPassword);

        if (user != null) {
            // success: put user in session
            request.getSession().setAttribute("user", user);

            // Remember-Me cookie
            Cookie cookie = new Cookie("username", (rememberMe != null ? username : ""));
            cookie.setPath("/");
            if (rememberMe != null) {
                cookie.setMaxAge(60 * 60 * 24 * 30); // 30 days
            } else {
                cookie.setMaxAge(0);               // delete
            }
            response.addCookie(cookie);

            response.sendRedirect("view/dashboard.jsp");
        } else {
            // failure: show error
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("login.jsp")
                   .forward(request, response);
        }
    }
}
