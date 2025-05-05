<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
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
  </style>
</head>
<body>
  <header>
    <div class="logo">FilmFanatic</div>
    <nav>
      <a href="admin_panel.jsp">Dashboard</a>
      <a href="#">Logout</a>
    </nav>
  </header>

  <div class="dashboard">
    <aside class="sidebar">
      <ul>
        <li><a href="GetAllUser">Users</a></li>
        <li><a href="Movies.jsp">Movies</a></li>
        <li><a href="Reviews.jsp">Reviews</a></li>
        <li><a href="Analytics.jsp">Analytics</a></li>
      </ul>
    </aside>

    <main class="main">
      <section class="section">
        <div class="section-header">
          <input type="text" placeholder="Search Users..." />
          <button onclick="alert('Add User')">+ Add User</button>
        </div>

        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Username</th>
              <th>Email</th>
              <th>Role</th>
              <th>Created At</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            <%
              List<User> userList = (List<User>) request.getAttribute("userList");
              if (userList != null && !userList.isEmpty()) {
                for (User user : userList) {
            %>
              <tr>
                <td><%= user.getUserId() %></td>
                <td><%= user.getUsername() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getRole() %></td>
                <td><%= user.getCreatedAt() %></td>
                <td class="action-btns">
                  <button class="edit-btn" onclick="alert('Edit User ID: <%= user.getUserId() %>')">Edit</button>
                  <button class="delete-btn" onclick="alert('Delete User ID: <%= user.getUserId() %>')">Delete</button>
                </td>
              </tr>
            <%
                }
              } else {
            %>
              <tr>
                <td colspan="6">No users found.</td>
              </tr>
            <%
              }
            %>
          </tbody>
        </table>
      </section>
    </main>
  </div>
</body>
</html>
