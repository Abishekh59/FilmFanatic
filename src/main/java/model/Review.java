package model;

import java.sql.Timestamp;

public class Review {
    private int reviewId;
    private int userId;
    private int movieId;
    private String comment;
    private float rating;
    private Timestamp reviewDate;

    public Review(int reviewId, int userId, int movieId, String comment, float rating, Timestamp reviewDate) {
        this.reviewId = reviewId;
        this.userId = userId;
        this.movieId = movieId;
        this.comment = comment;
        this.rating = rating;
        this.reviewDate = reviewDate;
    }

	public int getReviewId() {
		return reviewId;
	}

	public void setReviewId(int reviewId) {
		this.reviewId = reviewId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public float getRating() {
		return rating;
	}

	public void setRating(float rating) {
		this.rating = rating;
	}

	public Timestamp getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Timestamp reviewDate) {
		this.reviewDate = reviewDate;
	}

    
}
