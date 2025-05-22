package controller;

import dao.MovieDAO;
import model.Movie;
import util.DbConnectionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.util.List;

@WebServlet("/movies")  // Use plural for resource naming conventions
@MultipartConfig(maxFileSize = 16177215) // max 16MB upload
public class MovieServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public MovieServlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Use try-with-resources for Connection to ensure proper closure
        try (Connection conn = DbConnectionUtil.getConnection()) {
            MovieDAO movieDAO = new MovieDAO(conn);
            List<Movie> movies = movieDAO.getAllMovies();
            request.setAttribute("movies", movies);
            request.getRequestDispatcher("view/admin/Movies.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error retrieving movies", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String director = request.getParameter("director");
        String cast = request.getParameter("cast");
        String releaseDateStr = request.getParameter("releaseDate");
        String ratingStr = request.getParameter("rating");
        String genreIdStr = request.getParameter("genreId");

        // Basic validation could be added here...

        try {
            Date releaseDate = Date.valueOf(releaseDateStr);
            float rating = Float.parseFloat(ratingStr);
            int genreId = Integer.parseInt(genreIdStr);

            Part imagePart = request.getPart("image");
            byte[] imageBytes = null;

            if (imagePart != null && imagePart.getSize() > 0) {
                try (InputStream is = imagePart.getInputStream()) {
                    imageBytes = is.readAllBytes();
                }
            }

            Movie movie = new Movie(title, description, genreId, director, cast, releaseDate, rating);

            try (Connection conn = DbConnectionUtil.getConnection()) {
                MovieDAO movieDAO = new MovieDAO(conn);
                movieDAO.addMovie(movie);
            }

            response.sendRedirect(request.getContextPath() + "/movies");

        } catch (Exception e) {
            throw new ServletException("Error adding new movie", e);
        }
    }
}
