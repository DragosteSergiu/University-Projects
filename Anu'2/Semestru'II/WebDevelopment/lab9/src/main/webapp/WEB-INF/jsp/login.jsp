<%--
  Created by IntelliJ IDEA.
  User: Sergiu
  Date: 29-May-21
  Time: 4:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <div id="container" style="display: flex; flex-direction: column">
        <label id="name-label">Name: </label><input type="text" id="name-input">
        <label id="password-label">Password: </label><input type="password" id="password-input">
        <button id="login-button" onclick="login()">Login</button>
    </div>
</body>
    <script>
        let jwt = null;
        function login()
        {
            let data = {username : document.getElementById("name-input").value,
                password : document.getElementById("password-input").value };

            fetch("http://localhost:8080/login", {
                method: "POST",
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data)
            }).then(res => {
                res.json().then(body => {sessionStorage.setItem("jwt", body['jwt']);});
            });
        }
    </script>
</html>
