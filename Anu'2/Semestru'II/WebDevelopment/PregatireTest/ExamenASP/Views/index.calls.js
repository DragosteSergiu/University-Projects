$(document).ready(
    function () {
        $('.log-form').submit(function (e) {
            e.preventDefault();
            $.ajax({
                type: 'GET',
                url: 'https://localhost:5001/auth/' + $('input#username').val(),
                success: function (res) {
                    if (res != null) {
                        localStorage.setItem('current-user', JSON.stringify(res));
                    } else {
                        alert('Wrong username!');
                    }
                }
            });
        });

        $('.owned-channels-form').submit(function (e) {
            e.preventDefault();
            if (localStorage.getItem('current-user') != null) {
                $.ajax({
                    type: 'GET',
                    url: 'https://localhost:5001/channels/' + $('input#owner-name').val(),
                    success: function (res) {
                        $('.channels-list').empty();
                        $.each(res, function (index, elem) {
                            $('.channels-list').append('<li>' +
                                'Id : ' + elem.id +
                                'Owner Id : ' + elem.ownerId +
                                'Name : ' + elem.name +
                                'Description : ' + elem.description +
                                'Subscribers : ' + elem.subscribers
                                + '</li>');
                        });
                    }
                });
            }
        });

        $('.get-my-channels-form').submit(
            function (e) {
                e.preventDefault();
                $.ajax({
                    type: 'GET',
                    url: 'https://localhost:5001/personal/' + JSON.parse(localStorage.getItem('current-user')).id,
                    success: function (res) {
                        if (res != null) {
                            $.each(res, function (index, elem) {
                                $('.current-channels-list').append('<li>' +
                                    'Owner Id : ' + elem.ownerId +
                                    'Name : ' + elem.name +
                                    'Description : ' + elem.description +
                                    'Subscribers : ' + elem.subscribers
                                    + '</li>');
                            });
                        }
                    }
                });
            }
        );
    }
);