<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home</title>
    <script src="/js/jquery-3.6.0.min.js"></script>
    <script src="/js/logout.js"></script>
    <link rel="stylesheet" href="/css/home-style.css">
</head>
<body>
<div class="container">
    <h1>Hello ${username}</h1>

    <button id="logout-button">Logout</button>

    <div class="posts-container">
        <p>List of all posts: </p>
        <c:forEach items="${posts}" var="post">
            <div style="display:flex;">
                <p>Author: ${post.key}</p>
                <p>Text: ${post.value.description}</p>
                <p>Number of reactions: ${post.value3}</p>
                <c:if test="${post.key == username}"><button onclick="deletePost(${post.value.id})">Delete</button></c:if>
                <c:if test="${post.value2 == true}"><button onclick="deleteReaction(${post.value.id})">Dislike</button></c:if>
                <c:if test="${post.value2 == false}"><button onclick="saveReaction(${post.value.id})">Like</button></c:if>
            </div>
        </c:forEach>
    </div>

    <form class = "add-post-form">
        <label>
            <input name = "text" class="add-text-input" placeholder="Description">
        </label>
        <input class ="add-post-button" type="submit" value="Add a post!">
    </form>

    <div class="top-posts">
        <button class="top-posts-button" onclick="topPosts()">Top posts</button>
    </div>
</div>
</body>
<script>
    let URL = "http://localhost:8080/posts";
    function topPosts(){
        $.ajax({
            type: "GET",
            contentType: "application/json",
            url: "http://localhost:8080/top",
            cache: false,
            timeout: 600000,
            success: (data) => {
                console.log(data);
            }

        });
        window.location.href = '/top';
    }
    function deletePost(id){
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: URL + "/delete/" + localStorage.getItem("logged-user"),
            data: JSON.stringify(id),
            cache: false,
            timeout: 600000,
            success : () => {
                alert("Successfully deleted the post!")
            }
            });
            location.reload();
    }

    function deleteReaction(id){
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "http://localhost:8080" + "/delete-reaction/" + localStorage.getItem("logged-user"),
            data: JSON.stringify(id),
            cache: false,
            timeout: 60000,
            success : () => {
            }
        });
        location.reload();
    }

    function saveReaction(id){
        let req = {
            user_id : localStorage.getItem("logged-user"),
            post_id: id
        }
        console.log(req);
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "http://localhost:8080" + "/save-reaction/",
            data: JSON.stringify(req),
            dataType: 'json',
            cache: false,
            timeout: 60000,
            success : () => {
            }
        });
        location.reload();
    }

    $(document).ready(function(){
    $(".add-post-form").submit(
        function (e){
            let req = {
                description : $('input[name=text]').val(),
                user : localStorage.getItem('logged-user')
            };
            $.ajax({
                type : "POST",
                contentType: "application/json",
                url: URL + "/save/" + localStorage.getItem("logged-user"),
                data: JSON.stringify(req),
                dataType: 'json',
                cache: false,
                timeout: 600000,
                success :  () => {
                    alert("Successfully saved the post!")
                }
            });
            e.preventDefault();
            location.reload();
        }
    );})
</script>
</html>
