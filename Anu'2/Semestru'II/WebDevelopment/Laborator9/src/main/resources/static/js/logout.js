$(document).ready(
    function () {
        $("#logout-button").click(
            function (e) {
                $.ajax({
                    type: "POST",
                    contentType: "application/json",
                    url: "http://localhost:8080/logout/" + localStorage.getItem("logged-user"),
                    cache: false,
                    timeout: 600000,
                    success: (data) => {
                        alert(data)
                    }
                });
                window.location.href = "http://localhost:8080"
                localStorage.clear();
                e.preventDefault();
            }
        );
    }
);