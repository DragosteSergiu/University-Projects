$(document).ready(
    function(){
        $('.login-form').submit(function (e) {
                e.preventDefault();
                //localStorage.setItem('current-user', $('input#username-input').val());
                //window.location.href = '/login';
            const username = $('input[name="username"]').val();
            console.log(username);
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "http://localhost:8080/api/auth",
                data: JSON.stringify(username),
                dataType: 'text',
                cache: false,
                timeout: 600000,
                success: function (data) {
                    console.log("OK");
                    if (data != null) {
                    }
                    localStorage.setItem('username', username);
                    window.location.href = '/login';
                },
                error: function (e) {
                    console.log("Not ok");
                }

            });
            }
        )
    }
);