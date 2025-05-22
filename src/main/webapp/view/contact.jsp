<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Home - FilmFanatic</title>
  <style>
    * {
      box-sizing: border-box;
    }

    body {
      margin: 0;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #0e1626;
      color: white;
    }

    header {
      background-color: #141d2f;
      padding: 15px 30px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
    }
     nav a {
            color: white;
            text-decoration: none;
            margin: 0 100px;
            font-size: 24px;
        }

    nav a:hover {
            color: #E50815;
        }

    .logo {
      display: flex;
      align-items: center;
      font-size: 24px;
      font-weight: bold;
      color: #e50914;
    }

    .logo img {
      height: 28px;
      margin-right: 10px;
      filter: brightness(0) saturate(100%) invert(21%) sepia(97%) saturate(7476%) hue-rotate(353deg) brightness(92%) contrast(106%);
    }

    .nav-search-container {
      display: flex;
      align-items: center;
      gap: 20px;
      flex-wrap: wrap;
    }
    
 .search-bar {
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            background-color: #1e2b3a;
            color: white;
            width:400px;
            height: 35px;
        }
         .actions a {
            margin-left: 20px;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            color: white;
            font-size: 20px;
        }


    .profile {
      background-color: #2980b9;
    }

    .logout {
      background-color: #c0392b;
    }

    main {
      max-width: 600px;
      margin: 40px auto;
      padding: 0 20px;
    }

    h2 {
            color: #E50815;
            margin-bottom: 10px;
        }

    form {
      display: flex;
      flex-direction: column;
      gap: 20px;
      margin-top: 30px;
      padding: 25px;
      background-color: #181818;
      border-radius: 10px;
      box-shadow: 0 0 15px rgba(255, 255, 255, 0.05);
    }

    textarea {
      resize: vertical;
      min-height: 80px;
      padding: 10px;
      font-family: inherit;
    }

    input,
    textarea {
      background-color: #1e2b3a;
      border: 1px solid #333;
      color: white;
      padding: 10px;
      border-radius: 5px;
      font-size: 1rem;
    }

    button {
      background-color: #e50914;
      color: white;
      border: none;
      padding: 14px 20px;
      font-size: 1rem;
      border-radius: 6px;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    button:hover {
      background-color: #b0060f;
      transform: scale(1.03);
    }

    .success-message {
      display: none;
      background-color: #e50914;
      padding: 12px;
      margin-top: 20px;
      border-radius: 6px;
      color: white;
      text-align: center;
      font-weight: 500;
      box-shadow: 0 0 10px rgba(27, 126, 52, 0.4);
    }

    @media (max-width: 768px) {
      .nav-search-container {
        flex-direction: column;
        align-items: flex-start;
      }

      .actions {
        flex-direction: column;
        align-items: flex-start;
      }
      
    }
      footer {
      display: flex;
      justify-content: space-around;
      background: #1c1f2b;
      padding: 2rem 1rem;
      color: #ccc;
      flex-wrap: wrap;
    }

    .footer-col h4 {
      margin-bottom: 10px;
    }

    .footer-col a {
      display: block;
      color: #aaa;
      text-decoration: none;
      margin: 5px 0;
    }

    .footer-col p {
      font-size: 0.9rem;
    }

    .copyright {
      background: #111;
      text-align: center;
      padding: 10px;
      font-size: 0.8rem;
      color: #aaa;
    }
  </style>
</head>

<body>
  <header>
    <div class="logo">
      <img src="https://img.icons8.com/ios-filled/50/ffffff/movie-projector.png" alt="logo" />
      FilmFanatic
    </div>
    <div class="nav-search-container">
      <nav>
        <a href="dashboard.jsp">Home</a>
        <a href="movie_list.jsp">Movies</a>
        <a href="about.jsp">About</a>
        <a href="contact.jsp">Contact</a>
      </nav>
      <input type="text" class="search-bar" placeholder="Search Movies..." aria-label="Search Movies" />
    </div>
    <div class="actions">
      <a href="profile.jsp" class="profile">Profile</a>
      <a href="logout.jsp" class="logout">
        <img src="https://img.icons8.com/material-rounded/24/ffffff/exit.png" alt="Logout Icon"
          style="vertical-align: middle; margin-right: 5px;" />
        Logout
      </a>
    </div>
  </header>

  <main>
    <h2>Contact Us</h2>
    <form id="contact-form">
      <label for="name">Your Name:</label>
      <input type="text" id="name" name="name" required />

      <label for="email">Your Email:</label>
      <input type="email" id="email" name="email" required />

      <label for="message">Your Message:</label>
      <textarea id="message" name="message" required></textarea>

      <button type="submit">Send Message</button>
    </form>

    <div class="success-message" id="success-message">
      Thank you! Your message has been sent successfully.
    </div>
  </main>
  <footer>
    <div class="footer-col">
      <h4>FilmFanatic</h4>
      <p>Your one-stop platform for discovering, rating, and reviewing the best movies from around the world.</p>
      <div class="socials" style="display: flex; gap: 15px; margin-top: 10px;">
        <a href="#" style="color:white;"><i class="fab fa-github fa-lg"></i></a>
        <a href="#" style="color:white;"><i class="fab fa-twitter fa-lg"></i></a>
        <a href="#" style="color:white;"><i class="fab fa-facebook fa-lg"></i></a>
        <a href="#" style="color:white;"><i class="fab fa-instagram fa-lg"></i></a>
      </div>
    </div>
    <div class="footer-col">
      <h4>Quick Links</h4>
      <a href="#">Home</a>
      <a href="#">Movies</a>
      <a href="#">About Us</a>
    </div>
    <div class="footer-col">
      <h4>Genres</h4>
      <a href="#">Action</a>
      <a href="#">Comedy</a>
      <a href="#">Drama</a>
      <a href="#">Horror</a>
      <a href="#">Sci-Fi</a>
    </div>
    <div class="footer-col">
      <p>123 Movie Street, Damak-7</p>
      <p>+023 560908</p>
      <p>info@filmfanatic.com</p>
    </div>
  </footer>

  <div class="copyright">
    � 2025 FilmFanatic. All Rights Reserved.
  </div>

  <script>
    const form = document.getElementById("contact-form");
    const successMessage = document.getElementById("success-message");

    form.addEventListener("submit", function (event) {
      event.preventDefault();
      successMessage.style.display = "block";

      setTimeout(() => {
        successMessage.style.display = "none";
      }, 3000);

      form.reset();
    });
  </script>
</body>

</html>
