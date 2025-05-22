<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
  <title>Analytics - FilmFanatic</title>
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

    .analytics-container {
      display: flex;
      justify-content: space-between;
      gap: 2rem;
      flex-wrap: wrap;
    }

    .card {
      background-color: #2e2f3e;
      padding: 1.5rem;
      border-radius: 6px;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      flex: 1;
    }

    .card h3 {
      margin-bottom: 1rem;
      font-size: 1.25rem;
    }

    .card p {
      font-size: 2rem;
      margin-bottom: 1rem;
    }

    .chart-container {
      background-color: #2e2f3e;
      padding: 1.5rem;
      border-radius: 10px;
      margin-top: 2rem;
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    .chart-container canvas {
      width: 100% !important;
      height: 400px !important;
    }

    /* Remove chart styles */
</style>
  
</head>

<body>
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
          <h2>Analytics Overview</h2>
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

        <div class="chart-container">
          <canvas id="analyticsChart"></canvas>
        </div>
      </section>
    </main>
  </div>

  <!-- Chart.js CDN -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script>
    // Get the data from the server
    const totalUsers = ${totalUsers};
    const totalMovies = ${totalMovies};
    const totalReviews = ${totalReviews};

    // Create the chart
    const ctx = document.getElementById('analyticsChart').getContext('2d');
    const analyticsChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['Users', 'Movies', 'Reviews'],
        datasets: [{
          label: 'Total Count',
          data: [totalUsers, totalMovies, totalReviews],
          backgroundColor: [
            '#00bfff',  // Blue for Users
            '#ff6b6b',  // Red for Movies
            '#7fffd4'   // Teal for Reviews
          ],
          borderRadius: 6,
          borderSkipped: false,
          barPercentage: 0.6,
          categoryPercentage: 0.7
        }]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false
          },
          title: {
            display: true,
            text: 'Platform Statistics',
            color: '#fff',
            font: {
              size: 18
            }
          },
          tooltip: {
            backgroundColor: '#222',
            titleColor: '#fff',
            bodyColor: '#ddd',
            borderColor: '#00bfff',
            borderWidth: 1
          }
        },
        scales: {
          x: {
            grid: {
              color: '#444'
            },
            ticks: {
              color: '#ccc'
            }
          },
          y: {
            grid: {
              color: '#444'
            },
            ticks: {
              color: '#ccc'
            }
          }
        }
      }
    });
  </script>
</body>

</html>
