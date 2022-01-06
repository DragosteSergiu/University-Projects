<%--
  Created by IntelliJ IDEA.
  User: Sergiu
  Date: 25-Jun-21
  Time: 3:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <script src="././js/jquery-3.6.0.min.js"></script>
    <script src="././js/index.calls.js"></script>
    <!--link rel="stylesheet" type="text/css" href="styles/styles.css" /-->
    <title>Login</title>
</head>
<body>
<div class="publishing-houses">
    <p>List of all Publishing Houses: </p>
    <c:forEach items="${pair}" var="mypair">
        <div style="display:flex;">
            <p>Publishing House -> Name: ${mypair.key.name}, URL: ${mypair.key.URL}, Number of books: ${mypair.value}</p>
            <c:if test="${mypair.value == 0}"><button onclick="deletePublishingHouse(${mypair.key.id})">Delete</button></c:if>
        </div>
    </c:forEach>
</div>

<!---form class ='login-form'>
    <label> Username :
        <input id="username-input" name="username" placeholder="Username">
    </label>
    <input type="submit" value="Login">
</---form--->
</body>
<script>
    let URL = "http://localhost:8080/api/";
    function deletePublishingHouse(id){
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: URL + "delete/" + id,
            data: JSON.stringify(id),
            cache: false,
            timeout: 600000,
            success : () => {
                alert("Successfully deleted the post!")
            }
        });
        location.reload();
    }
</script>
</html>
