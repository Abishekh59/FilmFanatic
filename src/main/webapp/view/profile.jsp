<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>FilmFanatic | Profile</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background-color: #0e1525;
            font-family: Arial, sans-serif;
            color: #ffffff;
            min-width: 320px; /* Minimum width to prevent extreme squishing */
        }

        /* Header Styles */
        header {
            background: #141d2f;
            padding: 20px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            flex-wrap: wrap;
            gap: 20px;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #e50914;
            display: flex;
            align-items: center;
            flex-shrink: 0;
        }

        .logo img {
            height: 32px;
            margin-right: 12px;
            filter: brightness(0) saturate(100%) invert(21%) sepia(97%) saturate(7476%) hue-rotate(353deg) brightness(92%) contrast(106%);
        }

        nav {
            display: flex;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            flex: 1;
            justify-content: center;
        }

        nav a {
            color: white;
            text-decoration: none;
            font-size: 1.2rem;
            white-space: nowrap;
        }

        nav a:hover {
            color: #E50815;
        }

        /* Search Bar */
        .search-bar {
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            background-color: #1e2b3a;
            color: white;
            width: 100%;
            max-width: 400px;
            height: 35px;
        }

        .actions {
            display: flex;
            gap: 10px;
            flex-shrink: 0;
        }

        .actions a {
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 6px;
            color: white;
            font-size: 1rem;
            white-space: nowrap;
        }

        .profile {
            background-color: #2980b9;
        }

        .logout {
            background-color: #c0392b;
        }

        /* Profile Section */
        .profile-section {
            padding: 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }

        .profile-card {
            display: flex;
            background: #1c1f2b;
            padding: 1.5rem;
            border-radius: 10px;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 20px;
        }

        .profile-card img {
            border-radius: 50%;
            width: 100px;
            margin-right: 1.5rem;
        }

        .profile-info {
            flex: 1;
            min-width: 300px;
        }

        .profile-info h2 {
            margin-bottom: 0.2rem;
            font-size: 2rem;
        }

        .profile-info .email,
        .profile-info .joined,
        .profile-info .bio {
            font-size: 0.9rem;
            margin-bottom: 5px;
            font-size: 1.3rem;
        }

        .edit-btn {
            margin-top: 10px;
            padding: 10px 16px; 
            background-color: #e50914;
            color: white;
            border: none;
            border-radius: 6px; 
            font-size: 1rem; 
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease; 
        }

        .edit-btn:hover {
            background-color: #c4080b; 
            transform: scale(1.05);
        }

        /* Edit Profile Form */
        .edit-profile-form {
            background: #1c1f2b;
            padding: 1.5rem;
            border-radius: 10px;
        }

        .edit-profile-form input,
        .edit-profile-form textarea {
            width: 100%;
            padding: 10px;
            background: #2a2f3a;
            border: none;
            border-radius: 5px;
            color: white;
            margin-bottom: 10px;
        }

        .edit-profile-form .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .edit-profile-form button {
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        .edit-profile-form .cancel-btn {
            background: #555;
            color: white;
        }

        .edit-profile-form .save-btn {
            background: #e74c3c;
            color: white;
        }

        /* Tabs */
        .tabs {
            margin-top: 2rem;
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .save-message {
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

        .tab-btn {
            background: #2a2f3a;
            color: white;
            padding: 10px 20px;
            margin-right: 10px;
            border: none;
            border-radius: 5px 5px 0 0;
            cursor: pointer;
        }

        .tab-btn.active {
            background: red;
        }

        .tab-content {
            display: flex;
            flex-wrap: wrap;
            gap: 1rem;
            padding-top: 1rem;
        }

        /* Movie Card */
        .movie-card {
            background: #1c1f2b;
            width: 200px;
            border-radius: 10px;
            overflow: hidden;
            flex: 0 0 auto;
        }

        .movie-card img {
            width: 100%;
        }

        .movie-info {
            padding: 10px;
        }

        /* Footer */
        footer {
            display: flex;
            justify-content: space-around;
            background: #1c1f2b;
            padding: 2rem 1rem;
            color: #ccc;
            flex-wrap: wrap;
            gap: 30px;
        }

        .footer-col {
            flex: 1;
            min-width: 250px;
            padding: 0 15px;
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

        /* Media Queries */
        @media screen and (max-width: 768px) {
            header {
                padding: 15px;
            }

            nav {
                order: 3;
                width: 100%;
                justify-content: center;
            }

            .search-bar {
                max-width: 100%;
            }

            .profile-card {
                flex-direction: column;
                text-align: center;
            }

            .profile-info {
                text-align: center;
            }

            .movie-card {
                width: calc(50% - 1rem);
            }
        }

        @media screen and (max-width: 480px) {
            .actions {
                flex-direction: column;
            }

            .movie-card {
                width: 100%;
            }

            .footer-col {
                min-width: 100%;
                text-align: center;
            }
        }
    </style>
</head>

<body>

  <header>
    <div class="logo">
        <img src="https://img.icons8.com/ios-filled/50/ffffff/movie-projector.png" alt="logo"/>
        FilmFanatic
    </div>
    <nav>
    <a href="${pageContext.request.contextPath}/view/dashboard.jsp">Home</a>
    <a href="${pageContext.request.contextPath}/view/movie_list.jsp">Movies</a>
    <a href="${pageContext.request.contextPath}/view/about.jsp">About</a>
    <a href="${pageContext.request.contextPath}/view/contact.jsp">Contact</a>
    <input type="text" class="search-bar" placeholder="Search Movies...">
    <a href="${pageContext.request.contextPath}/view/logout.jsp" class="logout">Logout</a>
</nav>
       <div class="actions">
          <a href="${pageContext.request.contextPath}/view/profile" class="profile">Profile</a>
          <a href="${pageContext.request.contextPath}/view/logout.jsp" class="logout">
             <img src="https://img.icons8.com/material-rounded/24/ffffff/exit.png" alt="Logout Icon"
                  style="vertical-align: middle; margin-right: 5px;" />
                Logout
            </a>
   	 </div>
</header>

  <!-- Profile Section -->
  <section class="profile-section">
    <div class="profile-card">
        <c:choose>
            <c:when test="${not empty user.profileImage}">
                <img src="data:image/jpeg;base64,${user.profileImage}" alt="Profile Picture" style="width: 100px; height: 100px; object-fit: cover;">
            </c:when>
            <c:otherwise>
                <img src="${pageContext.request.contextPath}/images/default-avatar.png" alt="Profile Picture" style="width: 100px; height: 100px; object-fit: cover;">
            </c:otherwise>
        </c:choose>
        <div class="profile-info">
            <h2>${user.username}</h2>
            <p class="email">${user.email}</p>
            <p class="joined">Joined <fmt:formatDate value="${user.createdAt}" pattern="MMMM d, yyyy"/></p>
            <p class="bio">Member of FilmFanatic</p>
            <button class="edit-btn" onclick="showEditForm()">Edit Profile</button>
        </div>
    </div>

    <div class="edit-profile-form" style="display: none;">
        <form action="${pageContext.request.contextPath}/profile" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="update">
            <div class="form-group">
                <label for="profileImage">Profile Picture</label>
                <input type="file" id="profileImage" name="profileImage" accept="image/*">
                <small>Max file size: 5MB. Supported formats: JPG, PNG, GIF</small>
            </div>
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" value="${user.username}" required>
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="${user.email}" required>
            </div>
            <div class="form-group">
                <label for="currentPassword">Current Password</label>
                <input type="password" id="currentPassword" name="currentPassword" placeholder="Enter current password">
            </div>
            <div class="form-group">
                <label for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password">
                <small>Leave blank to keep current password</small>
            </div>
            <div class="form-group">
                <label for="confirmPassword">Confirm New Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password">
            </div>
            <div class="form-actions">
                <button type="button" class="cancel-btn" onclick="hideEditForm()">Cancel</button>
                <button type="submit" class="save-btn">Save Changes</button>
            </div>
        </form>
    </div>


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
    © 2025 FilmFanatic. All Rights Reserved.
  </div>

  <script>
  function showTab(tabId) {
    const tabs = document.querySelectorAll('.tab-btn');
    const contents = document.querySelectorAll('.tab-content');

    tabs.forEach(btn => btn.classList.remove('active'));
    contents.forEach(content => content.style.display = 'none');

    document.getElementById(tabId).style.display = 'flex';
    document.querySelector(`.tab-btn[onclick="showTab('${tabId}')"]`).classList.add('active');
  }

  function showEditForm() {
    document.querySelector('.edit-profile-form').style.display = 'block';
    document.querySelector('.profile-card').style.display = 'none';
  }

  function hideEditForm() {
    document.querySelector('.edit-profile-form').style.display = 'none';
    document.querySelector('.profile-card').style.display = 'flex';
  }

  // Password validation
  document.querySelector('form').addEventListener('submit', function(event) {
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    if (newPassword && newPassword !== confirmPassword) {
      event.preventDefault();
      alert('New passwords do not match!');
    }
    
    if (newPassword && newPassword.length < 8) {
      event.preventDefault();
      alert('Password must be at least 8 characters long!');
    }
  });

  // Add image preview functionality
  document.getElementById('profileImage').addEventListener('change', function(event) {
    const file = event.target.files[0];
    if (file) {
      if (file.size > 5 * 1024 * 1024) { // 5MB limit
        alert('File size must be less than 5MB');
        event.target.value = '';
        return;
      }
      
      const reader = new FileReader();
      reader.onload = function(e) {
        const img = document.querySelector('.profile-card img');
        img.src = e.target.result;
      };
      reader.readAsDataURL(file);
    }
  });
</script>


</body>

</html>
