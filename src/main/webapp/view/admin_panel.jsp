<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Admin Dashboard - FilmFanatic</title>
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    body {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      background-color: #1e1f29;
      color: #ffffff;
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
      width: 220px;
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
      display: block;
      padding: 0.5rem;
      border-radius: 4px;
    }

    .sidebar a:hover {
      background-color: #3a3b47;
      color: #00bfff;
      transition: all 0.3s ease;
    }

    .main {
      flex: 1;
      padding: 2rem;
    }

    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 2rem;
    }

    .section-header h2 {
      font-size: 1.8rem;
    }

    .analytics-container {
      display: flex;
      flex-wrap: wrap;
      gap: 2rem;
    }

    .card {
      flex: 1 1 250px;
      background-color: #2e2f3e;
      padding: 1.5rem;
      border-radius: 8px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .card h3 {
      font-size: 1.2rem;
      margin-bottom: 0.5rem;
    }

    .card p {
      font-size: 2rem;
      font-weight: bold;
      color: #00bfff;
    }

    .placeholder-chart {
      margin-top: 2rem;
      background-color: #3a3b47;
      height: 300px;
      border-radius: 6px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #bbb;
      font-style: italic;
    }

    @media (max-width: 768px) {
      .dashboard {
        flex-direction: column;
      }

      .sidebar {
        width: 100%;
        display: flex;
        overflow-x: auto;
      }

      .sidebar ul {
        display: flex;
        gap: 1rem;
      }

      .main {
        padding: 1rem;
      }

      .analytics-container {
        flex-direction: column;
      }
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
        <li><a href="${pageContext.request.contextPath}/GetAllUser">Users</a></li>
        <li><a href="Movies.jsp">Movies</a></li>
        <li><a href="Reviews.jsp">Reviews</a></li>
        <li><a href="Analytics.jsp">Analytics</a></li>
      </ul>
    </aside>

    <main class="main">
      <div class="section-header">
        <h2>Admin Dashboard</h2>
      </div>

      <div class="analytics-container">
        <div class="card">
          <h3>Total Users</h3>
          <p>1,234</p>
        </div>
        <div class="card">
          <h3>Total Movies</h3>
          <p>567</p>
        </div>
        <div class="card">
          <h3>Total Reviews</h3>
          <p>2,345</p>
        </div>
      </div>

      <div class="placeholder-chart">
        [ Chart Area - Add with JS or Image if needed ]
      </div>
    </main>
  </div>
</body>
</html>
