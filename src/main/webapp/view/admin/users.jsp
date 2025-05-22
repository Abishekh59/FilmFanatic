<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
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
  <title>Users - FilmFanatic Admin</title>
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

    .form-group input, .form-group select {
      width: 100%;
      padding: 0.5rem;
      border-radius: 4px;
      border: 1px solid #444;
      background-color: #1e1f29;
      color: #fff;
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

    .profile-image {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      object-fit: cover;
    }

    .profile-image-cell {
      width: 70px;
      text-align: center;
    }
  </style>
</head>
<body>
  <!-- Add User Modal -->
  <div id="addUserModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('addUserModal')">&times;</span>
      <h2>Add New User</h2>
      <form action="${pageContext.request.contextPath}/admin/users/add" method="POST">
        <div class="form-group">
          <label for="username">Username</label>
          <input type="text" id="username" name="username" required>
        </div>
        <div class="form-group">
          <label for="email">Email</label>
          <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
          <label for="password">Password</label>
          <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
          <label for="role">Role</label>
          <select id="role" name="role" required>
            <option value="User">User</option>
            <option value="Admin">Admin</option>
          </select>
        </div>
        <div class="form-actions">
          <button type="button" class="cancel-btn" onclick="closeModal('addUserModal')">Cancel</button>
          <button type="submit" class="submit-btn">Add User</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Edit User Modal -->
  <div id="editUserModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('editUserModal')">&times;</span>
      <h2>Edit User</h2>
      <form action="${pageContext.request.contextPath}/admin/users/edit" method="POST">
        <input type="hidden" id="editUserId" name="userId">
        <div class="form-group">
          <label for="editUsername">Username</label>
          <input type="text" id="editUsername" name="username" required>
        </div>
        <div class="form-group">
          <label for="editEmail">Email</label>
          <input type="email" id="editEmail" name="email" required>
        </div>
        <div class="form-group">
          <label for="editRole">Role</label>
          <select id="editRole" name="role" required>
            <option value="User">User</option>
            <option value="Admin">Admin</option>
          </select>
        </div>
        <div class="form-actions">
          <button type="button" class="cancel-btn" onclick="closeModal('editUserModal')">Cancel</button>
          <button type="submit" class="submit-btn">Save Changes</button>
        </div>
      </form>
    </div>
  </div>

  <!-- Delete User Modal -->
  <div id="deleteUserModal" class="modal">
    <div class="modal-content">
      <span class="close" onclick="closeModal('deleteUserModal')">&times;</span>
      <h2>Delete User</h2>
      <p>Are you sure you want to delete this user?</p>
      <form action="${pageContext.request.contextPath}/admin/users/delete" method="POST">
        <input type="hidden" id="deleteUserId" name="userId">
        <div class="form-actions">
          <button type="button" class="cancel-btn" onclick="closeModal('deleteUserModal')">Cancel</button>
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
          <input type="text" placeholder="Search Users..." />
          <button onclick="openModal('addUserModal')">+ Add User</button>
        </div>

        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Profile</th>
              <th>Username</th>
              <th>Email</th>
              <th>Role</th>
              <th>Created At</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${userList}" var="user">
              <tr>
                <td>${user.userId}</td>
                <td class="profile-image-cell">
                  <c:choose>
                    <c:when test="${not empty user.profileImage}">
                      <img src="data:image/jpeg;base64,${user.profileImage}" alt="${user.username}'s profile" class="profile-image">
                    </c:when>
                    <c:otherwise>
                      <img src="${pageContext.request.contextPath}/assets/default-profile.png" alt="Default profile" class="profile-image">
                    </c:otherwise>
                  </c:choose>
                </td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>${user.role}</td>
                <td>${user.createdAt}</td>
                <td class="action-btns">
                  <button class="edit-btn" onclick="openEditModal('${user.userId}', '${user.username}', '${user.email}', '${user.role}')">Edit</button>
                  <button class="delete-btn" onclick="deleteUser('${user.userId}')">Delete</button>
                </td>
              </tr>
            </c:forEach>
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

    function openEditModal(userId, username, email, role) {
      document.getElementById('editUserId').value = userId;
      document.getElementById('editUsername').value = username;
      document.getElementById('editEmail').value = email;
      document.getElementById('editRole').value = role;
      openModal('editUserModal');
    }

    function deleteUser(userId) {
      document.getElementById('deleteUserId').value = userId;
      openModal('deleteUserModal');
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
