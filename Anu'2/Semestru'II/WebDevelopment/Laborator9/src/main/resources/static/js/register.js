$(document).ready( function(){
    $(".register-form").submit(function (e) {
        const req = {
            username: $('input[name="username"]').val(),
            email: $('input[name ="email"]').val(),
            password: $('input[name="password"]').val(),
        }
        console.log(req);
        $.ajax({
            type: "POST",
            contentType: "application/json",
            url: "http://localhost:8080/register",
            data: JSON.stringify(req),
            dataType: 'json',
            cache: false,
            timeout: 600000,
            success: function (data) {
                if (data != null) {
                    alert("Succesfully registered!");
                    window.location.href = '/';
                }
            },
            error: function (e) {
                alert(e);
            }

        });
        e.preventDefault();
    });
});