function check(){
    return (localStorage.getItem('session') === "true") && (localStorage.getItem('logged-user') != null);
}

function navigateToRegister(){
    $('#register-button').click(function(e) {
        $.ajax({
            type: "GET",
            url: "http://localhost:8080/register",
            success: function (data) {
                console.log(data);
                if (data != null) {
                    window.location.href = '/register';
                }
            },
            error: function (e) {
                alert(e);
            }
        })
    })
}

function login(){

}

$(document).ready( function (){
    if(!check()) {
        $(".login-form").submit(function (e) {
            const req = {
                username: $('input[name="username"]').val(),
                password: $('input[name="password"]').val(),
            }
            console.log(req);
            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "http://localhost:8080/auth",
                data: JSON.stringify(req),
                dataType: 'json',
                cache: false,
                timeout: 600000,
                success: function (data) {
                    console.log(data);
                    if (data != null) {
                        localStorage.setItem('username', data.username);
                        localStorage.setItem('logged-user', data.id);
                        localStorage.setItem('session', "true");
                        alert("Succesfully logged in!");
                        window.location.href = '/logged-in?username=' + req.username + '&id=' + data.id;
                    }
                },
                error: function (e) {
                    alert(e);
                }

            });
            e.preventDefault();
        });
    }else{
        console.log("bad");
        window.location.href = '/logged-in?username=' + localStorage.getItem('username') + '&id=' + localStorage.getItem('logged-user');
    }
    navigateToRegister();
    }
);