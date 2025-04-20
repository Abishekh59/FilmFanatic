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
      min-height: 100vh;a
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

    header nav a {
      color: #fff;
      margin-right: 1.5rem;
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
  </style>
</head>

<body>
  <header>
    <div class="logo">FilmFanatic</div>
    <nav>
      <a href="dashboard.jsp">Home</a>
      <a href="movie_list.jsp">Movies</a>
      <a href="about.jsp">About</a>
      <input type="text" placeholder="Search Movies..." />
      <a href="#">Logout</a>
    </nav>
  </header>

  <div class="dashboard">
    <aside class="sidebar">
      <ul>
        <li>Users</li>
        <li>Movies</li>
        <li>Reviews</li>
        <li>Analytics</li>
      </ul>
    </aside>

    <main class="main">
      <section class="section">
        <div class="section-header">
          <input type="text" placeholder="Search..." />
          <button onclick="alert('Add User')">+ Add User</button>
        </div>
        <table>
          <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Role</th>
            <th>Actions</th>
          </tr>
          <tr>
            <td>1</td>
            <td>abishekh_joshi</td>
            <td>joshiabishekh987@gmail.com</td>
            <td>Admin</td>
            <td class="action-btns">
              <button class="edit-btn" onclick="alert('Edit User')">Edit</button>
              <button class="delete-btn" onclick="alert('Delete User')">Delete</button>
            </td>
          </tr>
        </table>
      </section>

      <section class="section">
        <div class="section-header">
          <input type="text" placeholder="Search Movies..." />
          <button onclick="alert('Add Movie')">+ Add Movies</button>
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
</body>

</html>
