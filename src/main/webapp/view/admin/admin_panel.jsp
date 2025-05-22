<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    // Check if user is logged in and is an admin
    if (session.getAttribute("user") == null || !"Admin".equalsIgnoreCase(((model.User)session.getAttribute("user")).getRole())) {
        response.sendRedirect(request.getContextPath() + "/view/login.jsp");
        return;
    }
    
    // Get user info from session
    model.User user = (model.User)session.getAttribute("user");
%>
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

    nav {
      display: flex;
      align-items: center;
      gap: 1.5rem;
    }

    nav a {
      color: #fff;
      text-decoration: none;
    }

    nav a:hover {
      color: #00bfff;
    }

    .user-info {
      color: #00bfff;
      margin-right: 1rem;
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
      <span class="user-info">Welcome, ${user.username}</span>
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
      <div class="section-header">
        <h2>Admin Dashboard</h2>
      </div>

      <div class="analytics-container">
        <div class="card">
          <h3>Total Users</h3>
          <p>${totalUsers}</p>
        </div>
        <div class="card">
          <h3>Total Movies</h3>
          <p>${totalMovies}</p>
        </div>
        <div class="card">
          <h3>Total Reviews</h3>
          <p>${totalReviews}</p>
        </div>
      </div>

    </main>
  </div>
</body>
</html>
