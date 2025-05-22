package dao;

import model.Genre;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GenreDAO {
    private Connection conn;

    public GenreDAO(Connection conn) {
        this.conn = conn;
    }

    // Get all genres
    public List<Genre> getAllGenres() throws SQLException {
        List<Genre> genres = new ArrayList<>();
        String sql = "SELECT * FROM genre ORDER BY name";
        
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Genre genre = new Genre(
                    rs.getInt("genre_id"),
                    rs.getString("name")
                );
                genres.add(genre);
            }
        }
        return genres;
    }

    // Get genre by ID
    public Genre getGenreById(int id) throws SQLException {
        String sql = "SELECT * FROM genre WHERE genre_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Genre(
                    rs.getInt("genre_id"),
                    rs.getString("name")
                );
            }
        }
        return null;
    }

    // Add new genre
    public void addGenre(Genre genre) throws SQLException {
        String sql = "INSERT INTO genre (name) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, genre.getName());
            stmt.executeUpdate();
        }
    }

    // Update genre
    public void updateGenre(Genre genre) throws SQLException {
        String sql = "UPDATE genre SET name = ? WHERE genre_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, genre.getName());
            stmt.setInt(2, genre.getGenreId());
            stmt.executeUpdate();
        }
    }

    // Delete genre
    public void deleteGenre(int id) throws SQLException {
        String sql = "DELETE FROM genre WHERE genre_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
        }
    }
}
