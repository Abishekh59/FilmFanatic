package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Movie;

public class MovieDAO {

    private final Connection conn;

    public MovieDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addMovie(Movie movie) {
        String sql = "INSERT INTO movie (title, description, director, cast, release_date, rating, genre_id, image_data) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, movie.getTitle());
            stmt.setString(2, movie.getDescription());
            stmt.setString(3, movie.getDirector());
            stmt.setString(4, movie.getCast());
            stmt.setDate(5, movie.getReleaseDate());
            stmt.setFloat(6, movie.getRating());
            stmt.setInt(7, movie.getGenreId());
            stmt.setBytes(8, movie.getImageData());
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
            }
        }

    public List<Movie> getAllMovies() throws SQLException {
        List<Movie> movies = new ArrayList<>();
        String sql = "SELECT m.*, g.name as genre_name FROM movie m " +
                    "LEFT JOIN genre g ON m.genre_id = g.genre_id " +
                    "ORDER BY m.created_at DESC";
        
        System.out.println("Executing SQL: " + sql);
        
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            System.out.println("Found " + rs.getFetchSize() + " movies");
            
            while (rs.next()) {
                Movie movie = extractMovieFromResultSet(rs);
                movie.setGenreName(rs.getString("genre_name"));
                movies.add(movie);
                System.out.println("Added movie: " + movie.getTitle());
            }
        }
        System.out.println("Total movies found: " + movies.size());
        return movies;
    }

    private Movie extractMovieFromResultSet(ResultSet rs) throws SQLException {
        Movie movie = new Movie(
            rs.getInt("movie_id"),
            rs.getString("title"),
            rs.getString("description"),
            rs.getInt("genre_id"),
            rs.getString("director"),
            rs.getString("cast"),
            rs.getDate("release_date"),
            rs.getFloat("rating"),
            rs.getTimestamp("created_at")
        );
        
        // Get image data if available
        byte[] imageData = rs.getBytes("image_data");
        if (imageData != null) {
            movie.setImageData(imageData);
        }
        
        return movie;
    }

    public Movie getMovieById(int movieId) throws SQLException {
        String sql = "SELECT m.*, g.name as genre_name FROM movie m " +
                    "LEFT JOIN genre g ON m.genre_id = g.genre_id " +
                    "WHERE m.movie_id = ?";
        
        System.out.println("Executing SQL: " + sql + " with movieId: " + movieId);
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Movie movie = extractMovieFromResultSet(rs);
                    movie.setGenreName(rs.getString("genre_name"));
                    System.out.println("Found movie: " + movie.getTitle());
                    return movie;
                }
            }
        }
        System.out.println("No movie found with ID: " + movieId);
        return null;
    }

    public int getTotalMovies() throws SQLException {
        String query = "SELECT COUNT(*) FROM movie";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    public boolean genreExists(int genreId) {
        String sql = "SELECT COUNT(*) FROM genre WHERE genre_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, genreId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateMovie(Movie movie) {
        // First check if the genre exists
        if (!genreExists(movie.getGenreId())) {
            System.out.println("Genre ID " + movie.getGenreId() + " does not exist");
            return false;
        }

        String sql = "UPDATE movie SET title=?, description=?, director=?, cast=?, release_date=?, genre_id=?, rating=?, image_data=? WHERE movie_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, movie.getTitle());
            stmt.setString(2, movie.getDescription());
            stmt.setString(3, movie.getDirector());
            stmt.setString(4, movie.getCast());
            stmt.setDate(5, movie.getReleaseDate());
            stmt.setInt(6, movie.getGenreId());
            stmt.setFloat(7, movie.getRating());
            stmt.setBytes(8, movie.getImageData());
            stmt.setInt(9, movie.getMovieId());

            System.out.println("Updating movie with ID: " + movie.getMovieId());
            System.out.println("Title: " + movie.getTitle());
            System.out.println("Description: " + movie.getDescription());
            System.out.println("Director: " + movie.getDirector());
            System.out.println("Cast: " + movie.getCast());
            System.out.println("Release Date: " + movie.getReleaseDate());
            System.out.println("Genre ID: " + movie.getGenreId());
            System.out.println("Rating: " + movie.getRating());
            System.out.println("Has image data: " + (movie.getImageData() != null && movie.getImageData().length > 0));

            int rows = stmt.executeUpdate();
            System.out.println("Rows affected: " + rows);
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Error updating movie: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteMovie(int movieId) {
        String sql = "DELETE FROM movie WHERE movie_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
