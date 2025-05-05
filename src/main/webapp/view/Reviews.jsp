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

    .modal {
      display: none; 
      position: fixed;
      z-index: 1;
      left: 0;
      top: 0;
      width: 100%;
      height: 100%;
      overflow: auto;
      background-color: rgba(0, 0, 0, 0.4); 
      padding-top: 60px;
    }

    .modal-content {
      background-color: #2e2f3e;
      margin: 5% auto;
      padding: 20px;
      border: 1px solid #888;
      width: 80%;
      max-width: 600px;
      border-radius: 4px;
    }

    .modal-header {
      font-size: 1.5rem;
      margin-bottom: 1rem;
      color: #fff;
    }

    .modal-body input,
    .modal-body textarea {
      width: 100%;
      padding: 0.5rem;
      margin: 0.5rem 0;
      border: 1px solid #444;
      border-radius: 4px;
      background-color: #3a3b47;
      color: white;
    }

    .modal-footer {
      display: flex;
      justify-content: flex-end;
      margin-top: 1rem;
    }

    .modal-footer button {
      padding: 0.5rem 1rem;
      background-color: red;
      color: white;
      border: none;
      border-radius: 4px;
      cursor: pointer;
    }

    .modal-footer .close {
      background-color: #007bff;
    }
     .sidebar a {
      text-decoration: none; 
      color: white; 
    }

    .sidebar a:hover {
  color: #00bfff;
  text-decoration: none;
  background-color: #3a3b47;
  padding-left: 10px;
  border-radius: 4px;
  transition: all 0.3s ease;
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
    <li><a href="Users.jsp">Users</a></li>
    <li><a href="Movies.jsp">Movies</a></li>
    <li><a href="Reviews.jsp">Reviews</a></li>
    <li><a href="Analytics.jsp">Analytics</a></li>
  </ul>
</aside>

    <main class="main">

      <section class="section">
        <div class="section-header">
          <input type="text" placeholder="Search reviews ..." />
          <button onclick="alert('Add Review')">+ Add Reviews</button>
        </div>
        <table>
          <tr>
            <th>ID</th>
            <th>Movie ID</th>
            <th>User ID</th>
            <th>Comment</th>
            <th>Rating</th>
            <th>Actions</th>
          </tr>
          <tr>
            <td>1</td>
            <td>101</td>
            <td>1</td>
            <td>Great Movie!</td>
            <td>7.1</td>
            <td class="action-btns">
              <button class="edit-btn" onclick="alert('Edit Review')">Edit</button>
              <button class="delete-btn" onclick="alert('Delete Review')">Delete</button>
            </td>
          </tr>
        </table>
      </section>
    </main>
  </div>

  

  <script>
    function openModal() {
      document.getElementById('addMovieModal').style.display = 'block';
    }

    function closeModal() {
      document.getElementById('addMovieModal').style.display = 'none';
    }
  </script>
</body>

</html>
