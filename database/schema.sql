-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS filmfanatic_db;

-- Use the database
USE filmfanatic_db;

-- Drop tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS review;
DROP TABLE IF EXISTS movie;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS user;

-- USER TABLE
CREATE TABLE user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('Admin', 'User') DEFAULT 'User',
    profile_image LONGBLOB DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- GENRE TABLE
CREATE TABLE genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- MOVIE TABLE
CREATE TABLE movie (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    director VARCHAR(100),
    cast TEXT,
    release_date DATE,
    rating FLOAT DEFAULT 0.0,
    genre_id INT,
    image_data LONGBLOB,
    FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

-- REVIEW TABLE
CREATE TABLE review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    comment TEXT NOT NULL,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT,
    movie_id INT,
    rating FLOAT CHECK (rating >= 0.0 AND rating <= 10.0),
    FOREIGN KEY (user_id) REFERENCES user(user_id),
    FOREIGN KEY (movie_id) REFERENCES movie(movie_id)
);