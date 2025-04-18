<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - FilmFanatic</title>
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
        .form-box input[type="email"],
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

        .checkbox {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            font-size: 14px;
            margin-top: 10px;
        }

        .checkbox input {
            margin-right: 8px;
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

        .form-box .login-link {
            margin-top: 15px;
            font-size: 14px;
        }

        .form-box .login-link a {
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
        <a href="#" class="login">Login</a>
        <a href="register.jsp" class="register">Register</a>
    </div>
</header>

<div class="container">
    <div class="form-box">
        <img src="https://img.icons8.com/ios-filled/50/ffffff/movie-projector.png" alt="logo" style="height:40px;">
        <h2>Create an Account</h2>
        <form method="post" action="RegisterServlet">
            <label>User name</label>
            <input type="text" name="username" placeholder="Choose a username" required>

            <label>Email address</label>
            <input type="email" name="email" placeholder="Example@email.com" required>

            <label>Password</label>
            <input type="password" name="password" placeholder="********" required>
            <small style="float:left; color: #bbb;">Password must be at least 8 characters long.</small>

            <label>Confirm password</label>
            <input type="password" name="confirmPassword" placeholder="********" required>

            <div class="checkbox">
                <input type="checkbox" required>
                <span>I agree to the <a href="#" style="color: #e74c3c;">Terms of Services</a> and Privacy Policy</span>
            </div>

            <button class="btn" type="submit">Register</button>
        </form>

        <div class="login-link">
            Already have an account? <a href="login.jsp">Log in</a>
        </div>
    </div>
</div>

</body>
</html>
