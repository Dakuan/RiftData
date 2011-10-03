$(document).ready(function () {

    $('form').validationEngine();

    var window = $("#Message").data("tWindow");

    $("#SendMessage").click(function () {

        var message = $("#messageText").attr('value');

        var name = $("#Name").attr('value');

        var email = $("#Email").attr('value');

        var url = $("#SendMessageUrl").attr('value') + '/?message=' + message + '&name=' + name + '&email=' + email;

        if ($('form').validationEngine('validate')) {
            $.getJSON(url, null, function () {
                console.log('email sent'); 
                window.close();
            });
        }
    });

    $(".message").click(function () {

        window.center();

        window.open();
    });
});