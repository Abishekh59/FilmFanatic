package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Review;

public class ReviewDAO {
    private final Connection conn;

    public ReviewDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addReview(Review review) throws SQLException {
        String sql = "INSERT INTO review (movie_id, user_id, rating, comment, review_date) VALUES (?, ?, ?, ?, NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, review.getMovieId());
            stmt.setInt(2, review.getUserId());
            stmt.setFloat(3, review.getRating());
            stmt.setString(4, review.getComment());
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    public List<Review> getReviewsByMovieId(int movieId) throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.username FROM review r " +
                    "JOIN user u ON r.user_id = u.user_id " +
                    "WHERE r.movie_id = ? " +
                    "ORDER BY r.review_date DESC";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReviewId(rs.getInt("review_id"));
                    review.setMovieId(rs.getInt("movie_id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setUsername(rs.getString("username"));
                    review.setRating(rs.getFloat("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setReviewDate(rs.getTimestamp("review_date"));
                    reviews.add(review);
                }
            }
        }
        return reviews;
    }

    public Review getReviewById(int reviewId) throws SQLException {
        String sql = "SELECT r.*, u.username FROM review r " +
                    "JOIN user u ON r.user_id = u.user_id " +
                    "WHERE r.review_id = ?";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Review review = new Review();
                    review.setReviewId(rs.getInt("review_id"));
                    review.setMovieId(rs.getInt("movie_id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setUsername(rs.getString("username"));
                    review.setRating(rs.getFloat("rating"));
                    review.setComment(rs.getString("comment"));
                    review.setReviewDate(rs.getTimestamp("review_date"));
                    return review;
                }
            }
        }
        return null;
    }

    public boolean updateReview(Review review) throws SQLException {
        String sql = "UPDATE review SET rating = ?, comment = ? WHERE review_id = ? AND user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setFloat(1, review.getRating());
            stmt.setString(2, review.getComment());
            stmt.setInt(3, review.getReviewId());
            stmt.setInt(4, review.getUserId());
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    public boolean deleteReview(int reviewId, int userId) throws SQLException {
        String sql = "DELETE FROM review WHERE review_id = ? AND user_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            stmt.setInt(2, userId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        }
    }

    public int getTotalReviews() throws SQLException {
        String query = "SELECT COUNT(*) FROM review";
        try (PreparedStatement stmt = conn.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        }
    }

    public List<Review> getAllReviews() throws SQLException {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.username, m.title as movie_title FROM review r " +
                    "JOIN user u ON r.user_id = u.user_id " +
                    "JOIN movie m ON r.movie_id = m.movie_id " +
                    "ORDER BY r.review_date DESC";
        
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Review review = new Review();
                review.setReviewId(rs.getInt("review_id"));
                review.setMovieId(rs.getInt("movie_id"));
                review.setUserId(rs.getInt("user_id"));
                review.setUsername(rs.getString("username"));
                review.setMovieTitle(rs.getString("movie_title"));
                review.setRating(rs.getFloat("rating"));
                review.setComment(rs.getString("comment"));
                review.setReviewDate(rs.getTimestamp("review_date"));
                reviews.add(review);
            }
        }
        return reviews;
    }
}
