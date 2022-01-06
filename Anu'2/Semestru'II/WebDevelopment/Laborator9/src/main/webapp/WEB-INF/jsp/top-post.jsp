<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Top-Posts</title>
</head>
<body>
<h1>Top posts: </h1>
    <c:forEach items="${top}" var="toppost">
        <div class="post-div" style="display: flex">
            <p style="margin-right: 2vw;">Username: ${toppost.value2}</p>
            <p style="margin-right: 2vw">Post: ${toppost.key.description}</p>
            <p style="margin-right: 2vw">Reactions: ${toppost.value}</p>
        </div>
    </c:forEach>
</body>
</html>
