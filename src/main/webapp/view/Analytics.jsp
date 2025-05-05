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

    .chart {
  background-color: #2e2f3e;
  padding: 1.5rem;
  border-radius: 10px;
  height: 700px; 
  margin-top: 1rem;
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.2);
  max-width: 48%; 
  flex: 1; 
  min-width: 300px;
}

    .chart canvas {
      width: 100% !important;
      height: 100% !important;
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
          <h2>Analytics Overview</h2>
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

        <div class="analytics-container">
          <div class="chart">
            <canvas id="moviesChart"></canvas>
          </div>

          <div class="chart">
            <canvas id="genreChart"></canvas>
          </div>
        </div>
      </section>
    </main>
  </div>

  <!-- Chart.js CDN -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script>
    // Movies Chart - Bar Version
    const ctx = document.getElementById('moviesChart').getContext('2d');
    const moviesChart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
        datasets: [{
          label: 'Movies Added',
          data: [12, 19, 3, 5, 2, 3, 7],
          backgroundColor: '#00bfff',
          borderRadius: 6,
          borderSkipped: false,
          barPercentage: 0.6,
          categoryPercentage: 0.7
        }]
      },
      options: {
        plugins: {
          legend: {
            display: false
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

    // Top Genres Chart - Doughnut Version
    const ctx2 = document.getElementById('genreChart').getContext('2d');
    const genreChart = new Chart(ctx2, {
      type: 'doughnut',
      data: {
        labels: ['Action', 'Drama', 'Comedy', 'Horror', 'Sci-Fi'],
        datasets: [{
          label: 'Top Genres',
          data: [300, 200, 100, 50, 75],
          backgroundColor: [
            '#ff6b6b', '#6bafff', '#ffe66d', '#7fffd4', '#c084fc'
          ],
          borderColor: '#1e1f29',
          borderWidth: 2
        }]
      },
      options: {
        cutout: '60%',
        plugins: {
          legend: {
            labels: {
              color: '#ccc',
              boxWidth: 16,
              padding: 20
            }
          },
          tooltip: {
            backgroundColor: '#222',
            titleColor: '#fff',
            bodyColor: '#ccc',
            borderColor: '#888',
            borderWidth: 1
          }
        }
      }
    });
  </script>
</body>

</html>
