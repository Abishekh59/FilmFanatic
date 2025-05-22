<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Review" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <!-- Add Review Modal -->
  <div id="addReviewModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('addReviewModal')">&times;</span>
      <h2>Add Review</h2>
      <form action="${pageContext.request.contextPath}/admin/reviews/add" method="POST">
        <div class="form-group">
          <label for="addUserId">User</label>
          <select id="addUserId" name="userId" required>
            <c:forEach items="${userList}" var="user">
              <option value="${user.userId}">${user.username}</option>
            </c:forEach>
          </select>
        </div>
        <div class="form-group">
          <label for="addMovieId">Movie</label>
          <select id="addMovieId" name="movieId" required>
            <c:forEach items="${movieList}" var="movie">
              <option value="${movie.movieId}">${movie.title}</option>
            </c:forEach>
          </select>
        </div>
        <div class="form-group">
          <label for="addRating">Rating</label>
          <input type="number" id="addRating" name="rating" min="1" max="10" step="0.1" required>
        </div>
        <div class="form-group">
          <label for="addComment">Comment</label>
          <textarea id="addComment" name="comment" required></textarea>
        </div>
        <div class="form-actions">
          <button type="button" class="cancel-btn" onclick="closeModal('addReviewModal')">Cancel</button>
          <button type="submit" class="submit-btn">Add Review</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Edit Review Modal -->
  <div id="editReviewModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('editReviewModal')">&times;</span>
      <h2>Edit Review</h2>
      <form action="${pageContext.request.contextPath}/admin/reviews/edit" method="POST">
        <input type="hidden" id="editReviewId" name="reviewId">
        <div class="form-group">
          <label for="editUserId">User</label>
          <select id="editUserId" name="userId" required>
            <c:forEach items="${userList}" var="user">
              <option value="${user.userId}">${user.username}</option>
            </c:forEach>
          </select>
        </div>
        <div class="form-group">
          <label for="editMovieId">Movie</label>
          <select id="editMovieId" name="movieId" required>
            <c:forEach items="${movieList}" var="movie">
              <option value="${movie.movieId}">${movie.title}</option>
            </c:forEach>
          </select>
        </div>
        <div class="form-group">
          <label for="editRating">Rating</label>
          <input type="number" id="editRating" name="rating" min="1" max="10" step="0.1" required>
        </div>
        <div class="form-group">
          <label for="editComment">Comment</label>
          <textarea id="editComment" name="comment" required></textarea>
        </div>
        <div class="form-actions">
          <button type="button" class="cancel-btn" onclick="closeModal('editReviewModal')">Cancel</button>
          <button type="submit" class="submit-btn">Save Changes</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Delete Review Modal -->
  <div id="deleteReviewModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('deleteReviewModal')">&times;</span>
      <h2>Delete Review</h2>
      <p>Are you sure you want to delete this review?</p>
      <form action="${pageContext.request.contextPath}/admin/reviews/delete" method="POST">
        <input type="hidden" id="deleteReviewId" name="reviewId">
        <input type="hidden" id="deleteUserId" name="userId">
        <div class="form-actions">
          <button type="button" class="cancel-btn" onclick="closeModal('deleteReviewModal')">Cancel</button>
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
          <input type="text" placeholder="Search Reviews..." />
          <button onclick="openModal('addReviewModal')">+ Add Review</button>
        </div>

        <table>
          <thead>
          <tr>
            <th>ID</th>
              <th>User</th>
            <th>Movie</th>
              <th>Rating</th>
            <th>Comment</th>
            <th>Actions</th>
          </tr>
          </thead>
          <tbody>
            <%
              List<Review> reviewList = (List<Review>) request.getAttribute("reviewList");
              if (reviewList != null && !reviewList.isEmpty()) {
                for (Review review : reviewList) {
            %>
              <tr>
                <td><%= review.getReviewId() %></td>
                <td><%= review.getUserId() %></td>
                <td><%= review.getMovieId() %></td>
                <td><%= review.getRating() %></td>
                <td><%= review.getComment() %></td>
              <td class="action-btns">
                  <button class="edit-btn" onclick="openEditModal('<%= review.getReviewId() %>', '<%= review.getUserId() %>', '<%= review.getMovieId() %>', '<%= review.getRating() %>', '<%= review.getComment() %>')">Edit</button>
                  <button class="delete-btn" onclick="openDeleteModal('<%= review.getReviewId() %>', '<%= review.getUserId() %>')">Delete</button>
              </td>
            </tr>
            <%
                }
              } else {
            %>
              <tr>
                <td colspan="6" style="text-align: center;">No reviews found</td>
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

    function openEditModal(reviewId, userId, movieId, rating, comment) {
      document.getElementById('editReviewId').value = reviewId;
      document.getElementById('editUserId').value = userId;
      document.getElementById('editMovieId').value = movieId;
      document.getElementById('editRating').value = rating;
      document.getElementById('editComment').value = comment;
      openModal('editReviewModal');
    }

    function openDeleteModal(reviewId, userId) {
      document.getElementById('deleteReviewId').value = reviewId;
      document.getElementById('deleteUserId').value = userId;
      openModal('deleteReviewModal');
    }

    // Close modal when clicking outside
    window.onclick = function(event) {
      if (event.target.className === 'modal') {
        event.target.style.display = 'none';
      }
    }
  </script>
</body>

</html>
