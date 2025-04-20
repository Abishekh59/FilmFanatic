<%@ page contentType="text/html; charset=ISO-8859-1" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="ISO-8859-1">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome to FilmFanatic</title>
  <style>
    /* Reset & Base Styles */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
    }

    body, html {
      height: 100%;
      width: 100%;
    }

    /* Background */
    body {
      background-image: url('https://images.unsplash.com/photo-1524985069026-dd778a71c7b4?auto=format&fit=crop&w=1920&q=80');
      background-size: cover;
      background-position: center;
      background-repeat: no-repeat;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    /* Dark Overlay */
    .overlay {
      background: rgba(0, 0, 0, 0.75);
      padding: 3rem 2rem;
      border-radius: 15px;
      text-align: center;
      color: white;
      max-width: 700px;
      width: 90%;
      animation: fadeIn 1.2s ease-out;
    }

    /* Text Styling */
    h1 {
      font-size: 3rem;
      margin-bottom: 1rem;
      color: #e50914;
      letter-spacing: 1px;
    }

    p {
      font-size: 1.1rem;
      margin-bottom: 2.5rem;
      line-height: 1.6;
      color: #f1f1f1;
    }

    /* Button Styling */
    .button-group {
      display: flex;
      justify-content: center;
      gap: 2rem;
      flex-wrap: wrap;
    }

    .button-group button {
      padding: 0.8rem 2rem;
      font-size: 1rem;
      border: none;
      border-radius: 50px;
      cursor: pointer;
      background: #e50914;
      color: white;
      box-shadow: 0 5px 15px rgba(229, 9, 20, 0.3);
      transition: all 0.3s ease-in-out;
    }

    .button-group button:hover {
      background: #b0060f;
      transform: translateY(-2px);
    }

    /* Fade-in Animation */
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(30px); }
      to { opacity: 1; transform: translateY(0); }
    }

    /* Responsive */
    @media (max-width: 600px) {
      h1 {
        font-size: 2rem;
      }

      p {
        font-size: 1rem;
      }

      .button-group {
        flex-direction: column;
        gap: 1rem;
      }
    }
  </style>
</head>
<body>
  <div class="overlay">
    <h1>Welcome to FilmFanatic</h1>
    <p>
      Your ultimate destination for discovering, reviewing, and tracking the latest and greatest movies. Join our community of film lovers and explore curated collections, honest reviews, and more.
    </p>
    <div class="button-group">
      <button onclick="goToLogin()">Login</button>
      <button onclick="goToSignup()">Regester</button>
    </div>
  </div>

  <script>
    function goToLogin() {
      window.location.href = "login.jsp";
    }

    function goToSignup() {
      window.location.href = "register.jsp";
    }
  </script>
</body>
</html>
