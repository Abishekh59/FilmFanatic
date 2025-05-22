<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Movie" %>
<%
    // Check if user is logged in and is an admin
    if (session.getAttribute("user") == null || !"Admin".equalsIgnoreCase(((model.User)session.getAttribute("user")).getRole())) {
        response.sendRedirect(request.getContextPath() + "/view/admin/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Admin Dashboard - FilmFanatic</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: Arial, sans-serif;
    }

    body {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      background-color: #1e1f29;
      color: #fff;
    }

    header {
      background-color: #111;
      padding: 1rem 2rem;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    .logo {
      font-size: 1.5rem;
      font-weight: bold;
    }

    nav a {
      color: #fff;
      margin-left: 1.5rem;
      text-decoration: none;
    }

    nav input[type="text"] {
      padding: 0.5rem;
      border-radius: 4px;
      border: none;
      margin-left: 1.5rem;
    }

    .dashboard {
      display: flex;
      flex: 1;
    }

    .sidebar {
      width: 200px;
      background-color: #272935;
      padding: 1rem;
    }

    .sidebar ul {
      list-style: none;
    }

    .sidebar ul li {
      margin-bottom: 1rem;
      color: #fff;
      cursor: pointer;
    }

    .sidebar a {
      text-decoration: none;
      color: white;
    }

    .sidebar a:hover {
      color: #00bfff;
      background-color: #3a3b47;
      padding-left: 10px;
      border-radius: 4px;
      transition: all 0.3s ease;
    }

    .main {
      flex: 1;
      padding: 2rem;
    }

    .section {
      margin-bottom: 2rem;
    }

    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1rem;
    }

    .section-header input {
      padding: 0.5rem;
      border-radius: 4px;
      border: none;
    }

    .section-header button {
      padding: 0.5rem 1rem;
      background-color: red;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      background: #2e2f3e;
    }

    th,
    td {
      padding: 0.8rem;
      border: 1px solid #444;
      text-align: left;
    }

    .action-btns button {
      margin-right: 0.5rem;
      padding: 0.4rem 0.7rem;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .edit-btn {
      background-color: #007bff;
      color: white;
    }

    .delete-btn {
      background-color: #dc3545;
      color: white;
    }

    /* Modal styles */
    .modal {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, 0.7);
      z-index: 1000;
    }

    .modal-content {
      background-color: #2e2f3e;
      margin: 10% auto;
      padding: 2rem;
      width: 50%;
      border-radius: 8px;
      position: relative;
      color: #fff;
    }

    .close {
      position: absolute;
      right: 1rem;
      top: 1rem;
      font-size: 1.5rem;
      cursor: pointer;
      color: #fff;
    }

    .form-group {
      margin-bottom: 1rem;
    }

    .form-group label {
      display: block;
      margin-bottom: 0.5rem;
      color: #fff;
    }

    .form-group input, .form-group textarea, .form-group select {
      width: 100%;
      padding: 0.5rem;
      border-radius: 4px;
      border: 1px solid #444;
      background-color: #1e1f29;
      color: #fff;
    }

    .form-group textarea {
      min-height: 100px;
      resize: vertical;
    }

    .form-actions {
      margin-top: 1.5rem;
      text-align: right;
    }

    .form-actions button {
      padding: 0.5rem 1rem;
      border: none;
      border-radius: 4px;
      cursor: pointer;
      margin-left: 0.5rem;
    }

    .submit-btn {
      background-color: #28a745;
      color: white;
    }

    .cancel-btn {
      background-color: #6c757d;
      color: white;
    }
  </style>
</head>

<body>
  <!-- Add Movie Modal -->
  <div id="addMovieModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('addMovieModal')">&times;</span>
      <h2>Add New Movie</h2>
      <form action="${pageContext.request.contextPath}/admin/movies/add" method="POST" enctype="multipart/form-data">
        <div class="form-group">
          <label for="addTitle">Title</label>
          <input type="text" id="addTitle" name="title" required>
        </div>
        <div class="form-group">
          <label for="addDirector">Director</label>
          <input type="text" id="addDirector" name="director" required>
        </div>
        <div class="form-group">
          <label for="addCast">Cast</label>
          <input type="text" id="addCast" name="cast" required>
        </div>
        <div class="form-group">
          <label for="addReleaseYear">Release Year</label>
          <input type="number" id="addReleaseYear" name="releaseYear" required>
        </div>
        <div class="form-group">
          <label for="addGenreId">Genre</label>
          <select id="addGenreId" name="genreId" required>
            <c:forEach items="${genres}" var="genre">
              <option value="${genre.genreId}">${genre.name}</option>
            </c:forEach>
          </select>
        </div>
        <div class="form-group">
          <label for="addRating">Rating</label>
          <input type="number" id="addRating" name="rating" step="0.1" min="0" max="10" required>
        </div>
        <div class="form-group">
          <label for="addDescription">Description</label>
          <textarea id="addDescription" name="description" required></textarea>
        </div>
        <div class="form-group">
          <label for="addImage">Movie Poster</label>
          <input type="file" id="addImage" name="image" accept="image/*">
          <div id="imagePreview" style="margin-top: 10px; display: none;">
            <img id="previewImg" src="" alt="Preview" style="max-width: 200px; max-height: 300px; object-fit: cover;">
          </div>
        </div>
        <div class="form-actions">
          <button type="button" class="cancel-btn" onclick="closeModal('addMovieModal')">Cancel</button>
          <button type="submit" class="submit-btn">Add Movie</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Edit Movie Modal -->
  <div id="editMovieModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('editMovieModal')">&times;</span>
      <h2>Edit Movie</h2>
      <form action="${pageContext.request.contextPath}/admin/movies/edit" method="POST" enctype="multipart/form-data">
        <input type="hidden" id="editMovieId" name="movieId">
        <div class="form-group">
          <label for="editTitle">Title</label>
          <input type="text" id="editTitle" name="title" required>
        </div>
        <div class="form-group">
          <label for="editDirector">Director</label>
          <input type="text" id="editDirector" name="director" required>
        </div>
        <div class="form-group">
          <label for="editCast">Cast</label>
          <input type="text" id="editCast" name="cast" required>
        </div>
        <div class="form-group">
          <label for="editReleaseYear">Release Year</label>
          <input type="number" id="editReleaseYear" name="releaseYear" required>
        </div>
        <div class="form-group">
          <label for="editGenreId">Genre</label>
          <select id="editGenreId" name="genreId" required>
            <c:forEach items="${genres}" var="genre">
              <option value="${genre.genreId}">${genre.name}</option>
            </c:forEach>
          </select>
        </div>
        <div class="form-group">
          <label for="editRating">Rating</label>
          <input type="number" id="editRating" name="rating" step="0.1" min="0" max="10" required>
        </div>
        <div class="form-group">
          <label for="editDescription">Description</label>
          <textarea id="editDescription" name="description" required></textarea>
        </div>
        <div class="form-group">
          <label for="editImage">Movie Poster</label>
          <input type="file" id="editImage" name="image" accept="image/*">
          <div id="editImagePreview" style="margin-top: 10px;">
            <img id="editPreviewImg" src="" alt="Preview" style="max-width: 200px; max-height: 300px; object-fit: cover;">
          </div>
        </div>
        <div class="form-actions">
          <button type="button" class="cancel-btn" onclick="closeModal('editMovieModal')">Cancel</button>
          <button type="submit" class="submit-btn">Save Changes</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Delete Movie Modal -->
  <div id="deleteMovieModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('deleteMovieModal')">&times;</span>
      <h2>Delete Movie</h2>
      <p>Are you sure you want to delete this movie?</p>
      <form action="${pageContext.request.contextPath}/admin/movies/delete" method="POST">
        <input type="hidden" id="deleteMovieId" name="movieId">
        <div class="form-actions">
          <button type="button" class="cancel-btn" onclick="closeModal('deleteMovieModal')">Cancel</button>
          <button type="submit" class="delete-btn">Delete</button>
        </div>
      </form>
    </div>
  </div>

  <header>
    <div class="logo">FilmFanatic</div>
    <nav>
      <a href="${pageContext.request.contextPath}/admin/panel">Dashboard</a>
      <a href="${pageContext.request.contextPath}/view/logout.jsp">Logout</a>
    </nav>
  </header>

  <div class="dashboard">
    <aside class="sidebar">
      <ul>
        <li><a href="${pageContext.request.contextPath}/admin/users">Users</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/movies">Movies</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/reviews">Reviews</a></li>
        <li><a href="${pageContext.request.contextPath}/admin/analytics">Analytics</a></li>
      </ul>
    </aside>

    <main class="main">
      <section class="section">
        <div class="section-header">
          <input type="text" placeholder="Search Movies..." />
          <button type="button" id="addMovieBtn">+ Add Movie</button>
        </div>

        <table>
          <thead>
            <tr>
              <th>Image</th>
              <th>ID</th>
              <th>Title</th>
              <th>Director</th>
              <th>Release Year</th>
              <th>Genre</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <%
              List<Movie> movieList = (List<Movie>) request.getAttribute("movieList");
              if (movieList != null && !movieList.isEmpty()) {
                for (Movie movie : movieList) {
            %>
              <tr>
                <td>
                  <% if (movie.getImageData() != null && movie.getImageData().length > 0) { %>
                    <img src="data:image/jpeg;base64,<%= movie.getImageBase64() %>" 
                         alt="<%= movie.getTitle() %>" 
                         style="width: 100px; height: 150px; object-fit: cover; border-radius: 5px;">
                  <% } else { %>
                    <img src="${pageContext.request.contextPath}/images/default-movie.png" 
                         alt="Default Movie Image" 
                         style="width: 100px; height: 150px; object-fit: cover; border-radius: 5px;">
                  <% } %>
                </td>
                <td><%= movie.getMovieId() %></td>
                <td><%= movie.getTitle() %></td>
                <td><%= movie.getDirector() %></td>
                <td><%= movie.getReleaseDate() != null ? movie.getReleaseDate().toLocalDate().getYear() : "" %></td>
                <td><%= movie.getGenreName() %></td>
                <td class="action-btns">
                  <button class="edit-btn" onclick="openEditModal('<%= movie.getMovieId() %>', '<%= movie.getTitle() %>', '<%= movie.getDirector() %>', '<%= movie.getCast() %>', '<%= movie.getReleaseDate() != null ? movie.getReleaseDate().toLocalDate().getYear() : "" %>', '<%= movie.getGenreId() %>', '<%= movie.getRating() %>', '<%= movie.getDescription() %>')">Edit</button>
                  <button class="delete-btn" onclick="openDeleteModal('<%= movie.getMovieId() %>')">Delete</button>
                </td>
              </tr>
            <%
                }
              } else {
            %>
              <tr>
                <td colspan="7" style="text-align: center;">No movies found</td>
              </tr>
            <%
              }
            %>
          </tbody>
        </table>
      </section>
    </main>
  </div>

  <script>
    function openModal(modalId) {
      document.getElementById(modalId).style.display = 'block';
    }

    function closeModal(modalId) {
      document.getElementById(modalId).style.display = 'none';
    }

    function openEditModal(movieId, title, director, cast, releaseYear, genreId, rating, description) {
      document.getElementById('editMovieId').value = movieId;
      document.getElementById('editTitle').value = title;
      document.getElementById('editDirector').value = director;
      document.getElementById('editCast').value = cast;
      document.getElementById('editReleaseYear').value = releaseYear;
      document.getElementById('editGenreId').value = genreId;
      document.getElementById('editRating').value = rating;
      document.getElementById('editDescription').value = description;
      
      // Clear previous image preview
      document.getElementById('editPreviewImg').src = '';
      document.getElementById('editImagePreview').style.display = 'none';
      
      document.getElementById('editMovieModal').style.display = 'block';
    }

    function openDeleteModal(movieId) {
      document.getElementById('deleteMovieId').value = movieId;
      openModal('deleteMovieModal');
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
      if (event.target.className === 'modal') {
        event.target.style.display = 'none';
      }
    }

    // Add event listener for the Add Movie button
    document.addEventListener('DOMContentLoaded', function() {
      const addMovieBtn = document.getElementById('addMovieBtn');
      if (addMovieBtn) {
        addMovieBtn.addEventListener('click', function() {
          console.log('Add Movie button clicked');
          openModal('addMovieModal');
        });
      }
    });

    // Add image preview functionality
    document.getElementById('addImage').addEventListener('change', function(e) {
      const file = e.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          document.getElementById('previewImg').src = e.target.result;
          document.getElementById('imagePreview').style.display = 'block';
        }
        reader.readAsDataURL(file);
      }
    });

    document.getElementById('editImage').addEventListener('change', function(e) {
      const file = e.target.files[0];
      if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
          document.getElementById('editPreviewImg').src = e.target.result;
          document.getElementById('editImagePreview').style.display = 'block';
        }
        reader.readAsDataURL(file);
      }
    });
  </script>
</body>

</html>
