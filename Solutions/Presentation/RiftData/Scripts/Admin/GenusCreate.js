$(document).ready(function () {

    $('form').validationEngine();

    var successUrl = $('#SuccessUrl').attr('value');

    var failureUrl = $('#FailureUrl').attr('value');

    var window = $("#MessageBox").data("tWindow");

    window.center();

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

function OnLakeChange(data) {
    if (data.value > 0) {
        //get genus types url
        var url = $("#GetGenusTypesUrl").attr('value') + '/' + data.value;
        //perform json get
        $.getJSON(url, function (result) {
            //populate genus types box
            var genusTypesBox = $('#GenusType').data('tDropDownList');

            genusTypesBox.dataBind(result);

            genusTypesBox.select(0);
        });

    }
}