<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - FilmFanatic</title>
    <style>
        body {
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0b1622;
            color: #fff;
        }

        header {
            background-color: #141d2f;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            color: white;
        }

        .logo img {
            height: 28px;
            margin-right: 10px;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
        }

        .search-bar {
            padding: 6px 12px;
            border-radius: 5px;
            border: none;
            background-color: #1e2b3a;
            color: white;
        }

        .actions a {
            margin-left: 15px;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 5px;
            color: white;
            font-weight: bold;
        }

        .login {
            background-color: transparent;
        }

        .register {
            background-color: #e74c3c;
        }

        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 90vh;
        }

        .form-box {
            background-color: #1c2a3a;
            padding: 30px;
            border-radius: 12px;
            width: 350px;
            text-align: center;
        }

        .form-box h2 {
            margin-bottom: 20px;
        }

        .form-box input[type="text"],
        .form-box input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 6px;
            border: none;
            background-color: #2d3e50;
            color: white;
        }

        .form-box label {
            display: block;
            text-align: left;
            margin-top: 10px;
            font-size: 14px;
        }

        .form-box .btn {
            margin-top: 20px;
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            background-color: #e74c3c;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .form-box .register-link {
            margin-top: 15px;
            font-size: 14px;
        }

        .form-box .register-link a {
            color: #e74c3c;
            text-decoration: none;
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
        <a href="#">Home</a>
        <a href="#">Movies</a>
        <a href="#">About</a>
        <input type="text" class="search-bar" placeholder="Search Movies...">
    </nav>
    <div class="actions">
        <a href="login.jsp" class="login">Login</a>
        <a href="register.jsp" class="register">Register</a>
    </div>
</header>

<div class="container">
    <div class="form-box">
        <img src="https://img.icons8.com/ios-filled/50/ffffff/movie-projector.png" alt="logo" style="height:40px;">
        <h2>Login to Your Account</h2>
        <form method="post" action="LoginServlet">
            <label>Username</label>
            <input type="text" name="username" placeholder="Enter username" required>

            <label>Password</label>
            <input type="password" name="password" placeholder="********" required>

            <button class="btn" type="submit">Login</button>
        </form>

        <div class="register-link">
            Don't have an account? <a href="register.jsp">Register now</a>
        </div>
    </div>
</div>

</body>
</html>
