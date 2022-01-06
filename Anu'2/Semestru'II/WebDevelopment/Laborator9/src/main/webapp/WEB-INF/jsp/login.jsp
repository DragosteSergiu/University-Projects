<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
    <script src="/js/jquery-3.6.0.min.js"></script>
    <script src="/js/login.js" defer></script>
    <link rel="stylesheet" href="/css/login.css">
</head>
<body>
<div id="container" style="display: flex; flex-direction: column">
    <center><h1>Login</h1></center>
    <form class="login-form" method="POST">
        <div class="username-div">
        <label> Username :
            <input name = "username" placeholder="Username" type="text">
        </label>
        </div>
        <div class="password-div">
        <label> Password :
            <input name = "password" placeholder="Password" type="password">
        </label>
        </div>
        <div class="buttons-div" style="display: flex; text-align: center; justify-content: center">
        <input type="submit" value="Login" id = "login-submit-button">
        <button id="register-button">Register</button>
        </div>
    </form>

</div>
</body>

</html>
