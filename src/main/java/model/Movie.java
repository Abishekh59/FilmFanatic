package model;

import java.sql.Date;
import java.sql.Timestamp;

public class Movie {
    private int movieId;
    private String title;
    private String description;
    private int genreId;
    private String director;
    private String cast;
    private Date releaseDate;
    private float rating;
    private Timestamp createdAt;

    public Movie(int movieId, String title, String description, int genreId, String director, String cast, Date releaseDate, float rating, Timestamp createdAt) {
        this.movieId = movieId;
        this.title = title;
        this.description = description;
        this.genreId = genreId;
        this.director = director;
        this.cast = cast;
        this.releaseDate = releaseDate;
        this.rating = rating;
        this.createdAt = createdAt;
    }

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getGenreId() {
		return genreId;
	}

	public void setGenreId(int genreId) {
		this.genreId = genreId;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getCast() {
		return cast;
	}

	public void setCast(String cast) {
		this.cast = cast;
	}

	public Date getReleaseDate() {
		return releaseDate;
	}

	public void setReleaseDate(Date releaseDate) {
		this.releaseDate = releaseDate;
	}

	public float getRating() {
		return rating;
	}

	public void setRating(float rating) {
		this.rating = rating;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}


}
