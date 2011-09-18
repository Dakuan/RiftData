/// <reference path="2011.1.315/jquery-1.5.1.min.js" />

$(document).ready(function () {

    var successUrl = $('#SuccessUrl').attr('value');

    var failureUrl = $('#FailureUrl').attr('value');

    var window = $("#MessageBox").data("tWindow");

    window.center();

    $('form').validationEngine();

    $('form').submit(function (e) {

        e.preventDefault();

        tinyMCE.triggerSave();

        if ($('form').validationEngine('validate')) {

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
        }
    });
});