$(document).ready(
    function(){
        req = {
            username: localStorage.getItem("username")
        }
        const username = localStorage.getItem("username");
        console.log(username);
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/api/journals?username=" + username,
            //data: $(this).serialize(),
            //data: JSON.stringify(username),
            success: function (res){
                $.each(res, function(index, el) {
                    $('.journals-list').append('<li><a class="navigate-link">'+ el.name + '</a></li>')
                });
                $('.navigate-link').click(
                    function (e){
                        e.preventDefault();
                        $.ajax({
                            type: "GET",
                            url: "http://localhost:8080/api/articles/" + $(this).text()+'?user='+localStorage.getItem("username"),
                            success: function (res){
                                $('.articles-list').empty();
                                $.each(res, function(index, el) {
                                    $('.articles-list').append('<li>'+ el.summary + '</li>')
                                });
                            }
                        });
                    }
                );
            }
        })
        $('.add-article').submit(
            function (e){
                e.preventDefault();
                let today = new Date();
                const dd = String(today.getDate()).padStart(2, '0');
                const mm = String(today.getMonth() + 1).padStart(2, '0'); //January is 0!
                const yyyy = today.getFullYear();
                today = yyyy + '-' + mm + '-' + dd;
                let elem = {"id": null, "date": today, "summary": $('input#article-summary').val(), username: localStorage.getItem("username")};
                console.log(elem);
                $.ajax({
                    type: "POST",
                    url: "http://localhost:8080/api/articles/" +
                        $('input#journal-name-input').val(),
                    contentType: "application/json; charset=utf-8",
                    data: JSON.stringify(elem),
                    success: function (res){
                        alert(res);
                    }
                });
            }
        );
    }
);