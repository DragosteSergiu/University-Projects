<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
    <script src="/js/jquery-3.6.0.min.js"></script>
    <script src="/js/register.js" defer></script>
    <link rel="stylesheet" href="/css/register.css">
</head>
<body>
    <div class="container">
        <h1>Register</h1>
    <form class="register-form" method="POST">
        <div class="username-div">
        <label>
            Username: <input type="text" name="username" placeholder="Username">
        </label>
        </div>
        <div class="email-div">
        <label>
            Email: <input type="text" name="email" placeholder="email@email.com">
        </label>
        </div>
        <div class="password-div">
        <label>
            Password: <input type="password" name="password" placeholder="Password">
        </label>
        </div>
        <input class="register-button" type="submit" value="Register">
    </form>
    </div>
</body>
</html>
