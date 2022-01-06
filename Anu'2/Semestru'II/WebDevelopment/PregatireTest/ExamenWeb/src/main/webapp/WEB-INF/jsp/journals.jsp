<%--
  Created by IntelliJ IDEA.
  User: Sergiu
  Date: 25-Jun-21
  Time: 4:03 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <!--link rel="stylesheet" href="styles/styles.css"-->
    <script src="././js/jquery-3.6.0.min.js"></script>
    <script src="././js/journals.calls.js"></script>
    <meta charset="UTF-8">
    <title>Journals</title>
</head>
<body>
<ul class = "journals-list">

</ul>
<ul class="articles-list">

</ul>

<form class="add-article">
    <label> Journal :
        <input id ="journal-name-input" name="name" type="text" placeholder="Journal Name">
    </label>
    <label> Summary :
        <input id="article-summary" name="summary" type="text" placeholder="Summary">
    </label>
    <input type="submit" value="Add Post">
</form>
</body>
</html>
