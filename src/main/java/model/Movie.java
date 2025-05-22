package model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.Base64;

public class Movie {
    private int movieId;
    private String title;
    private String description;
    private int genreId;
    private String genreName;
    private String director;
    private String cast;
    private Date releaseDate;
    private float rating;
    private float averageRating;
    private Timestamp createdAt;
    private byte[] imageData;

    // Constructors
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
    
    public Movie(String title, String description, int genreId, String director, String cast, Date releaseDate, float rating) {
        this.title = title;
        this.description = description;
        this.genreId = genreId;
        this.director = director;
        this.cast = cast;
        this.releaseDate = releaseDate;
        this.rating = rating;
    }
    
    public Movie() {
		// Default constructor
	}

    // Getters and Setters
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

    public String getGenreName() {
        return genreName;
    }

    public void setGenreName(String genreName) {
        this.genreName = genreName;
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

    public float getAverageRating() {
        return averageRating;
    }

    public void setAverageRating(float averageRating) {
        this.averageRating = averageRating;
    }

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

    public byte[] getImageData() {
        return imageData;
    }

    public void setImageData(byte[] imageData) {
        this.imageData = imageData;
    }

    // Additional method to return base64-encoded image string
    public String getImageBase64() {
        if (imageData != null && imageData.length > 0) {
            return Base64.getEncoder().encodeToString(imageData);
        }
        return null;
    }
}
