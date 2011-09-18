$(document).ready(function () {

    var successUrl = $('#SuccessUrl').attr('value');

    var failureUrl = $('#FailureUrl').attr('value');

    var window = $("#MessageBox").data("tWindow");

    window.center();

    $('form').validationEngine();

    $('form').submit(function (e) {

        e.preventDefault();

        window.center();

        window.open();

        $.post($(this).attr("action"), $(this).serialize(), function (json) {
            // handle response
            if (json) {

                window.ajaxRequest(successUrl);

            }
            else {

                window.ajaxRequest(failureUrl);

            }

            window.center();

        }, "json");
    });
});