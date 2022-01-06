<%--
  Created by IntelliJ IDEA.
  User: Sergiu
  Date: 29-May-21
  Time: 5:14 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
</head>
<body>
<div id="container">
    <button id="get-all-button" onclick="getUsers()">Get all users</button>
    <div id="users-div">

    </div>
</div>
</body>
<script>
    function getUsers()
    {
        users = [ ];
        console.log(sessionStorage.getItem('jwt'));
        fetch("http://localhost:8080/users", {
            method: "GET",
            headers: {'Content-Type': 'application/json', 'Authorization' : 'Bearer ' + sessionStorage.getItem('jwt')}
        }).then(res => {
            res.json().then(body => {console.log(body);});
        });
    }
</script>
</html>
