<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Check if user is logged in and is an admin
    if (session.getAttribute("user") == null || !"Admin".equalsIgnoreCase(((model.User)session.getAttribute("user")).getRole())) {
        response.sendRedirect(request.getContextPath() + "/view/login.jsp");
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
      background-color: rgba(0, 0, 0, 0.5);
      justify-content: center;
      align-items: center;
    }

    .modal-content {
      background-color: #333;
      padding: 2rem;
      border-radius: 4px;
      width: 400px;
    }

    .modal-header {
      display: flex;
      justify-content: space-between;
      margin-bottom: 1rem;
    }

    .modal-header h2 {
      margin: 0;
    }

    .modal-body input,
    .modal-body textarea,
    .modal-body select {
      width: 100%;
      padding: 0.8rem;
      margin: 0.5rem 0;
      border-radius: 4px;
      border: 1px solid #444;
    }

    .modal-footer {
      display: flex;
      justify-content: flex-end;
    }

    .modal-footer button {
      padding: 0.8rem 1.2rem;
      margin-left: 1rem;
      border-radius: 4px;
      border: none;
      background-color: #007bff;
      color: white;
      cursor: pointer;
    }

    .modal-footer button.close-btn {
      background-color: #dc3545;
    }
  </style>
</head>

<body>
  <header>
    <div class="logo">FilmFanatic</div>
    <nav>
      <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
      <a href="${pageContext.request.contextPath}/view/logout.jsp">Logout</a>
    </nav>
  </header>

  <div class="dashboard">
    <aside class="sidebar">
      <ul>
        <li><a href="${pageContext.request.contextPath}/UsersServlet">Users</a></li>
        <li><a href="${pageContext.request.contextPath}/AdminMoviesServlet">Movies</a></li>
        <li><a href="${pageContext.request.contextPath}/ReviewsServlet">Reviews</a></li>
        <li><a href="${pageContext.request.contextPath}/AnalyticsServlet">Analytics</a></li>
      </ul>
    </aside>

    <main class="main">
      <section class="section">
        <div class="section-header">
          <input type="text" placeholder="Search Movies..." />
          <button onclick="openModal()">+ Add Movie</button>
        </div>
        <table>
          <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Genre</th>
            <th>Rating</th>
            <th>Actions</th>
          </tr>
          <tr>
            <td>1</td>
            <td>Movie A</td>
            <td>Action</td>
            <td>7.1</td>
            <td class="action-btns">
              <button class="edit-btn" onclick="alert('Edit Movie')">Edit</button>
              <button class="delete-btn" onclick="alert('Delete Movie')">Delete</button>
            </td>
          </tr>
        </table>
      </section>
    </main>
  </div>

  <!-- Modal for Adding Movie -->
  <div class="modal" id="movieModal">
    <div class="modal-content">
      <div class="modal-header">
        <h2>Add Movie</h2>
        <button class="close-btn" onclick="closeModal()">X</button>
      </div>
      <div class="modal-body">
        <form id="addMovieForm" enctype="multipart/form-data">
          <input type="text" placeholder="Movie Title" id="movieTitle" name="title" required />
          <textarea placeholder="Description" id="movieDescription" name="description"></textarea>
          <input type="text" placeholder="Director" id="movieDirector" name="director" />
          <input type="text" placeholder="Cast" id="movieCast" name="cast" />
          <input type="date" id="releaseDate" name="release_date" />
          <input type="number" step="0.1" min="0" placeholder="Rating" id="movieRating" name="rating" />
          <select id="genreSelect" name="genre_id">
            <option value="">Select Genre</option>
            <option value="1">Action</option>
            <option value="2">Comedy</option>
            <option value="3">Drama</option>
          </select>
          <input type="file" id="movieImage" name="image_data" accept="image/*" />
        </form>
      </div>
      <div class="modal-footer">
        <button onclick="submitMovie()">Save</button>
        <button class="close-btn" onclick="closeModal()">Cancel</button>
      </div>
    </div>
  </div>

  <script>
    function openModal() {
      document.getElementById('movieModal').style.display = 'flex';
    }

    function closeModal() {
      document.getElementById('movieModal').style.display = 'none';
    }

    function submitMovie() {
      const form = document.getElementById('addMovieForm');
      const title = document.getElementById('movieTitle').value;
      const genre = document.getElementById('genreSelect').value;

      if (!title || !genre) {
        alert("Please fill all required fields");
        return;
      }
      

      // Example: Alert confirmation. In real app, send form via fetch or form.submit().
      const formData = new FormData(form);

      // Optional: For development feedback only
      alert("Movie Added: " + formData.get("title"));
      closeModal();

      // In real backend integration:
      // fetch('upload_movie.jsp', { method: 'POST', body: formData });
    }
    
  </script>
</body>

</html>
