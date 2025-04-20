<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>About - FilmFanatic</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet"> <!-- Material Icons -->
    <style>
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
            margin: 0 100px;
            font-size: 24px;
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
            font-weight: bold;
            font-size: 14px;
        }

        .container {
            padding: 40px 60px;
            max-width: 1000px;
            margin: auto;
        }

        h2 {
            color: #E50815;
            margin-bottom: 10px;
        }

        .feature-box {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 30px;
        }

        .feature {
            background-color: #1a2433;
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            flex: 1 1 200px;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        .feature:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }

        .feature-icon {
            font-size: 36px;
            color: #E50815;
            margin-bottom: 15px;
        }

        .feature h3 {
            color: white;
            font-size: 20px;
            margin-bottom: 10px;
        }

        .feature p {
            color: #bbb;
            font-size: 14px;
        }

        .tab-buttons {
            display: flex;
            gap: 15px;
            margin-bottom: 25px;
        }

        .tab-buttons button {
            padding: 10px 20px;
            background-color: #1f2a3d;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .tab-buttons button.active {
            background-color: #E50815;
        }

        .faq-section {
            display: none;
            animation: fadeIn 0.4s ease-in-out;
        }

        .faq-section.active {
            display: block;
        }

        .faq-question {
            cursor: pointer;
            padding: 14px 20px;
            margin: 10px 0;
            background-color: #1a2433;
            border: 1px solid #333;
            border-radius: 6px;
            font-weight: bold;
            position: relative;
            transition: background 0.3s;
        }

        .faq-question::after {
            content: '+';
            position: absolute;
            right: 20px;
            font-size: 18px;
        }

        .faq-question.active::after {
            content: '-';
        }

        .faq-answer {
            max-height: 0;
            overflow: hidden;
            background-color: #111c2d;
            transition: max-height 0.3s ease, padding 0.3s ease;
            padding: 0 20px;
            border-radius: 0 0 6px 6px;
        }

        .faq-answer.open {
            max-height: 200px;
            padding: 12px 20px;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        footer {
            background-color: #141d2f;
            text-align: center;
            padding: 20px;
            font-size: 14px;
            color: #888;
        }

        /* Responsive design for smaller screens */
        @media (max-width: 768px) {
            .feature-box {
                flex-direction: column;
                gap: 20px;
            }

            .feature {
                flex: 1 1 100%;
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
        <a href="dashboard.jsp">Home</a>
        <a href="movie_list.jsp">Movies</a>
        <a href="about.jsp">About</a>
        <input type="text" class="search-bar" placeholder="Search Movies...">
    </nav>
            <div class="actions">
            <a href="profile.jsp" class="profile">Profile</a>
             <a href="" class="logout">Logout</a>
        </div>
</header>

<div class="container">
    <section>
        <h2>About FilmFanatic</h2>
        <p>
            Our mission is to create a community where movie enthusiasts can discover, discuss, and share their passion for cinema. 
            We provide a platform for users to find information about movies, rate them, and connect with like-minded film lovers.
        </p>
    </section>

    <section>
        <h2>Features</h2>
        <div class="feature-box">
            <div class="feature">
                <span class="material-icons feature-icon">movie</span>
                <h3>Movie Database</h3>
                <p>Access a comprehensive database of movies with detailed information, posters, and trailers.</p>
            </div>

            <div class="feature">
                <span class="material-icons feature-icon">rate_review</span>
                <h3>Ratings & Reviews</h3>
                <p>Rate movies and share your thoughts with our community through in-depth reviews.</p>
            </div>

            <div class="feature">
                <span class="material-icons feature-icon">person</span>
                <h3>User Profiles</h3>
                <p>Create your profile, build a watchlist, and connect with other movie enthusiasts.</p>
            </div>

            <div class="feature">
                <span class="material-icons feature-icon">group</span>
                <h3>Community</h3>
                <p>Engage in discussions about your favorite films with a community of movie lovers.</p>
            </div>
        </div>
    </section>

    <section>
        <h2>Frequently Asked Questions</h2>

        <div class="tab-buttons">
            <button class="tab-btn active" data-target="general">General</button>
            <button class="tab-btn" data-target="accounts">Accounts</button>
            <button class="tab-btn" data-target="movies">Movies</button>
        </div>

        <div id="general" class="faq-section active">
            <div class="faq-question">What is FilmFanatic?</div>
            <div class="faq-answer">FilmFanatic is a platform for movie enthusiasts to discover, rate, review, and discuss films. We aim to create a community where users can share their passion for cinema and find new movies to enjoy.</div>

            <div class="faq-question">Is FilmFanatic free to use?</div>
            <div class="faq-answer">Yes, FilmFanatic is completely free to use. Create an account and start exploring our movie database, leaving reviews, and connecting with other users.</div>

            <div class="faq-question">How do I contact support?</div>
            <div class="faq-answer">You can reach our support team by sending an email to support@filmfanatic.com or by using the contact form on our Contact page.</div>
        </div>

        <div id="accounts" class="faq-section">
            <div class="faq-question">How do I create an account?</div>
            <div class="faq-answer">You can create an account by clicking on the "Register" button in the top right corner of the page. Fill in your details, agree to our terms of service, and you're ready to go!</div>

            <div class="faq-question">Can I delete my account?</div>
            <div class="faq-answer">Yes, you can delete your account by going to your profile settings and selecting the "Delete Account" option. Please note that this action is irreversible.</div>

            <div class="faq-question">How do I update my profile information?</div>
            <div class="faq-answer">You can update your profile information by going to your profile page and clicking on the "Edit Profile" button. From there, you can update your username, email, password, and profile picture.</div>
        </div>

        <div id="movies" class="faq-section">
            <div class="faq-question">How do I rate a movie?</div>
            <div class="faq-answer">To rate a movie, navigate to the movie's page and use the rating stars to select your rating. You can rate movies from 1 to 5 stars.</div>

            <div class="faq-question">Can I edit or delete my reviews?</div>
            <div class="faq-answer">Yes, you can edit or delete your reviews by going to the movie page where you left the review. Click on the options menu next to your review to edit or delete it.</div>

            <div class="faq-question">How can I suggest a movie to be added to the database?</div>
            <div class="faq-answer">If you'd like to suggest a movie to be added to our database, please use the contact form on our Contact page with details about the movie.</div>
        </div>
    </section>
</div>

<footer>
    &copy; 2025 FilmFanatic. All rights reserved.
</footer>

<script>
    // Tab functionality
    const tabButtons = document.querySelectorAll('.tab-btn');
    const faqSections = document.querySelectorAll('.faq-section');

    tabButtons.forEach(btn => {
        btn.addEventListener('click', () => {
            tabButtons.forEach(b => b.classList.remove('active'));
            faqSections.forEach(sec => sec.classList.remove('active'));

            btn.classList.add('active');
            document.getElementById(btn.dataset.target).classList.add('active');
        });
    });

    // Accordion toggle
    document.querySelectorAll('.faq-question').forEach(question => {
        question.addEventListener('click', () => {
            question.classList.toggle('active');
            const answer = question.nextElementSibling;
            answer.classList.toggle('open');
        });
    });
</script>

</body>
</html>
